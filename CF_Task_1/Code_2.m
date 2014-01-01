load ratings.mat;

number_of_users=943;
number_of_movies=1682;

for i=1:number_of_users
    for j=1:number_of_movies
        if(ratings(i,j)!=0&&ratings(i+1,j)!=0)
        diff_user(i,j)=abs(ratings(i,j)-ratings(i+1))
        end
    end
end
