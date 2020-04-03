function [loss, grad] = likelihood(x, y)
% gaussian likelihood function

loss = (x - y).^2;
loss = sum(loss(:));

grad = 2 * (x - y);

end