function [] = tracingBoundaries(ImgType,NumImages,NumPoints,dataPath)
% Code to capture pointsets modeling the shape of each object

%NumImages=40;
%NumPoints=32;
indx=1;
shapes= zeros(2,NumPoints,NumImages);
%extracting the points from each image in the dataset
for i=1:NumImages
    path = strcat(dataPath, num2str(i), ImgType);
    BW = imread(path);
    BW = rgb2gray(BW);
    % detect the edges of the object
    BW = edge(BW,'canny');
    imshow(BW)
    [x, y] = getpts;
    x=round(x);
    y=round(y);
    s=size(BW);
    for t = y:1:s(1)
        for u = x:1:s(2) 
            if BW(t,u)
                break;
            end
        end
        contour1 = bwtraceboundary(BW, [t, u], 'W', 4, inf,...
                                     'counterclockwise');
        if(~isempty(contour1))
            hold on;
            plot(contour1(:,2),contour1(:,1),'g','LineWidth',2);
            plot(x, y,'gx','LineWidth',2);
        else
            hold on; 
            plot(x, y,'rx','LineWidth',2);
        end
    end
    x=x';
    y=y';
    shapes(:,:,i)=[x;y];
end
save('data.mat','shapes')
end