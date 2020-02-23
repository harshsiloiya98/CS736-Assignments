%%
clc;
clear;
tic;

%% Reading images

groundTruth = imread("../data/histology_noiseless.png");
noisyImg = imread("../data/histology_noisy.png");
[r, c, n] = size(noisyImg);

groundTruth = im2double(groundTruth);
noisyImg = im2double(noisyImg);

channel1 = noisyImg(:, :, 1);
channel2 = noisyImg(:, :, 2);
channel3 = noisyImg(:, :, 3);

%% Error calculation

oldRRMSE = RRMSE(groundTruth, noisyImg);

fprintf("Original errors\n------------------\n");
fprintf("RRMSE between noiseless and low noise images = %f\n", oldRRMSE);

%% Denoising using quadratic loss

% hyperparams
alpha = 0.3;
gamma = 0;     % any arbitrary value

[denoisedImgChan1, lossChan1] = gradientDescent(channel1, alpha, gamma, 1);
[denoisedImgChan2, lossChan2] = gradientDescent(channel2, alpha, gamma, 1);
[denoisedImgChan3, lossChan3] = gradientDescent(channel3, alpha, gamma, 1);

denoisedImg1 = cat(3, denoisedImgChan1, denoisedImgChan2, denoisedImgChan3);
loss1 = lossChan1 + lossChan2 + lossChan3;

newRRMSE = RRMSE(groundTruth, denoisedImg1);

fprintf("Quadratic error\n------------------\n");
fprintf("RRMSE between noiseless and denoised img = %f\n", newRRMSE);

%% Gradient descent using Huber loss

% hyperparams
alpha = 0.3;
gamma = 0.5;

[denoisedImgChan1, lossChan1] = gradientDescent(channel1, alpha, gamma, 1);
[denoisedImgChan2, lossChan2] = gradientDescent(channel2, alpha, gamma, 1);
[denoisedImgChan3, lossChan3] = gradientDescent(channel3, alpha, gamma, 1);

denoisedImg2 = cat(3, denoisedImgChan1, denoisedImgChan2, denoisedImgChan3);
loss2 = lossChan1 + lossChan2 + lossChan3;

newRRMSE = RRMSE(groundTruth, denoisedImg2);

fprintf("Huber error\n------------------\n");
fprintf("RRMSE between noiseless and denoised img = %f\n", newRRMSE);

%% Gradient descent using custom DAF

% hyperparams
alpha = 0.3;
gamma = 0.5;

[denoisedImgChan1, lossChan1] = gradientDescent(channel1, alpha, gamma, 1);
[denoisedImgChan2, lossChan2] = gradientDescent(channel2, alpha, gamma, 1);
[denoisedImgChan3, lossChan3] = gradientDescent(channel3, alpha, gamma, 1);

denoisedImg3 = cat(3, denoisedImgChan1, denoisedImgChan2, denoisedImgChan3);
loss3 = lossChan1 + lossChan2 + lossChan3;

newRRMSE = RRMSE(groundTruth, denoisedImg3);

fprintf("Quadratic error\n------------------\n");
fprintf("RRMSE between noiseless and denoised img = %f\n", newRRMSE);

%% Results

figure;

subplot(1, 5, 1);
imshow(uint8(255 * groundTruth));
title("Without noise");
subplot(1, 5, 2);
imshow(uint8(255 * noisyImg));
title("With noise");
subplot(1, 5, 3);
imshow(uint8(255 * denoisedImg1));
title("Denoising using quadratic loss");
subplot(1, 5, 4);
imshow(uint8(255 * denoisedImg2));
title("Denoising using huber loss");
subplot(1, 5, 5);
imshow(uint8(255 * denoisedImg3));
title("Denoising using DAF loss");

%% Loss vs Iterations

figure;

subplot(1, 3, 1);
plot(loss1);
xlabel("Iterations");
ylabel("Loss");
title("Quadratic Objective vs Iterations");

subplot(1, 3, 2);
plot(loss2);
xlabel("Iterations");
ylabel("Loss");
title("Huber Objective vs Iterations");

subplot(1, 3, 3);
plot(loss3);
xlabel("Iterations");
ylabel("Loss");
title("DAF Objective vs Iterations");


%% 

toc;