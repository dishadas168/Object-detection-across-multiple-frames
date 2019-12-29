%This function calculates the bag of words histograms for given image name
%and returns the histogram

function [ h ] = bagOfWords( imname )

addpath('./mat_files/');
addpath('./provided_files/');
addpath('./helper_files/');

load('visualVocabulary1.mat');
img = imread(sprintf('../PS4Frames/frames/%s',imname));

d = load(sprintf('../PS4SIFT/sift/%s.mat',imname));
z = dist2(C, d.descriptors);
if max(z(:)) ~= 0
 z = z ./ max(z(:));
end
[minim class] = min(z);

h = zeros(1,1500);
for i = 1:length(class)
   j = class(i);
   h(j) = h(j) + 1;
end
end

