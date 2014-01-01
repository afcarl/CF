% My first comment%
 clear all;
 Data_1=importdata('C:\Users\manojg\Desktop\ml-100k\ml-100k\u1.base');
 display('omkar'); 
 Total_users=943;
 User_number=1;
%  Index_user(1,1)=max(find(Data_1(:,1)==1));     
% %  for i = 1:943
% %  Index_user(i,1)=max(find(Data_1(:,1)==i));%-max(find(Data_1(:,1)==i-1));     
% %  end     
%  Diff_1=find(Data_1(Data_1(:)==1));

Index_user=csvread('C:\Users\manojg\Desktop\CF_Task\Index.csv');
display('Checkpoint-1');

User_u1_base=Data_1(1:Index_user(User_number),:);      
csvname = sprintf('%s%d%s', 'C:\Users\manojg\Desktop\CF_Task\User_u1_base_',User_number,'.csv');
csvwrite(csvname,User_u1_base);

for User_number = 2:Total_users 
User_u1_base=Data_1((Index_user(User_number)-1):Index_user(User_number),:);
csvname = sprintf('%s%d%s', 'C:\Users\manojg\Desktop\CF_Task\User_u1_base_',User_number,'.csv');
csvwrite(csvname,User_u1_base);
end     
 
% for()
% csvwrite('C:\Users\manojg\Desktop\CF_Task\Index_user.csv',Index_user);

% display(Index_user); 

display('Waheguru');    