function [loss, grad] = priorMRF(img, gamma, type)
% returns prior MRFs according to the type selected
% 1 - quadratic function
% 2 - Huber function
% 3 - discontinuity-adaptive function

top = img - circshift(img, 1, 1);
bottom = img - circshift(img, -1, 1);
left = img - circshift(img, 1, 2);
right = img - circshift(img, -1, 2);

if (type == 1)
    [loss1, grad1] = quadratic(top);
    [loss2, grad2] = quadratic(bottom);
    [loss3, grad3] = quadratic(left);
    [loss4, grad4] = quadratic(right);
elseif (type == 2)
    [loss1, grad1] = huber(top, gamma);
    [loss2, grad2] = huber(bottom, gamma);
    [loss3, grad3] = huber(left, gamma);
    [loss4, grad4] = huber(right, gamma);
elseif (type == 3)
    [loss1, grad1] = DAF(top, gamma);
    [loss2, grad2] = DAF(bottom, gamma);
    [loss3, grad3] = DAF(left, gamma);
    [loss4, grad4] = DAF(right, gamma);
end

loss = loss1 + loss2 + loss3 + loss4;
grad = grad1 + grad2 + grad3 + grad4;

end