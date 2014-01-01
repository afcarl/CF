

clear all;
load baseline_prediction.mat;
load user_bias.mat;
load item_bias.mat;
load ratings_full.mat;
load ratings_train.mat;
load testSet1.mat

mean_full = 3.5299;
%% Intializations

% Fully specified matrix
total_users = 943; total_items = 1682; f=20;

% Iterations
num_iter = 5;

% Ratings matrix(m,n)
R = ratings_full; 
% Check for number of points in full dataset
n_full = nnz(R);

% Ratings matrix(m,n)
R_train_data = ratings_train; 
% Check for number of points in full dataset
n_train = nnz(R_train_data);

% ib is item bias
ib = ib;

% ub is user bias
ub = ub;

% Constant_matrix: baseline_prediction(u,i) = mean_full + ib(i) + ub(u);
baseline_prediction = baseline_prediction; 

%% New matrix R_new with baseline correction
R_new=zeros(total_users,total_items);
for user=1:total_users
    for item=1:total_items
        if R_train_data(user,item)>0
            R_new(user,item)=R_train_data(user,item)-baseline_prediction(user,item);
        end
    end
end

%% Define Size of dataset for iterations
% m=50;
% n=40;
% f=20;
% R_new2 = R_new(1:m,1:n);

m=total_users;
n=total_items;
f=20;
R_new2 = R_new(1:m,1:n);

%% Intializations
P=randn(m,f);
norm_error=zeros(num_iter+1,1);
norm_error(1,1)=1;
idx=(R_new2~=0);
%% First optimization problem without regularization
% Using CVX toolkit from CVX.inc and stephen boyd guide for convex optimization
for i=1:num_iter
    cvx_begin
    variable Q_new(f,n);
    temp=R_new2-P*Q_new;
    temp2=temp(idx);
    minimize(norm(temp2));
    %subject to
    %    Q_new>0;
    cvx_end;
    Qt=Q_new;
    
    disp('Check_1');

    %Estimate P using Qt
    cvx_begin
    variable P_new(m,f);
    temp=R_new2-P_new*Qt;
    temp2=temp(idx);
    minimize(norm(temp2));
    cvx_end;
    
    disp('Check_2');

    P=P_new;
    norm_error(i+1,1)=norm(temp2);

    disp(sprintf('After iteration %d, the norm error is %f',i,norm(temp2)));
end


