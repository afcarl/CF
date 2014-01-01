%%%%%function to calculate distance vectors%%%%%
function distance=difference(i,j,ratings,distance_metric)

%%%%%index of ratings rated by both users i.e intersection set%%%%%
idx=ratings(i,:)>0 & ratings(j,:)>0;

%%%%%condition to check user choice for manhattan distance%%%%%
if distance_metric=='manhattan'
    distance=pdist2(ratings(i,idx),ratings(j,idx),'cityblock');
end
%%%%%condition to check user choice for cosine distance%%%%%
if distance_metric=='cosine'
    distance=pdist2(ratings(i,idx),ratings(j,idx),'cosine');
end