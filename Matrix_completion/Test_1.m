clear all;                  % Clear all variables
%load fisheriris;            % Dependencies for NNMF
%matrix = randint(10,10);    % Form a matrix w/ randomly distributed integers
load('C:\Users\Omkar\Dropbox\CF_Task\Matrix_completion\ratings.mat'); %load the matrix in to workspace
r = rank(matrix);           % To find rank of matrix

% % LU Decomposition %
% [L,U,P] = lu(matrix);       % LU decomposition of matrix
% 
% % Check for LU decomposition
% if (L*U==P*matrix)
%     disp('LU decomposition is working');
% end


% [W,F] = nnmf(matrix,r);
% % Check for NNMF 
% if (W*F==matrix)
%     disp('NNMF decomposition is working');
% end

