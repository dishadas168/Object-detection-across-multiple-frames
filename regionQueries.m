%In this script, selected query regions from within 4 frames are used to 
%demonstrate the retrieved frames when only a portion of the SIFT
%descriptors are used to form a bag of words. 

clc;
clear;
addpath('./mat_files/');
addpath('./provided_files/');
addpath('./helper_files/');

%Oninds.mat contains coordinates for selected region polygon
load('histograms.mat','h');
load('visualVocabulary1.mat');
load('oninds.mat');

%List of images selected
imageList = ['friends_0000003419.jpeg';'friends_0000002047.jpeg'; 
    'friends_0000003600.jpeg'; 
    'friends_0000001326.jpeg' 
     ];

 %Iterate over chosen images
for ims = 1:4
    name1 = imageList(ims,:);
    img1 = imread(sprintf('../PS4Frames/frames/%s',name1));
    d1 = load(sprintf('../PS4SIFT/sift/%s.mat',name1));
    
    %Get selected region coordinates
    onindss = oninds{ims};
    poss = pos{ims};
    xcoords = poss(:,1);
    xcoords = [xcoords ; poss(1,1)];
    ycoords = poss(:,2);
    ycoords = [ycoords ; poss(1,2)];

    %Display selected region
    figure;
    imshow(img1);
    title(sprintf('Selected region of image %d',ims));
    hold on;
    plot(xcoords, ycoords, 'r', 'LineWidth', 2, 'MarkerSize', 15);
    hold off;
    
    %Calculate distances between descriptors of selected region and all
    %other descriptors to form bag of words histogram
    z = dist2(C, d1.descriptors(onindss,:));
    if max(z(:)) ~= 0
     z = z ./ max(z(:));
    end
    [minim class] = min(z);
    
    %Form bag of words histogram
    h1 = zeros(1,1500);
    for i = 1:length(class)
       j = class(i);
       h1(j) = h1(j) + 1;
    end

    rows1 = [];
 
    %Iterate over all images
    for i = 60:6671
        digits = numel(num2str(i));
        if digits == 2
            imname = sprintf('friends_00000000%d.jpeg',i);
        elseif digits == 3
            imname = sprintf('friends_0000000%d.jpeg',i);
        else
            imname = sprintf('friends_000000%d.jpeg',i);
        end
        bow = h(i,:);
        s = similarityScore(h1,bow);
        rows1(i,:) = [s, i];

    end
    
    %Sort according to similarity scores
    rows1 = sortrows(rows1,-1);
    rows1(any(isnan(rows1),2),:) = [];

    %Display the best matches
    figure;
    m=6;
    for w = 1:m
       name = rows1(w,2);
       digits = numel(num2str(name));
       if digits == 2
            imname = sprintf('friends_00000000%d.jpeg',name);
        elseif digits == 3
            imname = sprintf('friends_0000000%d.jpeg',name);
        else
            imname = sprintf('friends_000000%d.jpeg',name);
       end
       img2 = imread(sprintf('../PS4Frames/frames/%s',imname));

       e = load(sprintf('../PS4SIFT/sift/%s.mat',imname));
        z = dist2(d1.descriptors(onindss, :), e.descriptors);
        z = z ./ max(z(:));
        rows = [0 0];
        k=1;
        for i = 1:size(z,1)
            for j = 1:size(z,2)
                if z(i,j)< 0.1
                    rows(k,:)= [j, z(i,j)];
                    k = k+1;
                end
            end
        end
       rows = sortrows(rows,2);
       if size(rows,1) > 25
           rows = rows(1:25,:);
       end

       subplot(3,3,w);
       imshow(img2);
       displaySIFTPatches(e.positions(rows(:,1),:), e.scales(rows(:,1)) ,e.orients(rows(:,1)) , img2);

    end

end


