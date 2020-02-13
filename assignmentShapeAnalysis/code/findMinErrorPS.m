function [closestPS] = findMinErrorPS(pointsets, targetPS)

minError = 1000;
[dims, numPts, numImgs] = size(pointsets);
closestPS = zeros(dims, numPts);
% calculating min RMS error
for i = 1:numImgs
    diff = abs(targetPS - pointsets(:, :, i)).^2;
    error = sum(diff(:)) / numel(targetPS);
    if (error < minError)
        minError = error;
        closestPS = pointsets(:, :, i);
    end
end

end