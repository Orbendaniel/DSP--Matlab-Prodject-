function [fout] = FFT_ALG(fin)
    N = length(fin);
    if N == 1
        fout = fin;
    else 
        fout = zeros(1, N);
        feven = FFT_ALG(fin(1:2:end));
        fodd = FFT_ALG(fin(2:2:end));
        if N 
        for k = 1:N/2
            t = fodd(k) * exp(-1i * 2 * pi * (k-1) / N);  % use k-1 to align MATLAB indexing
            fout(k) = feven(k) + t;
            fout(k + N/2) = feven(k) - t;
        end
    end
end
