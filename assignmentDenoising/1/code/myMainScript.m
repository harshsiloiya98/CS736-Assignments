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
fprintf("Original errors\n------------------\n");
fprintf("RRMSE between noiseless and low noise images = %f\n", RRMSE1);
fprintf("RRMSE between noiseless and medium noise images = %f\n", RRMSE2);
fprintf("RRMSE between noiseless and high noise images = %f\n\n", RRMSE3);

%% Denoising using quadratic loss

% hyperparams
alpha = 0.3;
gamma = 0;     % any arbitrary value

[denoisedImg11, itr1, loss11] = gradientDescent(lowNoiseImg, alpha, gamma, 1);
[denoisedImg12, itr2, loss12] = gradientDescent(medNoiseImg, alpha, gamma, 1);
[denoisedImg13, itr3, loss13] = gradientDescent(highNoiseImg, alpha, gamma, 1);

[temp11, ~, ~] = gradientDescent(lowNoiseImg, 1.2 * alpha, gamma, 1);
[temp12, ~, ~] = gradientDescent(medNoiseImg, 1.2 * alpha, gamma, 1);
[temp13, ~, ~] = gradientDescent(highNoiseImg, 1.2 * alpha, gamma, 1);

[temp21, ~, ~] = gradientDescent(lowNoiseImg, 0.8 * alpha, gamma, 1);
[temp22, ~, ~] = gradientDescent(medNoiseImg, 0.8 * alpha, gamma, 1);
[temp23, ~, ~] = gradientDescent(highNoiseImg, 0.8 * alpha, gamma, 1);

newRRMSE1 = RRMSE(groundTruth, denoisedImg11);
newRRMSE2 = RRMSE(groundTruth, denoisedImg12);
newRRMSE3 = RRMSE(groundTruth, denoisedImg13);
tempRRMSE11 = RRMSE(groundTruth, temp11);
tempRRMSE12 = RRMSE(groundTruth, temp12);
tempRRMSE13 = RRMSE(groundTruth, temp13);
tempRRMSE21 = RRMSE(groundTruth, temp21);
tempRRMSE22 = RRMSE(groundTruth, temp22);
tempRRMSE23 = RRMSE(groundTruth, temp23);

fprintf("Optimal alpha = %f\n", alpha);
fprintf("Quadratic errors\n------------------\n");
fprintf("RRMSE between noiseless and denoised img (low noise) :- \n");
fprintf("At alpha = %f\n", newRRMSE1);
fprintf("At 1.2 * alpha = %f\n", tempRRMSE11);
fprintf("At 0.8 * alpha = %f\n", tempRRMSE21);
fprintf("RRMSE between noiseless and denoised img (med noise) :- \n");
fprintf("At alpha = %f\n", newRRMSE2);
fprintf("At 1.2 * alpha = %f\n", tempRRMSE12);
fprintf("At 0.8 * alpha = %f\n", tempRRMSE22);
fprintf("RRMSE between noiseless and denoised img (high noise) :- \n");
fprintf("At alpha = %f\n", newRRMSE3);
fprintf("At 1.2 * alpha = %f\n", tempRRMSE13);
fprintf("At 0.8 * alpha = %f\n\n", tempRRMSE23);

%% Denoising using Huber loss

% hyperparams
alpha = 0.5;
gamma = 0.7;

[denoisedImg21, itr1, loss21] = gradientDescent(lowNoiseImg, alpha, gamma, 2);
[denoisedImg22, itr2, loss22] = gradientDescent(medNoiseImg, alpha, gamma, 2);
[denoisedImg23, itr3, loss23] = gradientDescent(highNoiseImg, alpha, gamma, 2);

[temp11, ~, ~] = gradientDescent(lowNoiseImg, 1.2 * alpha, gamma, 1);
[temp12, ~, ~] = gradientDescent(medNoiseImg, 1.2 * alpha, gamma, 1);
[temp13, ~, ~] = gradientDescent(highNoiseImg, 1.2 * alpha, gamma, 1);

[temp21, ~, ~] = gradientDescent(lowNoiseImg, 0.8 * alpha, gamma, 1);
[temp22, ~, ~] = gradientDescent(medNoiseImg, 0.8 * alpha, gamma, 1);
[temp23, ~, ~] = gradientDescent(highNoiseImg, 0.8 * alpha, gamma, 1);

newRRMSE1 = RRMSE(groundTruth, denoisedImg21);
newRRMSE2 = RRMSE(groundTruth, denoisedImg22);
newRRMSE3 = RRMSE(groundTruth, denoisedImg23);
tempRRMSE11 = RRMSE(groundTruth, temp11);
tempRRMSE12 = RRMSE(groundTruth, temp12);
tempRRMSE13 = RRMSE(groundTruth, temp13);
tempRRMSE21 = RRMSE(groundTruth, temp21);
tempRRMSE22 = RRMSE(groundTruth, temp22);
tempRRMSE23 = RRMSE(groundTruth, temp23);

fprintf("Optimal alpha = %f\n", alpha);
fprintf("Optimal gamma = %f\n", gamma);
fprintf("Huber errors\n------------------\n");
fprintf("RRMSE between noiseless and denoised img (low noise) :- \n");
fprintf("At alpha = %f\n", newRRMSE1);
fprintf("At 1.2 * alpha = %f\n", tempRRMSE11);
fprintf("At 0.8 * alpha = %f\n", tempRRMSE21);
fprintf("RRMSE between noiseless and denoised img (med noise) :- \n");
fprintf("At alpha = %f\n", newRRMSE2);
fprintf("At 1.2 * alpha = %f\n", tempRRMSE12);
fprintf("At 0.8 * alpha = %f\n", tempRRMSE22);
fprintf("RRMSE between noiseless and denoised img (high noise) :- \n");
fprintf("At alpha = %f\n", newRRMSE3);
fprintf("At 1.2 * alpha = %f\n", tempRRMSE13);
fprintf("At 0.8 * alpha = %f\n\n", tempRRMSE23);

%% Denoising using DAF loss

% hyperparams
alpha = 0.5;
gamma = 0.5;

[denoisedImg31, itr1, loss31] = gradientDescent(lowNoiseImg, alpha, gamma, 3);
[denoisedImg32, itr2, loss32] = gradientDescent(medNoiseImg, alpha, gamma, 3);
[denoisedImg33, itr3, loss33] = gradientDescent(highNoiseImg, alpha, gamma, 3);

[temp11, ~, ~] = gradientDescent(lowNoiseImg, 1.2 * alpha, gamma, 1);
[temp12, ~, ~] = gradientDescent(medNoiseImg, 1.2 * alpha, gamma, 1);
[temp13, ~, ~] = gradientDescent(highNoiseImg, 1.2 * alpha, gamma, 1);

[temp21, ~, ~] = gradientDescent(lowNoiseImg, 0.8 * alpha, gamma, 1);
[temp22, ~, ~] = gradientDescent(medNoiseImg, 0.8 * alpha, gamma, 1);
[temp23, ~, ~] = gradientDescent(highNoiseImg, 0.8 * alpha, gamma, 1);

newRRMSE1 = RRMSE(groundTruth, denoisedImg31);
newRRMSE2 = RRMSE(groundTruth, denoisedImg32);
newRRMSE3 = RRMSE(groundTruth, denoisedImg33);
tempRRMSE11 = RRMSE(groundTruth, temp11);
tempRRMSE12 = RRMSE(groundTruth, temp12);
tempRRMSE13 = RRMSE(groundTruth, temp13);
tempRRMSE21 = RRMSE(groundTruth, temp21);
tempRRMSE22 = RRMSE(groundTruth, temp22);
tempRRMSE23 = RRMSE(groundTruth, temp23);

fprintf("Optimal alpha = %f\n", alpha);
fprintf("DAF errors\n------------------\n");
fprintf("RRMSE between noiseless and denoised img (low noise) :- \n");
fprintf("At alpha = %f\n", newRRMSE1);
fprintf("At 1.2 * alpha = %f\n", tempRRMSE11);
fprintf("At 0.8 * alpha = %f\n", tempRRMSE21);
fprintf("RRMSE between noiseless and denoised img (med noise) :- \n");
fprintf("At alpha = %f\n", newRRMSE2);
fprintf("At 1.2 * alpha = %f\n", tempRRMSE12);
fprintf("At 0.8 * alpha = %f\n", tempRRMSE22);
fprintf("RRMSE between noiseless and denoised img (high noise) :- \n");
fprintf("At alpha = %f\n", newRRMSE3);
fprintf("At 1.2 * alpha = %f\n", tempRRMSE13);
fprintf("At 0.8 * alpha = %f\n\n", tempRRMSE23);

%% Results


%%%% Low Noise

figure;

subplot(1, 5, 1);
imshow(uint8(255 * groundTruth));
subplot(1, 5, 2);
imshow(uint8(255 * lowNoiseImg));
subplot(1, 5, 3);
imshow(uint8(255 * denoisedImg11));
subplot(1, 5, 4);
imshow(uint8(255 * denoisedImg21));
subplot(1, 5, 5);
imshow(uint8(255 * denoisedImg31));

colormap('gray');

%%%% Medium noise

figure;

subplot(1, 5, 1);
imshow(uint8(255 * groundTruth));
subplot(1, 5, 2);
imshow(uint8(255 * medNoiseImg));
subplot(1, 5, 3);
imshow(uint8(255 * denoisedImg12));
subplot(1, 5, 4);
imshow(uint8(255 * denoisedImg22));
subplot(1, 5, 5);
imshow(uint8(255 * denoisedImg32));

colormap('gray');

%%%% High noise

figure;

subplot(1, 5, 1);
imshow(uint8(255 * groundTruth));
subplot(1, 5, 2);
imshow(uint8(255 * highNoiseImg));
subplot(1, 5, 3);
imshow(uint8(255 * denoisedImg13));
subplot(1, 5, 4);
imshow(uint8(255 * denoisedImg23));
subplot(1, 5, 5);
imshow(uint8(255 * denoisedImg33));

colormap('gray');

%% Loss vs Iterations

figure;

subplot(1, 3, 1);
plot(loss11);
xlabel("Iterations");
ylabel("Loss");
title("Quadratic Objective vs Iterations - Low Noise");

subplot(1, 3, 2);
plot(loss12);
xlabel("Iterations");
ylabel("Loss");
title("Quadratic Objective vs Iterations - Med Noise");

subplot(1, 3, 3);
plot(loss13);
xlabel("Iterations");
ylabel("Loss");
title("Quadratic Objective vs Iterations - High Noise");

figure;

subplot(1, 3, 1);
plot(loss21);
xlabel("Iterations");
ylabel("Loss");
title("Huber Objective vs Iterations - Low Noise");

subplot(1, 3, 2);
plot(loss22);
xlabel("Iterations");
ylabel("Loss");
title("Huber Objective vs Iterations - Med Noise");

subplot(1, 3, 3);
plot(loss23);
xlabel("Iterations");
ylabel("Loss");
title("Huber Objective vs Iterations - High Noise");

figure;

subplot(1, 3, 1);
plot(loss31);
xlabel("Iterations");
ylabel("Loss");
title("DAF Objective vs Iterations - Low Noise");

subplot(1, 3, 2);
plot(loss32);
xlabel("Iterations");
ylabel("Loss");
title("DAF Objective vs Iterations - Med Noise");

subplot(1, 3, 3);
plot(loss33);
xlabel("Iterations");
ylabel("Loss");
title("DAF Objective vs Iterations - High Noise");


%% 

toc;