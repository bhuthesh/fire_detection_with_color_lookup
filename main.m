clear; clc; close all;
extract_mask;
cluster_kmeans;
[firePixels, redPixels] = isFirePixel(fire_image, cluster_red_cts_std, cluster_green_cts_std, cluster_blue_cts_std);
redPixels3 = repmat(redPixels, [1 1 3]);
r4 = find(redPixels);
hist(double(fireImage(r4)), 10);
