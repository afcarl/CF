clear all
clc

m = 1000; n = 1500; f = 20;

P0 = rand(m,f);
Q0 = rand(n,f);
R0 = P0*Q0';
M = createSamplingScheme ([m n], 'random', 0.2);
Y = M.*R0;
IDX = find(M);

S.type = '()';
S.subs{:} = IDX;

A = @(X) subsref(X,S);
Ah = @(X) subsasgn(zeros(m,n),S,X);
AhA = @(X) X.*M;

%% Non-Negative Matrix Factorization
[P,Q] = nnmf(Y, 20);
XRecon = P*Q;
norm(R0 - XRecon)/norm(R0)

%% Incremental Rank Power Factorization
XRecon = irpf_operator_cg(A, Ah, AhA, y, [m,n], f,f+1);
norm(XRecon-R0)/norm(R0)
%% Fixed Point Continuation
mu_final = 0.1;
[U,S,V,numiter] = FPC([m, n],IDX,R0(IDX),mu_final);
XRecon = U*S*V';
norm(R0-XRecon,'fro')/norm(R0,'fro')
%% Singular Value Thresholding
tau = 5*sqrt(m*n);
delta = 1.2*length(IDX)/(m*n);
[U,S,V,numiter] = SVT([m n],IDX,R0(IDX),tau,delta);
XRecon = U*S*V';
norm(R0-XRecon,'fro')/norm(R0,'fro')