function [filteredRadonTf] = myFilter(Rf, c, Type)
% various filters

F = fft(Rf);
N = size(Rf, 1);
range = 0 : N-1;
w = 2 * pi / N * range;
w = (w - w(round(N / 2)))';

L = pi*c;

% Ram-Lak filter
if Type == 1
    Filter = abs(w);
    Filter(abs(w) > L) = 0;
    
% Shepp-Logan filter
elseif Type == 2
    Filter = abs(w) .* sin(0.5 * pi * w / L) ./ (0.5 *pi * w / L);
    Filter(w == 0) = 0;
    Filter(abs(w) > L) = 0;

% Cosine filter     
elseif Type == 3
    Filter = abs(w) .* cos(0.5 * pi * w / L);
    Filter(abs(w) > L) = 0;  
end

Filter = repmat(ifftshift(Filter), 1, size(Rf, 2));
filteredRadonTf = real(ifft(F .* Filter));
end