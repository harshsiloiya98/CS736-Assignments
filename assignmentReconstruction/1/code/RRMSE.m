function rrmse = RRMSE(A,B)
%A = double(A);
rrmse = sqrt(sum((A(:)-B(:)).^2)/sum((A(:)).^2));
end