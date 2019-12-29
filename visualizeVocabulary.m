%This script uses a visual vocabulary and displays example image patches
%associated with two of the visual words. 

clc;
clear;
addpath('./mat_files/');
addpath('./provided_files/');
addpath('./helper_files/');

%Load the .mat files required that store the visual vocabulary and the
%associated data of sample images
load('representative1.mat');
load('visualVocabulary1.mat');

%Choose 2 word indices
m = 390; %350 370 390
n = 600; 

%Calculate distances between descriptor of word m and that of other
%images
zm = dist2(C(m,:), descList);
zm = zm ./ max(zm(:));
r = 1:length(zm);
rowsm = [zm; r]';

%Calculate distances between descriptor of word n and that of other
%images
zn = dist2(C(n,:), descList);
zn = zn ./ max(zn(:));
r = 1:length(zn);
rowsn = [zn; r]';

rowsm = sortrows(rowsm);
rowsm = rowsm(1:25,:);

rowsn = sortrows(rowsn);
rowsn = rowsn(1:25,:);

%Display the words
figure;
for i = 1:size(rowsm,1)
   index =  rowsm(i,2);
   for j = 1:size(featList,1)
       if index > featList(j,1) & index< featList(j,2)
           name = nameList(j,:);
           break;
       end
   end
   img = imread(sprintf('../PS4Frames/frames/%s',name));
   img = rgb2gray(img);
   subplot(5,5,i);
   imshow(getPatchFromSIFTParameters(posList(index,:),scaleList(index),orientList(index),img));
   if i==1
    title('Image patches for k = 390');
   end
end

figure;
for i = 1:size(rowsn,1)
   index =  rowsn(i,2);
   for j = 1:size(featList,1)
       if index > featList(j,1) & index< featList(j,2)
           name = nameList(j,:);
           break;
       end
   end
   img = imread(sprintf('../PS4Frames/frames/%s',name));
   img = rgb2gray(img);
   subplot(5,5,i);
   imshow(getPatchFromSIFTParameters(posList(index,:),scaleList(index),orientList(index),img));
   if i==1
    title('Image patches for k = 600');
   end
end

