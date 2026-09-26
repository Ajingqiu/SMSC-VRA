function [A,W,Z,G,F,iter,obj,alpha] = SMSC_VRA_run(X,Y,beta, lambda,d,numanchor,gamma)
% m      : the number of anchor. the size of Z is m*n.
% lambda : the hyper-parameter of regularization term.
% X      : n*di

%% initialize
maxIter = 50 ; % the number of iterations

m = numanchor;
numclass = length(unique(Y));
numview = length(X);
numsample = size(Y,1);

W = cell(numview,1);    % di * d
A = zeros(d,m);         % d  * m

lambda1 = 0.000001;

for i = 1:numview
   di = size(X{i},2);
   W{i} = zeros(di,d);
   X{i} = full(X{i});
   X{i} = mapstd(X{i}',0,1); % turn into d*n
end
Z = zeros(m,numsample); % m  * n
W_mat = zeros(numview, numview);
for  i = 1:numview
    for j = i+1:1:numview
    W_mat(i,j) = norm(X{i}*X{i}','fro')^2 + norm(X{j}*X{j}','fro')^2  - 2*norm(X{i}*X{j}','fro')^2;
    W_mat(j,i) = W_mat(i,j); 
    end
end
W_mat;
D_mat = sum(W_mat, 2);

weight = (D_mat)./ sum(D_mat);


weight1 = ones(numview,1) ./ numview;
alpha = (1-lambda)*weight1 + lambda*weight;

Z(:,1:m) = eye(m);
%Initilize G,F
G = eye(m,numclass);
F = eye(numclass,numsample); 


% alpha = ones(1,numview)/numview;
opt.disp = 0;

flag = 1;
iter = 0;
%%
while flag
    iter = iter + 1;
    alpha;
    %% optimize W_i
    AZ = A*Z; 
    for iv=1:numview
        % disp(size(AZ));
        C = X{iv}*AZ';      
        [U,~,V] = svd(C,'econ');
        W{iv} = U*V';
    end
 options = optimset( 'Algorithm','interior-point-convex','Display','off'); % interior-point-convex
    %% optimize A
    sumAlpha = 0;
    part1 = 0;
        
    for ia = 1:numview
        al2 = alpha(ia)^2;
        sumAlpha = sumAlpha + al2;
        part1 = part1 + al2 * Z*X{ia}'*W{ia};
    end 
    
   A = part1'*pinv(gamma*eye(m)+sumAlpha*Z*Z'-beta*Z*Z');
 
    %% optimize Z
    H = 2*sumAlpha*A'*A+2*lambda1*eye(m)+2*eye(m)-2*beta*A'*A;
  
    
    H = (H+H')/2;
    for ji=1:numsample
        ff=0;
        e = F(:,ji)'*G';
        for j=1:numview
            C = W{j} * A;
            ff = ff - 2*alpha(j)^2*X{j}(:,ji)'*C ;
        end
        ff = ff - 2*lambda1*e;
        Z(:,ji) = quadprog(H,ff',[],[],ones(1,m),1,zeros(m,1),ones(m,1),[],options);
    end

    %% optimize G
    J = Z*F';      
    [Ug,~,Vg] = svd(J,'econ');
    G = Ug*Vg';
    
    %% optimize F
    F=zeros(numclass,numsample);
    for i=1:numsample
        Dis=zeros(numclass,1);
        for j=1:numclass
            Dis(j)=(norm(Z(:,i)-G(:,j)))^2;
        end
        [~,r]=min(Dis);
        F(r(1),i)=1;
    end

    %% optimize alpha
    M = zeros(numview,1);
    for iv = 1:numview
        M(iv) = norm( X{iv} - W{iv} * A * Z,'fro')^2;
    end
    weight1 = M./sum(M);
    alpha = (1-lambda)*weight1 + lambda*weight;
    
    %%
    term1 = 0;
    for iv = 1:numview
        term1 = term1 + alpha(iv)^2 * norm(X{iv} - W{iv} * A * Z,'fro')^2;
    end
    term2 = lambda1 * norm(Z - G * F,'fro')^2 - beta*trace(A*Z*Z'*A');
    obj(iter) = term1+ term2;
    % disp(1111);
    iter;
    if (iter==15) 
        flag = 0;
        % alpha
    end
end
         
         
    
