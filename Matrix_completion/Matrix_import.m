clear all;              % Clear all variables

A = importdata('C:\Users\manojg\Dropbox\CF_Task\Matrix_completion\ml-100k\ml-100k\u.data','\t');

% total_users = max(A(:,1));
% total_items = max(A(:,2));
% 
% indiviual_users = A(:,1);
% indiviual_items = A(:,2);
% indiviual_ratings = A(:,3);
% 
% ratings_full = zeros(total_users,total_items);
% 
% for user=1:total_users 
%     ratings_full(user, indiviual_items(find(indiviual_users==user))) = indiviual_ratings(find(indiviual_users==user));
% end
% 
% save('ratings_full.mat','ratings_full');

for i=1:5
    j=(2000*(i-1))+1;
    %A_size = size(A(j:j+1999,:));
  
    eval(['A_' num2str(i) '=' 'A(' num2str(j) ':' num2str(j) '+1999,:);']);
    
    eval(['total_users_' num2str(i) '=max(A_' num2str(i) '(:,1));']);
    eval(['total_items_' num2str(i) '=max(A_' num2str(i) '(:,2));']);
    
    eval(['indiviual_users_' num2str(i) '= A_' num2str(i) '(:,1);']);
    eval(['indiviual_items_' num2str(i) '= A_' num2str(i) '(:,2);']);
    eval(['indiviual_ratings_' num2str(i) '= A_' num2str(i) '(:,3);']);

end


