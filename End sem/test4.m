

clear all;
load baseline_prediction.mat;
load user_bias.mat;
load item_bias.mat;
load ratings_full.mat;
load ratings_train.mat;

mean_full = 3.5299;
%%

%%Fully specified matrix
total_users = 943; total_items = 1682; f=20;

%Iterations
num_iter = 10;

% Ratings matrix(m,n)
R = ratings_full; 
% Check for number of points in full dataset
n_full = nnz(R);

%Ratings matrix(m,n)
R_train_data = ratings_train; 
% Check for number of points in full dataset
n_train = nnz(R_train_data);

%Initial random P matrix
P=randint(total_users,f);

%ib is item bias
ib = ib;

%ub is user bias
ub = ub;

% Constant_matrix: baseline_prediction(u,i) = mean_full + ib(i) + ub(u);
baseline_prediction = baseline_prediction; 

%% New matrix R with baseline correction
R_new=zeros(total_users,total_items);
for user=1:total_items
    for item=1:total_items
        if R_train_data(user,item)>0
            R_new(user,item)=R_train_data(user,item)-mu-ub(user)-ib(item);
        end
    end
end
%% First optimization problem without regularization
% Using CVX toolkit from CVX.inc and stephen boyd guide to convex optimization
    cvx_begin
    variable Q_new(f,total_items);
        for u=1:total_users
            for i=1:total_items
                if (R_train_data(u,i)>0)
                    minimize(norm(R_train_data(u,i)-baseline_prediction(u,i)-P(u,i)*Q_new(u,i)));
                end
            end
        end
    cvx_end;

    Qt=Q_new;
    
    % computing P_new from Qt
    cvx_begin
    variable P_new(total_users,f);
        for u=1:total_users
            for i=1:total_items
                if (R_train_data(u,i)>0)
                    minimize(norm(R_train_data(u,i)-mean_full-ib(i)-ub(u)-P*Q_new));
                end
            end
        end
    cvx_end;
    
    norm_error = norm(R_train_data-P_new*Qt);
    
    NMAE = norm(R_train_data-P_new*Qt)/(max(max(R))-min(min(R)));