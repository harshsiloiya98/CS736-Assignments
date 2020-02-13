%% MyMainScript
clc; clear;
tic;

%% NOTE

% Please ensure that image processing toolbox is installed as well.
% The ellipses may not be closed due to the pointset generation procedure
% used.
% The .mat files for ellipse, leaf and brain dataset are generated
% manually using traceBoundaries.m which is included in the folder.

%% Reading ellipse data

filePath = "../data/ellipse/data/";
%tracingBoundaries(".jpg", 150, 16, filePath);
data = load("../data/ellipse.mat");
imgs = data.shapes;

[dims, m, n] = size(imgs);

% plotting all the ellipses
figure
hold on
for i = 1:n
    scatter(imgs(1, :, i), imgs(2, :, i), 6);
end
title("Scatterplot of unaligned ellipse pointsets");
hold off

%% Mean shape of ellipse data

[ms, newPS] = meanShape(imgs);
figure
hold on
for i = 1:n
    scatter(newPS(1, :, i), newPS(2, :, i), 6);
end
plot(ms(1, :), ms(2, :), 'LineWidth', 2);
title("Mean shape of ellipse pointsets");
hold off

%% Eigenvalues calculation

[D, W] = eigenCalc(newPS);
figure
plot(D);
title("Plot of sorted eigenvalues");

%% Top 3 modes of varations

% 1st eigenvalue
ms1 = ms + 3 * sqrt(D(1)) * reshape(W(:, 1), [2, m]);
ms2 = ms - 3 * sqrt(D(1)) * reshape(W(:, 1), [2, m]);
figure
hold on
for i = 1:n
    scatter(newPS(1, :, i), newPS(2, :, i), 6);
end
p1 = plot(ms(1, :), ms(2, :), 'Color', 'blue', 'LineWidth', 2);
p2 = plot(ms1(1, :), ms1(2, :), 'Color', 'red', 'LineWidth', 2);
p3 = plot(ms2(1, :), ms2(2, :), 'Color', 'green', 'LineWidth', 2);
title("Modes of variation with 1st eigenvalue");
legend([p1, p2, p3], "0", "+3 stddev", "-3 stddev");
hold off

% 2nd eigenvalue
ms1 = ms + 3 * sqrt(D(2)) * reshape(W(:, 2), [2, m]);
ms2 = ms - 3 * sqrt(D(2)) * reshape(W(:, 2), [2, m]);
figure
hold on
for i = 1:n
    scatter(newPS(1, :, i), newPS(2, :, i), 6);
end
p1 = plot(ms(1, :), ms(2, :), 'Color', 'blue', 'LineWidth', 2);
p2 = plot(ms1(1, :), ms1(2, :), 'Color', 'red', 'LineWidth', 2);
p3 = plot(ms2(1, :), ms2(2, :), 'Color', 'green', 'LineWidth', 2);
title("Modes of variation with 2nd eigenvalue");
legend([p1, p2, p3], "0", "+3 stddev", "-3 stddev");
hold off

% 3rd eigenvalue
ms1 = ms + 3 * sqrt(D(3)) * reshape(W(:, 3), [2, m]);
ms2 = ms - 3 * sqrt(D(3)) * reshape(W(:, 3), [2, m]);
figure
hold on
for i = 1:n
    scatter(newPS(1, :, i), newPS(2, :, i), 6);
end
p1 = plot(ms(1, :), ms(2, :), 'Color', 'blue', 'LineWidth', 2);
p2 = plot(ms1(1, :), ms1(2, :), 'Color', 'red', 'LineWidth', 2);
p3 = plot(ms2(1, :), ms2(2, :), 'Color', 'green', 'LineWidth', 2);
title("Modes of variation with 3rd eigenvalue");
legend([p1, p2, p3], "0", "+3 stddev", "-3 stddev");
hold off

%% Closest pointsets

ms1 = ms + 3 * sqrt(D(1)) * reshape(W(:, 1), [2, m]);
ms2 = ms - 3 * sqrt(D(1)) * reshape(W(:, 1), [2, m]);

% Closest to mean shape
ps = findMinErrorPS(newPS, ms);
figure
hold on
p1 = plot(ms(1, :), ms(2, :), 'Color', 'blue', 'LineWidth', 2);
p2 = plot(ps(1, :), ps(2, :), 'Color', 'red', 'LineWidth', 2);
title("Pointset closest to mean shape");
legend([p1, p2], "actual", "closest");
hold off

% Closest to +3 stddev
ps = findMinErrorPS(newPS, ms1);
figure
hold on
p1 = plot(ms1(1, :), ms1(2, :), 'Color', 'blue', 'LineWidth', 2);
p2 = plot(ps(1, :), ps(2, :), 'Color', 'red', 'LineWidth', 2);
title("Pointset closest to +3 stddev of top mode");
legend([p1, p2], "actual", "closest");
hold off

% Closest to -3 stddev
ps = findMinErrorPS(newPS, ms2);
figure
hold on
p1 = plot(ms2(1, :), ms2(2, :), 'Color', 'blue', 'LineWidth', 2);
p2 = plot(ps(1, :), ps(2, :), 'Color', 'red', 'LineWidth', 2);
title("Pointset closest to -3 stddev of top mode");
legend([p1, p2], "actual", "closest");
hold off

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
title("Scatterplot of unaligned hand pointsets");
hold off

%% Mean shape of hand data

[ms, newPS] = meanShape(imgs);
figure
hold on
for i = 1:n
    scatter(newPS(1, :, i), newPS(2, :, i), 6);
end
plot(ms(1, :), ms(2, :), 'LineWidth', 2);
title("Mean shape of hand pointsets");
hold off

%% Eigenvalues calculation

[D, W] = eigenCalc(newPS);
figure
plot(D);
title("Plot of sorted eigenvalues");

%% Top 3 modes of varations

% 1st eigenvalue
ms1 = ms + 3 * sqrt(D(1)) * reshape(W(:, 1), [2, m]);
ms2 = ms - 3 * sqrt(D(1)) * reshape(W(:, 1), [2, m]);
figure
hold on
for i = 1:n
    scatter(newPS(1, :, i), newPS(2, :, i), 6);
end
p1 = plot(ms(1, :), ms(2, :), 'Color', 'blue', 'LineWidth', 2);
p2 = plot(ms1(1, :), ms1(2, :), 'Color', 'red', 'LineWidth', 2);
p3 = plot(ms2(1, :), ms2(2, :), 'Color', 'green', 'LineWidth', 2);
title("Modes of variation with 1st eigenvalue");
legend([p1, p2, p3], "0", "+3 stddev", "-3 stddev");
hold off

% 2nd eigenvalue
ms1 = ms + 3 * sqrt(D(2)) * reshape(W(:, 2), [2, m]);
ms2 = ms - 3 * sqrt(D(2)) * reshape(W(:, 2), [2, m]);
figure
hold on
for i = 1:n
    scatter(newPS(1, :, i), newPS(2, :, i), 6);
end
p1 = plot(ms(1, :), ms(2, :), 'Color', 'blue', 'LineWidth', 2);
p2 = plot(ms1(1, :), ms1(2, :), 'Color', 'red', 'LineWidth', 2);
p3 = plot(ms2(1, :), ms2(2, :), 'Color', 'green', 'LineWidth', 2);
title("Modes of variation with 2nd eigenvalue");
legend([p1, p2, p3], "0", "+3 stddev", "-3 stddev");
hold off

% 3rd eigenvalue
ms1 = ms + 3 * sqrt(D(3)) * reshape(W(:, 3), [2, m]);
ms2 = ms - 3 * sqrt(D(3)) * reshape(W(:, 3), [2, m]);
figure
hold on
for i = 1:n
    scatter(newPS(1, :, i), newPS(2, :, i), 6);
end
p1 = plot(ms(1, :), ms(2, :), 'Color', 'blue', 'LineWidth', 2);
p2 = plot(ms1(1, :), ms1(2, :), 'Color', 'red', 'LineWidth', 2);
p3 = plot(ms2(1, :), ms2(2, :), 'Color', 'green', 'LineWidth', 2);
title("Modes of variation with 3rd eigenvalue");
legend([p1, p2, p3], "0", "+3 stddev", "-3 stddev");
hold off

%% Closest pointsets

ms1 = ms + 3 * sqrt(D(1)) * reshape(W(:, 1), [2, m]);
ms2 = ms - 3 * sqrt(D(1)) * reshape(W(:, 1), [2, m]);

% Closest to mean shape
ps = findMinErrorPS(newPS, ms);
figure
hold on
p1 = plot(ms(1, :), ms(2, :), 'Color', 'blue', 'LineWidth', 2);
p2 = plot(ps(1, :), ps(2, :), 'Color', 'red', 'LineWidth', 2);
title("Pointset closest to mean shape");
legend([p1, p2], "actual", "closest");
hold off

% Closest to +3 stddev
ps = findMinErrorPS(newPS, ms1);
figure
hold on
p1 = plot(ms1(1, :), ms1(2, :), 'Color', 'blue', 'LineWidth', 2);
p2 = plot(ps(1, :), ps(2, :), 'Color', 'red', 'LineWidth', 2);
title("Pointset closest to +3 stddev of top mode");
legend([p1, p2], "actual", "closest");
hold off

% Closest to -3 stddev
ps = findMinErrorPS(newPS, ms2);
figure
hold on
p1 = plot(ms2(1, :), ms2(2, :), 'Color', 'blue', 'LineWidth', 2);
p2 = plot(ps(1, :), ps(2, :), 'Color', 'red', 'LineWidth', 2);
title("Pointset closest to -3 stddev of top mode");
legend([p1, p2], "actual", "closest");
hold off
    
%% Reading leaf data

filePath = "../data/leaf/data/leaf_";
%tracingBoundaries(".png", 75, 32, filePath);
data = load("../data/leaf.mat");
imgs = data.shapes;

[dims, m, n] = size(imgs);

% plotting all the hands
figure
hold on
for i = 1:n
    scatter(imgs(1, :, i), imgs(2, :, i), 6);
end
title("Scatterplot of unaligned leaf pointsets");
hold off

%% Mean shape of leaf data

[ms, newPS] = meanShape(imgs);
figure
hold on
for i = 1:n
    scatter(newPS(1, :, i), newPS(2, :, i), 6);
end
plot(ms(1, :), ms(2, :), 'LineWidth', 2);
title("Mean shape of leaf pointsets");
hold off

%% Eigenvalues calculation

[D, W] = eigenCalc(newPS);
figure
plot(D);
title("Plot of sorted eigenvalues");

%% Top 3 modes of varations

% 1st eigenvalue
ms1 = ms + 3 * sqrt(D(1)) * reshape(W(:, 1), [2, m]);
ms2 = ms - 3 * sqrt(D(1)) * reshape(W(:, 1), [2, m]);
figure
hold on
for i = 1:n
    scatter(newPS(1, :, i), newPS(2, :, i), 6);
end
p1 = plot(ms(1, :), ms(2, :), 'Color', 'blue', 'LineWidth', 2);
p2 = plot(ms1(1, :), ms1(2, :), 'Color', 'red', 'LineWidth', 2);
p3 = plot(ms2(1, :), ms2(2, :), 'Color', 'green', 'LineWidth', 2);
title("Modes of variation with 1st eigenvalue");
legend([p1, p2, p3], "0", "+3 stddev", "-3 stddev");
hold off

% 2nd eigenvalue
ms1 = ms + 3 * sqrt(D(2)) * reshape(W(:, 2), [2, m]);
ms2 = ms - 3 * sqrt(D(2)) * reshape(W(:, 2), [2, m]);
figure
hold on
for i = 1:n
    scatter(newPS(1, :, i), newPS(2, :, i), 6);
end
p1 = plot(ms(1, :), ms(2, :), 'Color', 'blue', 'LineWidth', 2);
p2 = plot(ms1(1, :), ms1(2, :), 'Color', 'red', 'LineWidth', 2);
p3 = plot(ms2(1, :), ms2(2, :), 'Color', 'green', 'LineWidth', 2);
title("Modes of variation with 2nd eigenvalue");
legend([p1, p2, p3], "0", "+3 stddev", "-3 stddev");
hold off

% 3rd eigenvalue
ms1 = ms + 3 * sqrt(D(3)) * reshape(W(:, 3), [2, m]);
ms2 = ms - 3 * sqrt(D(3)) * reshape(W(:, 3), [2, m]);
figure
hold on
for i = 1:n
    scatter(newPS(1, :, i), newPS(2, :, i), 6);
end
p1 = plot(ms(1, :), ms(2, :), 'Color', 'blue', 'LineWidth', 2);
p2 = plot(ms1(1, :), ms1(2, :), 'Color', 'red', 'LineWidth', 2);
p3 = plot(ms2(1, :), ms2(2, :), 'Color', 'green', 'LineWidth', 2);
title("Modes of variation with 3rd eigenvalue");
legend([p1, p2, p3], "0", "+3 stddev", "-3 stddev");
hold off

%% Closest pointsets

ms1 = ms + 3 * sqrt(D(1)) * reshape(W(:, 1), [2, m]);
ms2 = ms - 3 * sqrt(D(1)) * reshape(W(:, 1), [2, m]);

% Closest to mean shape
ps = findMinErrorPS(newPS, ms);
figure
hold on
p1 = plot(ms(1, :), ms(2, :), 'Color', 'blue', 'LineWidth', 2);
p2 = plot(ps(1, :), ps(2, :), 'Color', 'red', 'LineWidth', 2);
title("Pointset closest to mean shape");
legend([p1, p2], "actual", "closest");
hold off

% Closest to +3 stddev
ps = findMinErrorPS(newPS, ms1);
figure
hold on
p1 = plot(ms1(1, :), ms1(2, :), 'Color', 'blue', 'LineWidth', 2);
p2 = plot(ps(1, :), ps(2, :), 'Color', 'red', 'LineWidth', 2);
title("Pointset closest to +3 stddev of top mode");
legend([p1, p2], "actual", "closest");
hold off

% Closest to -3 stddev
ps = findMinErrorPS(newPS, ms2);
figure
hold on
p1 = plot(ms2(1, :), ms2(2, :), 'Color', 'blue', 'LineWidth', 2);
p2 = plot(ps(1, :), ps(2, :), 'Color', 'red', 'LineWidth', 2);
title("Pointset closest to -3 stddev of top mode");
legend([p1, p2], "actual", "closest");
hold off

%% Reading MRI data

filePath = "../data/brain/data/mri_image_";
%tracingBoundaries(".png", 40, 32, filePath);
data = load("../data/brain.mat");
imgs = data.shapes;

[dims, m, n] = size(imgs);

% plotting all the hands
figure
hold on
for i = 1:n
    scatter(imgs(1, :, i), imgs(2, :, i), 6);
end
title("Scatterplot of unaligned MRI pointsets");
hold off

%% Mean shape of MRI data

[ms, newPS] = meanShape(imgs);
figure
hold on
for i = 1:n
    scatter(newPS(1, :, i), newPS(2, :, i), 6);
end
plot(ms(1, :), ms(2, :), 'LineWidth', 2);
title("Mean shape of MRI pointsets");
hold off

%% Eigenvalues calculation

[D, W] = eigenCalc(newPS);
figure
plot(D);
title("Plot of sorted eigenvalues");

%% Top 3 modes of varations

% 1st eigenvalue
ms1 = ms + 3 * sqrt(D(1)) * reshape(W(:, 1), [2, m]);
ms2 = ms - 3 * sqrt(D(1)) * reshape(W(:, 1), [2, m]);
figure
hold on
for i = 1:n
    scatter(newPS(1, :, i), newPS(2, :, i), 6);
end
p1 = plot(ms(1, :), ms(2, :), 'Color', 'blue', 'LineWidth', 2);
p2 = plot(ms1(1, :), ms1(2, :), 'Color', 'red', 'LineWidth', 2);
p3 = plot(ms2(1, :), ms2(2, :), 'Color', 'green', 'LineWidth', 2);
title("Modes of variation with 1st eigenvalue");
legend([p1, p2, p3], "0", "+3 stddev", "-3 stddev");
hold off

% 2nd eigenvalue
ms1 = ms + 3 * sqrt(D(2)) * reshape(W(:, 2), [2, m]);
ms2 = ms - 3 * sqrt(D(2)) * reshape(W(:, 2), [2, m]);
figure
hold on
for i = 1:n
    scatter(newPS(1, :, i), newPS(2, :, i), 6);
end
p1 = plot(ms(1, :), ms(2, :), 'Color', 'blue', 'LineWidth', 2);
p2 = plot(ms1(1, :), ms1(2, :), 'Color', 'red', 'LineWidth', 2);
p3 = plot(ms2(1, :), ms2(2, :), 'Color', 'green', 'LineWidth', 2);
title("Modes of variation with 2nd eigenvalue");
legend([p1, p2, p3], "0", "+3 stddev", "-3 stddev");
hold off

% 3rd eigenvalue
ms1 = ms + 3 * sqrt(D(3)) * reshape(W(:, 3), [2, m]);
ms2 = ms - 3 * sqrt(D(3)) * reshape(W(:, 3), [2, m]);
figure
hold on
for i = 1:n
    scatter(newPS(1, :, i), newPS(2, :, i), 6);
end
p1 = plot(ms(1, :), ms(2, :), 'Color', 'blue', 'LineWidth', 2);
p2 = plot(ms1(1, :), ms1(2, :), 'Color', 'red', 'LineWidth', 2);
p3 = plot(ms2(1, :), ms2(2, :), 'Color', 'green', 'LineWidth', 2);
title("Modes of variation with 3rd eigenvalue");
legend([p1, p2, p3], "0", "+3 stddev", "-3 stddev");
hold off

%% Closest pointsets

ms1 = ms + 3 * sqrt(D(1)) * reshape(W(:, 1), [2, m]);
ms2 = ms - 3 * sqrt(D(1)) * reshape(W(:, 1), [2, m]);

% Closest to mean shape
ps = findMinErrorPS(newPS, ms);
figure
hold on
p1 = plot(ms(1, :), ms(2, :), 'Color', 'blue', 'LineWidth', 2);
p2 = plot(ps(1, :), ps(2, :), 'Color', 'red', 'LineWidth', 2);
title("Pointset closest to mean shape");
legend([p1, p2], "actual", "closest");
hold off

% Closest to +3 stddev
ps = findMinErrorPS(newPS, ms1);
figure
hold on
p1 = plot(ms1(1, :), ms1(2, :), 'Color', 'blue', 'LineWidth', 2);
p2 = plot(ps(1, :), ps(2, :), 'Color', 'red', 'LineWidth', 2);
title("Pointset closest to +3 stddev of top mode");
legend([p1, p2], "actual", "closest");
hold off

% Closest to -3 stddev
ps = findMinErrorPS(newPS, ms2);
figure
hold on
p1 = plot(ms2(1, :), ms2(2, :), 'Color', 'blue', 'LineWidth', 2);
p2 = plot(ps(1, :), ps(2, :), 'Color', 'red', 'LineWidth', 2);
title("Pointset closest to -3 stddev of top mode");
legend([p1, p2], "actual", "closest");
hold off

%%

toc;