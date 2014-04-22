function [fireColorPixel, redPixelsOut] = isFirePixel( fireImage, cluster_red_cts_std, cluster_green_cts_std, cluster_blue_cts_std)
%isFirePixel Determine whether a given pixel can be classified as fire
%pixel or not

imageSize = size(fireImage(:,:,1));

redPixels = zeros(imageSize);
greenPixels = zeros(imageSize);
bluePixels = zeros(imageSize);
fireColorPixel = zeros(imageSize, 'uint8');
% use stored color lookup table for color lookup
red_ctd = [[226, 22];
           [246, 30];
           [228, 25];
           [252, 31];
           [250, 34];
           [136, 15];
           [189, 23];
           [240, 24];
           [183, 20];
           [209, 28]];
green_ctd = [[124, 55];
             [217, 64];
             [180, 56];
             [243, 55];
             [184, 64];
             [43, 35];
             [139, 47];
             [152, 59];
             [78, 40];
             [101, 47]];
blue_ctd = [[57, 51];
            [145, 56];
            [133, 52];
            [173, 51];
            [70, 58];
            [15, 12];
            [109, 37];
            [62, 53];
            [33, 14];
            [45, 40]];
x = imageSize(1);
y = imageSize(2);

NClusters = 10;
alpha = 0.75; % tolerance factor
%fireImage = double(fireImage); % typecast to double to avoid roundoffs

for i = 1 : x
    i
    for j = 1 : y
        for n = 1:NClusters
            % dR is the distance between a red pixel of image and red centroid
            % of any cluster. Similarly for green and blue pixels
            dR = abs(double(fireImage(i,j,1)) - cluster_red_cts_std(n, 1));
            if dR < alpha * cluster_red_cts_std(n, 2)
                redPixels(i,j) = 1;
            end
            
            dG = abs(double(fireImage(i,j,2)) - cluster_green_cts_std(n, 1));
            if dG < alpha * cluster_green_cts_std(n, 2)
                greenPixels(i,j) = 1;
            end
            
            dB = abs(double(fireImage(i,j,3)) - cluster_blue_cts_std(n, 1));
            if dB < alpha * cluster_blue_cts_std(n, 2)
                bluePixels(i,j) = 1;
            end
        end
        if (redPixels(i,j) == 1 && greenPixels(i,j) == 1)
            fireColorPixel(i,j) = 1;
        end
    end
end
redPixelsOut = redPixels;
end