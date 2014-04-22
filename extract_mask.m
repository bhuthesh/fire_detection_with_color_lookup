%extract a part of an image (which contains fire pixels) as ROI
%read image
fire_image = imread('resize-fire0.jpg');
imshow(fire_image)

%select mask manually using roipoly
selected_region = roipoly(fire_image);
mask_three_chan = repmat(selected_region,[1 1 3]); % replicate the selected region for all three channels
masked_fire_image = fire_image;

%return the selected part of image
masked_fire_image(~mask_three_chan)=0; % zero out all the unselected pixels
subplot(2,1,1);
%title('original image');
imshow(fire_image);
subplot(2,1,2);
%title('extracted mask');
imshow(masked_fire_image);
