function [loss, grad] = DAF(u, gamma)
% custom discontinuity adaptive loss function

loss = gamma * abs(u) - gamma^2 * log(1 + abs(u) / gamma);
loss = sum(loss, 'all');

grad = gamma * sign(u) - (gamma^2 ./ (1 + abs(u) / gamma)) .* sign(u);

end