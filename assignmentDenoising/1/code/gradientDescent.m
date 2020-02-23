function [denoisedImg, losses] = gradientDescent(noisyImg, alpha, gamma, priorType)
% gradient descent function for loss minimization

epsilon = 1e-8;
stepSize = 1;
denoisedImg = noisyImg;
oldNoisyImg = noisyImg;
losses = [];

while (stepSize > epsilon)
    [priorLoss, priorGrad] = priorMRF(oldNoisyImg, gamma, priorType);
    [lhLoss, lhGrad] = likelihood(oldNoisyImg, noisyImg);
    totalLoss = (1 - alpha) * lhLoss + alpha * priorLoss;
    totalGrad = (1 - alpha) * lhGrad + alpha * priorGrad;
    losses = [losses, totalLoss];
    denoisedImg = oldNoisyImg - stepSize * totalGrad;
    [newPriorLoss, ~] = priorMRF(denoisedImg, gamma, priorType);
    [newLhLoss, ~] = likelihood(denoisedImg, noisyImg);
    newTotalLoss = (1 - alpha) * newLhLoss + alpha * newPriorLoss;
    if (newTotalLoss < totalLoss)
        stepSize = stepSize + 0.1 * stepSize;
        oldNoisyImg = denoisedImg;
    else
        stepSize = stepSize - 0.5 * stepSize;
    end
end

end