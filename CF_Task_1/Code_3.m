load ratings.mat;

number_of_users=943;
number_of_movies=1682;
buffer=zeros(number_of_users,2);

%%%%%loop to calculate manhattan distance of each user1 wrt to user2%%%%%
for user1=1:number_of_users
    for user2=1:number_of_users
        %%%%%%%%%Manhattan distance%%%%%%% 
        buffer(user2,1)=difference(user1,user2,ratings,'manhattan');
        buffer(user2,2)=user2;
    end
     %%%%%Sorting the outcomes to find minimum distance for each user1 wrt to other users%%%%%    
     [B, idx]=sortrows(buffer);   
     %%%%%Distance from each user1 wrt to other users is stored in CSV files%%%%%
     csvname = sprintf('%s%d%s', 'C:\Users\manojg\Desktop\CF_Task\MH_DIST\MD_U_',user1,'.csv');
     csvwrite(csvname,B);
end
%%%%%loop to calculate manhattan distance of each user1 wrt to user2%%%%%
for user1=1:number_of_users
    for user2=1:number_of_users
        %%%%%%%%%Cosine distance One minus the cosine of the included angle between points%%%%%%% 
        buffer(user2,1)=abs(difference(user1,user2,ratings,'cosine')-1);  
        buffer(user2,2)=user2;
    end
     %%%%%Sorting the outcomes to find minimum distance for each user1 wrt to other users%%%%%    
     [B, idx]=sortrows(buffer);   
     %%%%%Distance from each user1 wrt to other users is stored in CSV files%%%%%
     csvname = sprintf('%s%d%s', 'C:\Users\manojg\Desktop\CF_Task\COS_DIST\COS_U_',user1,'.csv');
     csvwrite(csvname,B);
end
