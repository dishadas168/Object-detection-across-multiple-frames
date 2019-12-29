%This script allows a user to select a region of interest in one frame, and
%then match descriptors in that region to descriptors in the second image 
%based on Euclidean distance in SIFT space. The selected region is displayed.

clc;
clear;
addpath('./mat_files/');
addpath('./provided_files/');
addpath('./helper_files/');

%Load SIFT files for two given images
load('twoFrameData.mat');
[oninds, poss] = selectRegion(im1, positions1);

%Get distances between SIFT features of selected region and SIFT features
%of 2nd image
z = dist2(descriptors1(oninds, :), descriptors2);
z = z ./ max(z(:));
rows = [0 0];
k=1;

%Iteration to select only those SIFT features that are the closest to those
%of the 2nd image
for i = 1:size(z,1)
    for j = 1:size(z,2)
        if z(i,j)< 0.1
            rows(k,:)= [j, z(i,j)];
            k = k+1;
        end
    end
end
rows = sortrows(rows,2);

%Display matched features
figure;
imshow(im2);
title('Matched features in Image 2');
displaySIFTPatches(positions2(rows(:,1),:), scales2(rows(:,1)) ,orients2(rows(:,1)) , im2); 


