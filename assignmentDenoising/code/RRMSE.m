function [res] = RRMSE(A, B)
% returns the RRMSE between two images A and B

res = sqrt(sum((abs(A(:)) - abs(B(:))).^2)) / sqrt(sum(abs(A(:)).^2));

end