function [res] = RRMSE(A, B)
% returns the RRMSE between two images A and B

A = abs(A);
B = abs(B);
res = sqrt(sum((A - B).^2, 'all')) / sqrt(sum(A.^2, 'all'));

end