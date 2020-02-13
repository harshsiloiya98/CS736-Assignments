function [meanPS, alignedPointsets] = meanShape(pointsets)
% function for calculating the meanshape of the given pointsets

[dims, numPts, numImgs] = size(pointsets);
meanPS = zeros(dims, numPts);

% shifting centroids to origin and norms to 1

centroids = sum(pointsets, 2) / numPts;
centroids = repmat(centroids, [1, numPts, 1]);
pointsets = pointsets - centroids;
for i = 1:numImgs
    pointsets(:, :, i) = pointsets(:, :, i) / norm(pointsets(:, :, i));
end

meanPS = pointsets(:, :, 1);

% gradient descent

epsilon = 1e-6;
error = 1000;
while (error < epsilon)
    old_meanPS = meanPS;
    % get optimum rotation
    for i = 1:numImgs
        [U, ~, V] = svd(meanPS * pointsets(:, :, i)');
        R = V * U';
        d = det(R);
        if (d == -1)
           I = eye(dims);
           I(dims, dims) = -1;
           R = V * I * U';
        end
        pointsets(:, :, i) = R' * pointsets(:, :, i);
    end
    meanPS = sum(pointsets, 3) / numImgs;
    meanPS = meanPS / norm(meanPS);
    error = norm(meanPS - old_meanPS);
end

alignedPointsets = pointsets;

end