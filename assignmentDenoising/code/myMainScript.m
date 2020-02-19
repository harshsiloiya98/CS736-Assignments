%%
clc;
clear;
tic;

%% Reading images

groundTruth = imread("../data/mri_image_noiseless.png");
lowNoiseImg = imread("../data/mri_image_noise_level_low.png");
medNoiseImg = imread("../data/mri_image_noise_level_medium.png");
highNoiseImg = imread("../data/mri_image_noise_level_high.png");

groundTruth = im2double(groundTruth);
lowNoiseImg = im2double(lowNoiseImg);
medNoiseImg = im2double(medNoiseImg);
highNoiseImg = im2double(highNoiseImg);

%% Error calculation

RRMSE1 = RRMSE(groundTruth, lowNoiseImg);
RRMSE2 = RRMSE(groundTruth, medNoiseImg);
RRMSE3 = RRMSE(groundTruth, highNoiseImg);
fprintf("RRMSE between noiseless and low noise images = %f\n", RRMSE1);
fprintf("RRMSE between noiseless and medium noise images = %f\n", RRMSE2);
fprintf("RRMSE between noiseless and high noise images = %f\n\n", RRMSE3);

%% Denoising using quadratic loss

% hyperparams
alpha = 0.16;
gamma = 0;     % any arbitrary value

[denoisedImg1, itr1, loss1] = gradientDescent(lowNoiseImg, alpha, gamma, 1);
[denoisedImg2, itr2, loss2] = gradientDescent(medNoiseImg, alpha, gamma, 1);
[denoisedImg3, itr3, loss3] = gradientDescent(highNoiseImg, alpha, gamma, 1);

RRMSE1 = RRMSE(groundTruth, denoisedImg1);
RRMSE2 = RRMSE(groundTruth, denoisedImg2);
RRMSE3 = RRMSE(groundTruth, denoisedImg3);
fprintf("RRMSE between noiseless and denoised img (low noise) = %f\n", RRMSE1);
fprintf("RRMSE between noiseless and denoised img (medium noise) = %f\n", RRMSE2);
fprintf("RRMSE between noiseless and denoised img (high noise) = %f\n\n", RRMSE3);

%% Results



%% Loss vs Iterations

figure;

subplot(1, 3, 1);
plot(loss1);
xlabel("Iterations");
ylabel("Loss1");
title("Quadratic Objective vs Iterations - Low Noise");

subplot(1, 3, 2);
plot(loss2);
xlabel("Iterations");
ylabel("Loss2");
title("Quadratic Objective vs Iterations - Med Noise");

subplot(1, 3, 3);
plot(loss3);
xlabel("Iterations");
ylabel("Loss3");
title("Quadratic Objective vs Iterations - High Noise");

%% Gradient descent using Huber loss


%% Gradient descent using custom DAF


%% 

toc;