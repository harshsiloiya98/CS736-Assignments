function [loss, grad] = huber(u, gamma)
% huber loss function

loss1 = (abs(u) <= gamma).*(0.5 * u.^2);
loss2 = (abs(u) > gamma).*(gamma * abs(u) - 0.5 * gamma^2);
loss = loss1 + loss2;
loss = sum(loss, 'all');

grad1 = (abs(u) <= gamma).*u;
grad2 = (abs(u) > gamma).*sign(u) * gamma;
grad = grad1 + grad2;

end