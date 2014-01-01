%% Load data and seeting up path
% This section is used to load the 100k dataset
% Assignment-3 Collaborative filtering 
% Nipun Batra & Manoj Gulati
 
clear;
clc;
u=load('C:\Users\Omkar\Dropbox\CF_Task\Matrix_completion\ml-100k\ml-100k\u.data');
addpath(genpath('C:\Users\Omkar\Dropbox\CF_Task\Matrix_completion'));

%% Choosing number of factors
f=20;        

%% Sanity checks to see if data is right
u(1:10,:)

%% Creating Ratings matrix- R

num_users=max(u(:,1));
num_movies=max(u(:,2));
R=zeros(num_users,num_movies);

%Filling entries 
for i=1:size(u(:,1))
    user=u(i,1);
    movie=u(i,2);
    rating=u(i,3);
    R(user,movie)=rating;
end

%% Sanity check on the sparsity level

sparsity_level_R_matrix=sum(R(:)==0);
entries=num_movies*num_users-sparsity_level_R_matrix;

%Confirm if entries is 10K

disp(entries==size(u,1));

%% Creating subset of dataset for "faster" results
%R=R(,:);

%% Creating 5 cross validation sets 
Y=zeros(5,num_users,num_movies);
for j = 1:5
    for i=1:20000
         user=u((j-1)*20000+i,1);
         movie=u((j-1)*20000+i,2);
         rating=u((j-1)*20000+i,3);
         Y(j,user,movie)=rating;
    end
end

%Size of matrix 
size_matrix=num_users*num_movies;

%% Doing NNMF and obtaining NMAE

NMAE_NNMF=zeros(5,1);
for i=1:5
    [P,Q] = nnmf(reshape(Y(i,:,:),[num_users num_movies]), f);
    XRecon = P*Q;
    %NMAE_NNMF(i)=norm(R - XRecon)/norm(R);
    NMAE_NNMF(i)=norm(R - XRecon)/size_matrix;
end

%% Plotting NNMF results
figure(1);
bar(NMAE_NNMF);
title('NMAE for NNMF different CV sets');
xlabel('CV set');
ylabel('NNMF');

%% Incremental Rank Power Factorization
NMAE_IRPF=zeros(5,1);

for i=1:1 
    temp = reshape(Y(i,:,:),[num_users num_movies]);
    IDX = find(temp);
    M = temp>0;
    S.type = '()';
    S.subs{:} = IDX;
    A = @(X) subsref(X,S);
    Ah = @(X) subsasgn(zeros(num_users,num_movies),S,X);
    AhA = @(X) X.*M;
    XRecon = irpf_operator_cg(A, Ah, AhA, temp(IDX), [num_users,num_movies], f,f+1);
    %NMAE_IRPF(i)=norm(XRecon-R)/norm(R);
    NMAE_IRPF(i)=norm(XRecon-R)/size_matrix;
end

%% Plotting IRPF results
figure(2);
bar(NMAE_IRPF);
title('NMAE for IRPF different CV sets');
xlabel('CV set');
ylabel('IRPF');

%% Fixed Point Continuation

NMAE_FPC=zeros(5,1);
for i=1:1
    %For now just loop once to save time
    temp=reshape(Y(i,:,:),[num_users num_movies]);
    IDX = find(temp);    
    mu_final = 0.1;
    [U,S,V,numiter] = FPC([num_users, num_movies],IDX,temp(IDX),mu_final);
    XRecon = U*S*V';
    %NMAE_FPC(i)=norm(R-XRecon,'fro')/norm(R,'fro');
    NMAE_FPC(i)=norm(R-XRecon,'fro')/size_matrix;
end

%% Plotting FPC results

figure(3);
bar(NMAE_FPC);
title('NMAE for FPC different CV sets');
xlabel('CV set');
ylabel('FPC');

%% Singular Value Thresholding

NMAE_SVT=zeros(5,1);
for i=1:1
    %For now just loop once
    temp=reshape(Y(i,:,:),[num_users num_movies]);
    IDX = find(temp);
    tau = 5*sqrt(num_users*num_movies);
    %IDX = find(reshape(M(i,:,:),[s num_users num_movies]));
    delta = 1.2*length(IDX)/(num_users*num_movies);
    [U,S,V,numiter] = SVT([num_users num_movies],IDX,temp(IDX),tau,delta);
    XRecon = U*S*V';
    %NMAE_SVT(i)=norm(R-XRecon,'fro')/norm(R,'fro');
    NMAE_SVT(i)=norm(R-XRecon,'fro')/size_matrix;
end

%% Plotting SVT results

figure(4);
bar(NMAE_SVT);
title('NMAE for SVT different CV sets');
xlabel('CV set');
ylabel('SVT');

%% Matrix factorization using Custom NNMF

K = 20;
steps = 500;
alpha = 2e-3;
beta = 2e-2;

NMAE_Custom_NNMF=zeros(5,1);
% for i=1:1
    %For now just loop once to save time
    temp=reshape(Y(i,:,:),[num_users num_movies]);
    disp('Check0');
    [P,Q] = custom_nnmf(temp, K, steps, alpha, beta );
    disp('Check1');
    XRecon = P*Q;
    disp('Check2');
    %NMAE_FPC(i)=norm(R-XRecon,'fro')/norm(R,'fro');
    NMAE_Custom_NNMF(i) = norm(R-XRecon)/size_matrix;
    disp('Check3');
% end

%% Plotting Custom NNMF results

figure(5);
bar(NMAE_Custom_NNMF);
title('NMAE for Custom NNMF different CV sets');
xlabel('CV set');
ylabel('Custom NNMF');

%% To save whole workspace as mat file to avoid future computation

save 09_11_2013.mat 

%% Acknowledgements:

% 1. Ms.Anupriya Gogna
% 2. http://www.quuxlabs.com/blog/2010/09/matrix-factorization-a-simple-tutorial-and-implementation-in-python/
% 3. sites.google.com/site/igorcarron2/matrixfactorizations
% 4. http://nuit-blanche.blogspot.in/2011/08/current-jungle-in-matrix-factorization.html
% 5. www.mathworks.com/help/stats/nnmf.html?
% 6. http://mr.usc.edu/download/irpf IRPF Implementation from Justin Haldar
