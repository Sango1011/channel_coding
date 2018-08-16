% Sarah Ngo
% Channel Coding
% ECE 631 Digital Communication
% April 2018
%
    % This function is a (7,4) Hamming Channel Code Encoder
    % it takes in 4 information bits and adds 3 parity bits 
    % to the end and outputs 7 bits of data called a code word.
    % The input is a M x 4 matrix and the output is a M X 7 matrix

function C = myHammingEncode (X)
    
    I = eye(4);
    P = [1 1 0; 0 1 1; 1 1 1; 1 0 1]; 
    G = [I P];
    [M, ~] = size(X);

    for i = 1:M
        u = X(i,:);
        C(i,:) = mod(u*G,2);
    end