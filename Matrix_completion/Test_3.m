clear all;

load('C:\Users\Omkar\Dropbox\CF_Task\Matrix_completion\ratings_full.mat'); %load the matrix in to workspace
r_full = rank(ratings_full);           % To find rank of matrix

total_users = 943;
total_items = 1682;

ratings_full(1:5,1:5)

%% Straight NNMF test on a complete ratings matrix taken from movie lens dataset
test_matrix = ratings_full(:,:);
test_matrix(1:10,1:10)
rank_test = rank(test_matrix); 
[W1,F1] = nnmf(test_matrix,rank_test);
recovered_matrix = W1*F1;
answer_straight_NNMF_on_full_dataset = norm(ratings_full - recovered_matrix)/norm(ratings_full)

%%
rand_samples = createSamplingScheme ([total_users total_items], 'random', 0.3);
size_of_random_samples = numel(rand_samples);

%First set of random samples
random_row = randperm(total_users);
rand_samples_1 = rand_samples(random_row,:);
size_of_random_samples_1 = numel(rand_samples_1);

%%

% Sub-sampled matrix - 1
sub_sampled_matrix_1 = rand_samples_1.*matrix;
% Non-Negative Matrix Factorization
r1 = rank(sub_sampled_matrix_1);
[p1,q1] = nnmf(sub_sampled_matrix_1,r1);
recovered_matrix_1 = p1*q1;
ans1 = norm(matrix - recovered_matrix_1)/norm(matrix)

%%
% clear all
% clc
%m = 1000; n = 1500; f = 20;
% P0 = rand(m,f);
% Q0 = rand(n,f);
% R0 = P0*Q0';
M = createSamplingScheme ([m n], 'random', 0.2);
% Y = M.*R0;
% IDX = find(M);

%%

