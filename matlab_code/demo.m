clear;
clc;
warning off;
addpath(genpath('./'));


for data = {  'BDGP_fea.mat'}
    data_name1 = data{1};
    disp(data_name1);
    load(data_name1);
    
    f = fopen('result_BDGP','a+');
    fprintf(f, [data_name1,':\n']);
    fclose(f);
    k = length(unique(Y));
    view_num = length(X);
     
    %% para setting
    % anchor = [k 2*k 3*k]; 
    % d = [k  2*k 3*k];
    % lambda = 0:0.1:1; 
    % beta = [0.01,0.1,1];
    anchor = [15]; 
    d = [10];
    lambda =[1]; 
    beta = [0.01];
    
    %%
     for ib = 1:length(beta)
        for ichor = 1:length(anchor)
        for id = 1:length(d)
              for j = 1:length(lambda)

            tic;
            [A,W,Z,G,F,iter,obj,alpha] = SMSC_VRA_run(X,Y, 1/view_num, lambda(j),d(id),anchor(ichor), beta(ib)); % X,Y,lambda,d,numanchor
            
            
            [~,idx]=max(F);
            res = Clustering8Measure(Y,idx); % [ACC nmi Purity Fscore Precision Recall AR Entropy]
        time = toc
        ACC =res(1);
        NMI = res(2);
        Pur = res(3);
        F1 = res(4);
        ARI = res(7);
        f = fopen('result_BDGP','a+');
        fprintf(f,' beta"%12.6f  lambda:%12.6f d:%d m:%d   Res:AC: %12.6f NMI:%12.6f Pur: "%12.6f F1: "%12.6f  ARI: "%12.6f \n',[beta(ib) lambda(j) d(id) anchor(ichor)  ACC NMI Pur F1 ARI]);
        fclose(f);
         
         clear A W Z G F iter obj alpha
              end
        end
        end
    end
    clear resall objall X Y k
end


