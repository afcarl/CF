clear all;              % Clear all variables

%%
A = importdata('C:\Users\Omkar\Dropbox\CF_Task\Matrix_completion\ml-100k\ml-100k\u.data','\t');

%%
total_users = max(A(:,1));
total_items = max(A(:,2));

indiviual_users = A(:,1);
indiviual_items = A(:,2);
indiviual_ratings = A(:,3);

ratings_full = zeros(total_users,total_items);

for user=1:total_users 
    ratings_full(user, indiviual_items(find(indiviual_users==user))) = indiviual_ratings(find(indiviual_users==user));
end

save('ratings_full.mat','ratings_full');

%%

%Lambda
lambda = 10;
%Mean
mean_mu = sum(sum(ratings_full))/100000;
%%

%Calculation for item bias
 
for i=1:total_items
   ib_temp = ratings_full(find(ratings_full(:,i)),i);
   ib_temp2 = ib_temp - mean_mu; 
   ib_temp3 = sum(ib_temp2);
   constant_item = (lambda+size(find(ratings_full(:,i)),1));
   ib(i) = ib_temp3/constant_item; 
end

%% Calculation for user bias
 lambda2 = 25;
for u=1:943
  sum=0;  
  rateditems=0;
   for i=1:1682
    if (ratings_full(u,i)>0)
       sum = sum + ratings_full(u,i)-mean_mu-ib(i);  
        rateditems = rateditems +1; 
    end
   end
ub(u) = sum/(lambda2+rateditems);   
end

%% Baseline prediction
 
baseline = ones(total_users,total_items);
for u=1:total_users
    for i=1:total_items
    baseline_prediction(u,i) = mean_mu + ib(i) + ub(u);
    end
end



%% Import test data

train = importdata('C:\Users\Omkar\Dropbox\CF_Task\Matrix_completion\ml-100k\ml-100k\u1.base','\t');

%%
train_users = max(train(:,1));
train_items = max(train(:,2));

train_indiviual_users = train(:,1);
train_indiviual_items = train(:,2);
train_indiviual_ratings = train(:,3);

ratings_train_data = zeros(train_users,train_items);

for user=1:train_users 
    ratings_train_data(user, train_indiviual_items(find(train_indiviual_users==user))) = train_indiviual_ratings(find(train_indiviual_users==user));
end

save('ratings_train_data.mat','ratings_train_data');

%% Interaction_matrix based on test data
interaction_matrix = ratings_train_data - baseline_prediction;


%% Singular Value Thresholding
addpath(genpath('C:\Users\Omkar\Dropbox\CF_Task\Matrix_completion\SVT\'));
addpath(genpath('C:\Users\Omkar\Dropbox\CF_Task\Matrix_completion\'));

NMAE_SVT=0;
size_matrix = total_users*total_items;
predicted_matrix = zeros(total_users,total_items);
U=0; 
V=0; 
S=0;
% SVT Code
    IDX = find(interaction_matrix);
    tau = 5*sqrt(total_users*total_items);
    delta = 1.2*length(IDX)/(total_users*total_items);
    [U,S,V,numiter] = SVT([total_users total_items],IDX,interaction_matrix(IDX),tau,delta,150);
    XRecon = U*S*V';
    
%Predicted matrix full  
            predicted_matrix = XRecon + baseline_prediction;
   

%% Import test data

load testSet1.mat
ratings_test_data = zeros(total_users,total_items);
ratings_test_data = testSet1;           

%%
absolute_error = 0;

for u=1:total_users
   for i=1:total_items
       
       if (ratings_test_data(u,i)>0)
       
           error = abs(predicted_matrix(u,i) - ratings_test_data(u,i));
           absolute_error = absolute_error + error;   
       end
       
   end
end
%%
MAE = absolute_error/20000;
 
k = (max(max(predicted_matrix))-min(min(predicted_matrix))); 

NMAE = MAE/k;


%% Save workspace

save('quiz4_data.mat');




