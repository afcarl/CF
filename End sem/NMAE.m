
%% Reconstructed matrix after ALS on interaction matrix
XRecon = P*Qt;

%% Predicted matrix
pred_mat = XRecon+baseline_prediction;

R_test = testSet1;
idx_test = (R_test~=0);

%% absolute error
abs_error = abs(sum(sum(R_test(idx_test) - pred_mat(idx_test))));

%% MAE
MAE = abs_error/20000;

%% NMAE
NMAE = MAE/(5-1);


save final_results.mat
	