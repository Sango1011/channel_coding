% Sarah Ngo
% Channel Coding
% ECE 631 Digital Communication
% April 2018
%
    % This function is a (7,4) Hamming Channel Code Decoder
    % it takes in 7 information bits and uses a syndrome to 
    % correct up to 1 error.

function S = myHammingDecode (X)
    
    I = eye(3);
    P = [1 0 1 1; 1 1 1 0; 0 1 1 1]; 
    H = [P I];
    HT = H';
    [M, ~] = size(X);
    A = [0 0 0 0 0 0 1; 0 0 0 0 0 1 0; 0 1 0 0 0 0 0; 0 0 0 0 1 0 0;
                0 0 0 1 0 0 0; 1 0 0 0 0 0 0; 0 0 1 0 0 0 0];

    for i = 1:M
        c = X(i,:);
        Syn = mod(c*HT,2);
        index = bi2de(Syn);
        if index == 0
            S(i,:) = c(1:4);
        else
            e(1,:) = A(index,:);
            SN = mod(c + e,2);
            S(i,:) = SN(1:4);
        end
    end