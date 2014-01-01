clear all;

load('C:\Users\Omkar\Dropbox\CF_Task\Matrix_completion\ratings.mat'); %load the matrix in to workspace
r = rank(matrix);           % To find rank of matrix
total_users = 943;
total_items = 1682;


%% NNMF test on a test matrix taken from movie lens dataset
test_matrix = matrix(1:10,1:10);
test_matrix
rank_test = rank(test_matrix); 
[W1,F1] = nnmf(test_matrix,rank_test);

test_matrix_recovered = W1*F1;
test_matrix_recovered

%% Straight NNMF on complete matrix of ratings from movie lens dataset
test_matrix2 = matrix(:,:);
%test_matrix2(1:10,1:10)
rank_test2 = rank(test_matrix2); 
[WR,FR] = nnmf(test_matrix2,rank_test2);

test_matrix2_recovered = WR*FR;
test_matrix2_recovered(1:10,1:10)
%%
rand_samples = createSamplingScheme ([total_users total_items], 'random', 0.3);
size_of_random_samples = numel(rand_samples);

%First set of random samples
random_row = randperm(total_users);
rand_samples_1 = rand_samples(random_row,:);
size_of_random_samples_1 = numel(rand_samples_1);

%Second set of random samples
random_row = randperm(total_users);
rand_samples_2 = rand_samples(random_row,:);
size_of_random_samples_2 = numel(rand_samples_2);

%Third set of random samples
random_row = randperm(total_users);
rand_samples_3 = rand_samples(random_row,:);
size_of_random_samples_3 = numel(rand_samples_3);

%Fourth set of random samples
random_row = randperm(total_users);
rand_samples_4 = rand_samples(random_row,:);
size_of_random_samples_4 = numel(rand_samples_4);

%Fifth set of random samples
random_row = randperm(total_users);
rand_samples_5 = rand_samples(random_row,:);
size_of_random_samples_5 = numel(rand_samples_5);

%%

% Sub-sampled matrix - 1
sub_sampled_matrix_1 = rand_samples_1.*matrix;
% Non-Negative Matrix Factorization
r1 = rank(sub_sampled_matrix_1);
[p1,q1] = nnmf(sub_sampled_matrix_1,r1);
recovered_matrix_1 = p1*q1;
ans1 = norm(matrix - recovered_matrix_1)/norm(matrix)

% Sub-sampled matrix - 2
sub_sampled_matrix_2 = rand_samples_2.*matrix;
% Non-Negative Matrix Factorization
r2 = rank(sub_sampled_matrix_1);
[p2,q2] = nnmf(sub_sampled_matrix_2,r2);
recovered_matrix_2 = p2*q2;
ans2 = norm(matrix - recovered_matrix_2)/norm(matrix)

% Sub-sampled matrix - 3
sub_sampled_matrix_3 = rand_samples_3.*matrix;
% Non-Negative Matrix Factorization
r3 = rank(sub_sampled_matrix_3);
[p3,q3] = nnmf(sub_sampled_matrix_3,r3);
recovered_matrix_3 = p3*q3;
ans3 = norm(matrix - recovered_matrix_3)/norm(matrix)

% Sub-sampled matrix - 4
sub_sampled_matrix_4 = rand_samples_4.*matrix;
% Non-Negative Matrix Factorization
r4 = rank(sub_sampled_matrix_4);
[p4,q4] = nnmf(sub_sampled_matrix_4,r4);
recovered_matrix_4 = p4*q4;
ans4 = norm(matrix - recovered_matrix_4)/norm(matrix)

% Sub-sampled matrix - 5
sub_sampled_matrix_5 = rand_samples_5.*matrix;
% Non-Negative Matrix Factorization
r5 = rank(sub_sampled_matrix_5);
[p5,q5] = nnmf(sub_sampled_matrix_5,r5);
recovered_matrix_5 = p5*q5;
ans5 = norm(matrix - recovered_matrix_5)/norm(matrix)


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

