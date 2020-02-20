function [loss, grad] = quadratic(u)
% quadratic loss function

loss = abs(u).^2;
loss = sum(loss, 'all');
grad = 2 * u;

end