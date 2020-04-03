function [x_final, errors] = tikhonov(A, B, X, range)

lambda = range;
errors = zeros(1, length(lambda));
epsilon = 10e-6;
x_old = zeros(128 * 128, 1);

% chose a random index
index = 100;
error = B(index) - A(index, :) * x_old;
for i = 1:length(lambda)
    while (error >= epsilon)
        M = x_old' * x_old + epsilon;
        x_new = x_old + lambda(i) * (error ./ M) * A(index,:)';
        mx = max(x_new);
        mn = min(x_new);
        bp_min = ones(size(x_new)) .* mn;
        bp_max = ones(size(x_new)) .* mx;
        x_new = ((x_new - bp_min) ./ (bp_max-bp_min));
        x_old = x_new;
        error = B(index) - A(index,:) * x_old;
    end
    x_final = reshape(x_new, [128, 128]);
    errors(1, i) = RRMSE(X, x_final);
end

end