function [L]=SMSC_VRA_core(X,d,l,k,lambda)
% 1/2*alpha^2*|X(v)_t-Hg*Pg|+beta*|Pg-CgAS|+lambda*|S-G*F|
% X: m*n
% s: number of community
% d: number of anchor
% l: number of bases
% k: cluster number
% lambda: parameters
% options: maxiter,isnorm

maxiter=40;

%% initialize 
num_view = length(X);
num_sample = size(X{1},2);
lambda1 = 0.00001;
%% compute view self-representation
for v = 1:num_view
    X{v} = X{v}';
end
num_sample = size(X{1},2);

%% compute view self-representation

 for v=1:num_view
        X{v} = zscore(X{v});
 end

W_mat = zeros(num_view, num_view);
for  i = 1:num_view
    for j = i+1:1:num_view
    W_mat(i,j) = norm(X{i}*X{i}','fro')^2 + norm(X{j}*X{j}','fro')^2  - 2*norm(X{i}*X{j}','fro')^2;
    W_mat(j,i) = W_mat(i,j); 
    end
end
D_mat = sum(W_mat, 2);
weight = (D_mat)./ sum(D_mat);
weight1 = ones(num_view,1) ./ num_view;
alpha = (1-lambda)*weight1 + lambda*weight;


Z = cell(num_view,1);
H = cell(num_view,1);
m=k;

P=cell(num_view,1);
for i=1:num_view
    Z{i} = eye(3*m,num_sample);
    P{i} = eye(3*m,d);
end

A=eye(d,l);
S=zeros(l,num_sample);
S(:,1:l) = eye(l);
G = eye(l,k);
F = eye(k,num_sample); 

flag = 1;
iter = 0;
%%
while flag
    iter = iter + 1;
%% Update H
    
    for i = 1:num_view
        H{i} = X{i}*Z{i}';
    end
    
%% Update Z
    
    for i = 1:num_view
        tem = X{i}'*H{i} + alpha(i)^2*S'*A'*P{i}';
        [U,~,V] = svd(tem,'econ');
        tem = U*V';
        Z{i} = tem';
    end   
%% Update P_i
    
    AS = A*S; 
    parfor i=1:num_view
        C = Z{i}*AS';      
        [U,~,V] = svd(C,'econ');
        P{i} = U*V';
    end
   
%% Update A
    
    sumAlpha = 0;
    part1 = 0;
    for i = 1:num_view
        al2 = alpha(i)^2;
        sumAlpha = sumAlpha + al2;
        part1 = part1 + al2 * P{i}' * Z{i} * S';
    end
    [Unew,~,Vnew] = svd(part1,'econ');
    A = Unew*Vnew';
    
%% Update S
    
    HS = 2*sumAlpha*eye(l)+2*lambda1*eye(l);
    HS = (HS+HS')/2;
    options = optimset( 'Algorithm','interior-point-convex','Display','off'); % interior-point-convex
    parfor ji=1:num_sample
        ff=0;
        e = F(:,ji)'*G';
        for j=1:num_view
            C = P{j} * A;
            ff = ff - alpha(j)^2*2*Z{j}(:,ji)'*C - 2*lambda1*e;
        end
        S(:,ji) = quadprog(HS,ff',[],[],ones(1,l),1,zeros(l,1),ones(l,1),[],options);
    end
   

    
%% Update G
    S_normlize=zscore(S);
    J = S_normlize*F';      
    [Ug,~,Vg] = svd(J,'econ');
    G = Ug*Vg';
    
    %% Update F
   
    F=zeros(k,num_sample);
    for iff=1:num_sample
        Dis=zeros(k,1);
        for jf=1:k
            Dis(jf)=(norm(S(:,iff)-G(:,jf)))^2;
        end
        [~,r]=min(Dis);
        F(r(1),iff)=1;
    end
 
%% Update alpha beta
        for i = 1:num_view
            weight1(i) = norm(Z{i} - P{i}*A * S,'fro')^2;
        end
        weight1 = weight1./sum(weight1);
        alpha = (1-lambda)*weight1 + lambda*weight;

%% compute obj
    
    
   oo = 0;
   for i = 1:num_view
        oo = oo + norm(X{i} - H{i} * Z{i},'fro')^2 +  alpha(i)^2*norm(Z{i} - P{i}*A * S,'fro')^2;
   end
   obj(iter) = oo + lambda1*norm(S - G * F,'fro')^2;
    if (iter>2) && (abs((obj(iter)-obj(iter-1))/(obj(iter)))<1e-5 || iter>maxiter)
        flag =0;
    end
    
end

%% classifier

[~,L]=max(F);
output.S=S;
output.F=F;
output.loss=obj;

end



