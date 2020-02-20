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

[denoisedImg1, itr1, loss1] = gradientDescent(channel1, alpha, gamma, 1);
[denoisedImg2, itr2, loss2] = gradientDescent(channel2, alpha, gamma, 1);
[denoisedImg3, itr3, loss3] = gradientDescent(channel3, alpha, gamma, 1);

denoisedImg = cat(3, denoisedImg1, denoisedImg2, denoisedImg3);
loss = loss1 + loss2 + loss3;

newRRMSE = RRMSE(groundTruth, denoisedImg);

fprintf("Quadratic error\n------------------\n");
fprintf("RRMSE between noiseless and denoised img = %f\n", newRRMSE);

%% Results

figure;
subplot(1, 2, 1);
imshow(uint8(255 * noisyImg));
subplot(1, 2, 2);
imshow(uint8(255 * denoisedImg));

%% Loss vs Iterations

figure;
plot(loss);
xlabel("Iterations");
ylabel("Loss");
title("Quadratic Objective vs Iterations");

%% Gradient descent using Huber loss

% hyperparams
alpha = 0.3;
gamma = 0.5;

[denoisedImg1, itr1, loss1] = gradientDescent(channel1, alpha, gamma, 1);
[denoisedImg2, itr2, loss2] = gradientDescent(channel2, alpha, gamma, 1);
[denoisedImg3, itr3, loss3] = gradientDescent(channel3, alpha, gamma, 1);

denoisedImg = cat(3, denoisedImg1, denoisedImg2, denoisedImg3);
loss = loss1 + loss2 + loss3;

newRRMSE = RRMSE(groundTruth, denoisedImg);

fprintf("Huber error\n------------------\n");
fprintf("RRMSE between noiseless and denoised img = %f\n", newRRMSE);

%% Results

figure;
subplot(1, 2, 1);
imshow(uint8(255 * noisyImg));
subplot(1, 2, 2);
imshow(uint8(255 * denoisedImg));

%% Loss vs Iterations

figure;
plot(loss);
xlabel("Iterations");
ylabel("Loss");
title("Huber Objective vs Iterations");

%% Gradient descent using custom DAF

% hyperparams
alpha = 0.3;
gamma = 0.5;

[denoisedImg1, itr1, loss1] = gradientDescent(channel1, alpha, gamma, 1);
[denoisedImg2, itr2, loss2] = gradientDescent(channel2, alpha, gamma, 1);
[denoisedImg3, itr3, loss3] = gradientDescent(channel3, alpha, gamma, 1);

denoisedImg = cat(3, denoisedImg1, denoisedImg2, denoisedImg3);
loss = loss1 + loss2 + loss3;

newRRMSE = RRMSE(groundTruth, denoisedImg);

fprintf("Quadratic error\n------------------\n");
fprintf("RRMSE between noiseless and denoised img = %f\n", newRRMSE);

%% Results

figure;
subplot(1, 2, 1);
imshow(uint8(255 * noisyImg));
subplot(1, 2, 2);
imshow(uint8(255 * denoisedImg));

%% Loss vs Iterations

figure;
plot(loss);
xlabel("Iterations");
ylabel("Loss");
title("DAF Objective vs Iterations");

%% 

toc;