%Script stores the bag of words histograms in a mat file
clc;
clear;

h = [];
k = 60;
for i = 60:6671
    digits = numel(num2str(i));
    if digits == 2
        imname = sprintf('friends_00000000%d.jpeg',i);
    elseif digits == 3
        imname = sprintf('friends_0000000%d.jpeg',i);
    else
        imname = sprintf('friends_000000%d.jpeg',i);
    end
    h(k,:) = bagOfWords(imname);
    k = k + 1;
end
save('histograms.mat','h');