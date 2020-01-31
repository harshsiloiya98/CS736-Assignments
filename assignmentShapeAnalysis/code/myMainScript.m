%% MyMainScript
clc; clear;
tic;

%% Reading ellipse data 

imgDataFolder = "../data/ellipse/data";
contents = dir(imgDataFolder);
imgs = [];

for i = 3:length(contents)
    imgName = contents(i).name;
    fullpath = fullfile(imgDataFolder, imgName);
    img = imread(fullpath);
    img = rgb2gray(img);
    imgs = cat(3, imgs, im2double(img));
end

%% Creating pointsets

%% Reading hand data

data = load("../data/hand/data.mat");
imgs = data.shapes;

[dims, m, n] = size(imgs);

% plotting all the hands
figure
hold on
for i = 1:n
    scatter(imgs(1, :, i), imgs(2, :, i), 6);
end
hold off

%% Mean shape of hand data

[ms, newPS] = meanShape(imgs);
figure
hold on
for i = 1:n
    scatter(newPS(1, :, i), newPS(2, :, i), 6);
end
plot(ms(1, :), ms(2, :), 'LineWidth', 2);
hold off

%% Eigenvalues calculation

[D, W] = eigenCalc(newPS);
figure
plot(D);

%% Top 3 modes of varations

% 1st eigenvalue
ms1 = ms + 3 * sqrt(D(1)) * reshape(W(:, 1), [2, m]);
ms2 = ms - 3 * sqrt(D(1)) * reshape(W(:, 1), [2, m]);
figure
hold on
for i = 1:n
    scatter(newPS(1, :, i), newPS(2, :, i), 6);
end
plot(ms(1, :), ms(2, :), 'Color', 'blue', 'LineWidth', 2);
plot(ms1(1, :), ms1(2, :), 'Color', 'red', 'LineWidth', 2);
plot(ms2(1, :), ms2(2, :), 'Color', 'green', 'LineWidth', 2);
hold off

% 2nd eigenvalue
ms1 = ms + 3 * sqrt(D(2)) * reshape(W(:, 2), [2, m]);
ms2 = ms - 3 * sqrt(D(2)) * reshape(W(:, 2), [2, m]);
figure
hold on
for i = 1:n
    scatter(newPS(1, :, i), newPS(2, :, i), 6);
end
plot(ms(1, :), ms(2, :), 'Color', 'blue', 'LineWidth', 2);
plot(ms1(1, :), ms1(2, :), 'Color', 'red', 'LineWidth', 2);
plot(ms2(1, :), ms2(2, :), 'Color', 'green', 'LineWidth', 2);
hold off

% 3rd eigenvalue
ms1 = ms + 3 * sqrt(D(3)) * reshape(W(:, 3), [2, m]);
ms2 = ms - 3 * sqrt(D(3)) * reshape(W(:, 3), [2, m]);
figure
hold on
for i = 1:n
    scatter(newPS(1, :, i), newPS(2, :, i), 6);
end
plot(ms(1, :), ms(2, :), 'Color', 'blue', 'LineWidth', 2);
plot(ms1(1, :), ms1(2, :), 'Color', 'red', 'LineWidth', 2);
plot(ms2(1, :), ms2(2, :), 'Color', 'green', 'LineWidth', 2);
hold off


    
%% Reading leaf data

%% Reading MRI data

%%
toc;