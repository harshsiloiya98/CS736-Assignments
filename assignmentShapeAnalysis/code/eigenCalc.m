function [D, W] = eigenCalc(pointsets)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[dims, numPts, numImgs] = size(pointsets);
X = reshape(pointsets, [dims * numPts, numImgs]);
L = cov(X');
[W, D] = eig(L);
[D, ind] = sort(diag(D), 'descend');
W = W(:, ind);

end