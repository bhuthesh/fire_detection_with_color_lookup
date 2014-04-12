% CAUTION : modifies the input image
%extract a part of image (which contains fire pixels) as ROI
%read image
%select mask manually using roipoly
%return the selected part of image

fire_image = imread('fire0.jpg');
imshow(fire_image)
selected_region = roipoly(fire_image);

mask_three_chan = repmat(selected_region,[1 1 3]); % rep the selected region for all three channels
masked_fire_image = fire_image;
masked_fire_image(~mask_three_chan)=0; % zero out all the unselected pixels
subplot(2,1,1),imshow(fire_image);
subplot(2,1,2),imshow(masked_fire_image);
