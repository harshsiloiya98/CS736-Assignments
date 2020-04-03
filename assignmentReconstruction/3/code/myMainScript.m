%%
clc;
clear;
tic;

%% reading and displaying the images
f1 = imread('..\data\ChestCT.png');
f1 = double(f1);
figure,subplot(1,2,1), imshow(uint8(f1)), daspect([1 1 1]), colormap('gray')
title('ChestCT')

f2 = imread('..\data\SheppLogan256.png');
f2 = double(f2);
subplot(1,2,2), imshow(uint8(f2)), daspect([1 1 1]), colormap('gray')
title('SheppLogan256')
% the range of theta
theta_new = 1:1:150;

%% ChestCT image
% radon transform
RadonTransform_CT = radon(f1,1:180);
% initialize the error vector
Error = zeros(1,length(theta_new));
radonTransformCT = radon(f1,1:180);
for i = 1:180
    l = sort(mod((1:1:150)+i,180)+1);
    % radon transform
    radonTransform = radonTransformCT(:,l);
    % filtering
    FilteredImage = myFilter(radonTransform, 1,1);
    % inverse radon transform(reconstruction)
    backPropCT= iradon(FilteredImage,l,'linear','none',1,size(f1,1));
    % normalization
    mx=max(max(backPropCT));
    mn = min(min(backPropCT));
    bp_min =ones(size(backPropCT)).*mn;
    bp_max =ones(size(backPropCT)).*mx;
    backPropCT = (((backPropCT)-bp_min)./(bp_max-bp_min));
    Error(i)= RRMSE(f1,backPropCT);
end
% finding the index of minimum error
minIndex = find(Error == min(Error));
% radon transform at best angle which gives minimum error
radonTransform = radon(f1,theta_new+minIndex);
% filtering with L = W
FilteredImage = myFilter(radonTransform, 1,1);
% inverse radon transform
minBackPropImage= iradon(FilteredImage,mod(theta_new + minIndex,180),'linear','none',1,size(f1,1));
% normalization
mx=max(max(minBackPropImage));
mn = min(min(minBackPropImage));
bp_min =ones(size(minBackPropImage)).*mn;
bp_max =ones(size(minBackPropImage)).*mx;
minBackPropImage = (((minBackPropImage)-bp_min)./(bp_max-bp_min));
% displaying the reconstructed image along with the error graph
figure;
subplot(1,2,1);
plot(Error);
title('RRMSE vs Theta');
subplot(1,2,2);
imshow(minBackPropImage);
title('Backprojection of ChestCT Image with min RRMSE');


%% SheppLogan256 image
% radon transform
RadonTransform_S = radon(f2,1:180);
% initialization of the error vector
Error = zeros(1,length(theta_new));
radonTransformS = radon(f2,1:180);
for i = 1:180
    l = sort(mod((1:1:150)+i,180)+1);
    % radon transform
    radonTransform = radonTransformS(:,l);
    % filtering
    FilteredImage = myFilter(radonTransform, 1,1);
    % reconstruction via inverse radon transform
    backPropS= iradon(FilteredImage,l,'linear','none',1,size(f2,1));
    % normalization
    mx=max(max(backPropS));
    mn = min(min(backPropS));
    bp_min =ones(size(backPropS)).*mn;
    bp_max =ones(size(backPropS)).*mx;
    backPropS = (((backPropS)-bp_min)./(bp_max-bp_min));
	Error(i) = RRMSE(f2,backPropS);
end
% finding the index of the minimum error
minIndex = find(Error == min(Error));
% computing radon transform at best angle which gives minimum error
radonTransform = radon(f2,theta_new+minIndex);
% filtering
FilteredImage = myFilter(radonTransform, 1,1);
% reconstruction
minBackPropImage = iradon(FilteredImage,mod(theta_new + minIndex,180),'linear','none',1,size(f2,1));
% normalization
mx=max(max(minBackPropImage));
mn = min(min(minBackPropImage));
bp_min =ones(size(minBackPropImage)).*mn;
bp_max =ones(size(minBackPropImage)).*mx;
minBackPropImage = (((minBackPropImage)-bp_min)./(bp_max-bp_min));
% displaying the reconstructed image along with the error graph
figure;
subplot(1,2,1);
plot(Error);
title('RRMSE vs Theta');
subplot(1,2,2);
imshow(minBackPropImage);
title('Backprojection of SheppLogan256 Image with min RRMSE');

%%
toc;