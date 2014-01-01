function [ P,Q ] = custom_nnmf(R, K, steps, alpha, beta )
%%Custom NNMF

%% Params
% R=Original matrix to be factorized
% K=Number of factors/features
% steps=Number of iterations, use 1e5 or so 
% alpha, use 1e-4
% beta, use 1e-2

%% Usage
% R=rand(1000,600);
% K=20;
% steps=5000;
% alpha=2e-4;
% beta=2e-2;
% [P,Q]=custom_nnmf(R, K, steps, alpha, beta );
% norm(R-P*Q,1)/length(R)


N=size(R,1);
M=size(R,2);
P = rand(N,K);
Q = rand(K,M);


for step=1:steps
    for i=1:N
        for j=1:M
            if R(i,j)>0
                eij=R(i,j)-P(i,:)*Q(:,j);
                for k=1:K
                    P(i,k) = P(i,k) + alpha * (2 * eij * Q(k,j) - beta * P(i,k));
                    Q(k,j) = Q(k,j) + alpha * (2 * eij * P(i,k) - beta * Q(k,j));
                end
            end
        end
    end
    %eR=P*Q;
    e=0;
    for i=1:N
        for j=1:M
            if R(i,j) > 0
                e = e + (R(i,j) - P(i,:)*Q(:,j))^ 2;
                for k = 1:K
                    e = e + (beta/2) * ((P(i,k)^2) + (Q(k,j)^2) );
                end
            end
        end
    end
    if e < 0.001
        break
    end
    
%     Q=Q';
    


end

