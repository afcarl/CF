%% Matrix factorization using (ALS)
clear all;
%%

clc;
% Load Dataset
A=load('C:\Users\manojg\Dropbox\CF_Task\End sem\ml-100k\ml-100k\u.data');

%% Importing full ratings matrix
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

%% Sanity check for full ratings matrix
ratings_full(1:5,1:5)

%%
clc;
% Load Dataset
B=load('C:\Users\manojg\Dropbox\CF_Task\End sem\ml-100k\ml-100k\u1.base');
%% Importing training ratings matrix

train_users = max(B(:,1));
train_items = max(B(:,2));

indiviual_train_users = B(:,1);
indiviual_train_items = B(:,2);
indiviual_train_ratings = B(:,3);

ratings_train = zeros(total_users,total_items);
for user=1:total_users 
    ratings_train(user, indiviual_train_items(find(indiviual_train_users==user))) = indiviual_train_ratings(find(indiviual_train_users==user));
end
save('ratings_train.mat','ratings_train');

%% Sanity check for training ratings matrix
ratings_train(1:5,1:5)

%% Mean of full ratings matrix
mean_full = sum(sum(ratings_full))/100000;

%% Calculating Item bias

% Lambda for Item bias
lambda = 10;

for i=1:total_items
   ib_temp = ratings_full(find(ratings_full(:,i)),i);
   ib_temp2 = ib_temp - mean_full; 
   ib_temp3 = sum(ib_temp2);
   constant_item = (lambda+size(find(ratings_full(:,i)),1));
   ib(i) = ib_temp3/constant_item; 
end

save('item_bias.mat','ib');
%% Calculation for user bias

% Lambda for User bias
lambda_2 = 25;

for u=1:943
  sum1=0;  
  rateditems=0;
   for i=1:1682
    if (ratings_full(u,i)>0)
       sum1 = sum1 + ratings_full(u,i)-mean_full-ib(i);  
        rateditems = rateditems +1; 
    end
   end
ub(u) = sum1/(lambda_2+rateditems);   
end

save('user_bias.mat','ub');

%% Baseline prediction
 
baseline_prediction = ones(total_users,total_items);
for u=1:total_users
    for i=1:total_items
    baseline_prediction(u,i) = mean_full + ib(i) + ub(u);
    end
end

save('baseline_prediction.mat','baseline_prediction');
%% Interaction_matrix based on test data
interaction_matrix = ratings_train - baseline_prediction;
save('interaction_matrix.mat','interaction_matrix');












