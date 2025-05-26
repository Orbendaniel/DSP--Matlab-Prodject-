function [fout] = IFFT_ALG(fin)
    % assume length(F)=2^n
    N = length(fin);
    fout = conj( FFT_ALG(conj(fin)) )/N;
end