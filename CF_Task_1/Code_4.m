clear all;
load ratings.mat;
MD_U_1=csvread('C:\Users\manojg\Desktop\CF_Task\MH_DIST\MD_U_1.csv');
% ksearch_k1_u1=zeros(943,2);
% ksearch_k2_u1=zeros(943,2);
% ksearch_k3_u1=zeros(943,2);
% ksearch_k4_u1=zeros(943,2);
% ksearch_k5_u1=zeros(943,2);
intersection_matrix_k1_u1=zeros(5,1682);
intersection_matrix_k2_u1=zeros(5,1682);
intersection_matrix_k3_u1=zeros(5,1682);
intersection_matrix_k4_u1=zeros(5,1682);
intersection_matrix_k5_u1=zeros(5,1682);
length_of_intersection_matrix_k1_u1=zeros(5,1);
length_of_intersection_matrix_k2_u1=zeros(5,1);
length_of_intersection_matrix_k3_u1=zeros(5,1);
length_of_intersection_matrix_k4_u1=zeros(5,1);
length_of_intersection_matrix_k5_u1=zeros(5,1);

%%%%%%%%%%%nearest neighbour matrix for K=1:5 and user1%%%%%%%%%%%    
    ksearch_k1_u1=MD_U_1((MD_U_1(:,1)==1),2);
    ksearch_k2_u1=MD_U_1((MD_U_1(:,1)==2),2);
    ksearch_k3_u1=MD_U_1((MD_U_1(:,1)==3),2);
    ksearch_k4_u1=MD_U_1((MD_U_1(:,1)==4),2);
    ksearch_k5_u1=MD_U_1((MD_U_1(:,1)==5),2);
    
%%%%%%%%%%%%intersection matrix for k=1 and user1%%%%%%%%%%
for i=1:length(ksearch_k1_u1) 
    %%%%%%%%%%%intersection matrix of user1 with each neighbour%%%%%%%%%%%%
    intersection_matrix_k1_u1(i,:)=(ratings(1,:)>0) & (ratings(ksearch_k1_u1(i),:)>0);
    %%%%%%%%%%%find the neighbour with k=1 and longest length of intersection matrix%%%%%%%%%%%%
    length_of_intersection_matrix_k1_u1(i,1)=sum(intersection_matrix_k1_u1(i,:));
end

%%%%%%%%%%%%intersection matrix for k=2 and user1%%%%%%%%%%
for i=1:length(ksearch_k2_u1) 
    %%%%%%%%%%%intersection matrix of user1 with each neighbour%%%%%%%%%%%%
    intersection_matrix_k2_u1(i,:)=(ratings(1,:)>0) & (ratings(ksearch_k2_u1(i),:)>0);
    %%%%%%%%%%%find the neighbour with k=2 and longest length of intersection matrix%%%%%%%%%%%%
    length_of_intersection_matrix_k2_u1(i,1)=sum(intersection_matrix_k2_u1(i,:));
end

%%%%%%%%%%%%intersection matrix for k=3 and user1%%%%%%%%%%
for i=1:length(ksearch_k3_u1) 
    %%%%%%%%%%%intersection matrix of user1 with each neighbour%%%%%%%%%%%%
    intersection_matrix_k3_u1(i,:)=(ratings(1,:)>0) & (ratings(ksearch_k3_u1(i),:)>0);
    %%%%%%%%%%%find the neighbour with k=3 and longest length of intersection matrix%%%%%%%%%%%%
    length_of_intersection_matrix_k3_u1(i,1)=sum(intersection_matrix_k3_u1(i,:));
end

%%%%%%%%%%%%intersection matrix for k=4 and user1%%%%%%%%%%
for i=1:length(ksearch_k4_u1) 
    %%%%%%%%%%%intersection matrix of user1 with each neighbour%%%%%%%%%%%%
    intersection_matrix_k4_u1(i,:)=(ratings(1,:)>0) & (ratings(ksearch_k4_u1(i),:)>0);
    %%%%%%%%%%%find the neighbour with k=4 and longest length of intersection matrix%%%%%%%%%%%%
    length_of_intersection_matrix_k4_u1(i,1)=sum(intersection_matrix_k4_u1(i,:));
end

%%%%%%%%%%%%intersection matrix for k=5 and user1%%%%%%%%%%
for i=1:length(ksearch_k5_u1) 
    %%%%%%%%%%%intersection matrix of user1 with each neighbour%%%%%%%%%%%%
    intersection_matrix_k5_u1(i,:)=(ratings(1,:)>0) & (ratings(ksearch_k5_u1(i),:)>0);
    %%%%%%%%%%%find the neighbour with k=5 and longest length of intersection matrix%%%%%%%%%%%%
    length_of_intersection_matrix_k5_u1(i,1)=sum(intersection_matrix_k5_u1(i,:));
end


save C:\Users\manojg\Desktop\CF_Task\ksearch.mat;