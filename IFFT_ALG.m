function [fout] = IFFT_ALG(fin)
    % assume length(F)=2^n
    N = length(fin);
    fout = conj( FFT_ALG(conj(fin)) )/N;
    %N = length(fin);
    %y =FFT_ALG(fin) /N;
    %fout = [y(1), y(end:-1:2)];
end