function [D, W] = topKModeVariation(pointsets, k)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[dims, numPts, numImgs] = size(pointsets);
X = reshape(pointsets, [dims * numPts, numImgs]);
L = cov(X');
[W, D] = eig(L);
[D, ind] = sort(diag(D), 'descend');
W = W(:, ind);
figure
plot(D);

end