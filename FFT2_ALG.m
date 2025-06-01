function X = FFT2_ALG(x)    
    [N, M] = size(x);      % get row-count N and column-count M of x
    X= zeros(N, M);        %initialize with zeros 
    
    %Loop over each row
    for r = 1:N                   
        X(r, :)= FFT_ALG(x(r, :));  
        % x(r, :) selects entire r-th row as a 1×M vector
        % FFT_ALG(… ) returns its 1-D DFT (also 1×M)
        % we store that back into row r of X
    end                           

    % 4) Loop over each column
    for c = 1:M                   
        col= X(:, c).';   % X(:,c) grabs column c as N×1, then .' transposes to 1×N
        fft_row= FFT_ALG(col);
        % now fft_row is the 1×N DFT of that column
        X(:, c)= fft_row.';   % transpose back to N×1 and store into column c of X
    end                           

end                               