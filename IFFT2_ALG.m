function [fout] = IFFT2_ALG(fin)
    N = length(fin(:,1));
    M = length(fin(1,:));
    y =FFT2_ALG(fin) /(N*M); 
    col_indices = [1, M:-1:2];
    row_indices = [1, N:-1:2];
    fout  = y(row_indices, col_indices);
end