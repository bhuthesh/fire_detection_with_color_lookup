%from the masked image, cluster the pixels into 10 clusters using kmeans
%clustering with K = 10
%for each cluster calculate centroid of the cluster and std deviation of
%all the pixles in the cluster

%this forms the color lookup table for the image


%% extract each RGB channel
red_channel = masked_fire_image(:,:,1);
green_channel = masked_fire_image(:,:,2);
blue_channel = masked_fire_image(:,:,3);

%% select only the pixels that are not zero i,e select pixels only in the masked region
red_channel_sel = red_channel(red_channel~=0);
green_channel_sel = green_channel(green_channel~=0);
blue_channel_sel = blue_channel(blue_channel~=0);

%% cluster the selected pixels into clusters using kmeans clustering from MATLAB

NClusters = 10;
[idx_r, cts_r] = kmeans(double(red_channel_sel),NClusters,'EmptyAction','singleton');
[idx_g, cts_g] = kmeans(double(green_channel_sel),NClusters,'EmptyAction','singleton');
[idx_b, cts_b] = kmeans(double(blue_channel_sel),NClusters,'EmptyAction','singleton');

%% cell arrays to store clusters for each channels
clusters_red = {};
clusters_green = {};
clusters_blue = {};

%% extract clustered pixels into respective clusters
for i = 1:NClusters
clusters_red{i} = red_channel_sel(idx_r == i);
clusters_green{i} = green_channel_sel(idx_g == i);
clusters_blue{i} = blue_channel_sel(idx_b == i);
end

%% array to store centroid and stddev values
cluster_red_cts_std=zeros(NClusters,2);
cluster_green_cts_std=zeros(NClusters,2);
cluster_blue_cts_std=zeros(NClusters,2);

%% color lookup table for the current image
for i = 1:NClusters
cluster_red_cts_std(i,1) = cts_r(i);
cluster_red_cts_std(i,2) = std(double(clusters_red{i}));

cluster_green_cts_std(i,1) = cts_g(i);
cluster_green_cts_std(i,2) = std(double(clusters_green{i}));

cluster_blue_cts_std(i,1) = cts_b(i);
cluster_blue_cts_std(i,2) = std(double(clusters_blue{i}));

end