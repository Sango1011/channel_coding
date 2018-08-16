% Sarah Ngo
% Channel Coding
% ECE 631 Digital Communication
% March 2018
%
    % This function is a 2^K-ary QAM de-mapper of a K bits of information.
    % It takes in the information matrix followed by the number of bits.
    % Where 2^K is a perfect square.
   
function demodulator = mydemodulator(R,N)
    
    X = N/2;    %half of the data bits for de-modulaiton
    H = 2^(X-1);    %used for half of decimal representation
    L = length(R);  %how many values need to be demudulated
    demodulator = zeros(L,N);   %allocate memory
    
    for m = 1:L
        z = R(1,m);     %pass value to variable
        a = real(z);       %real part
        b = imag(z);        %imaginary coefficient
        
        %finding decimal value of binary number for a and b
        if a < 0
            D1 = (-1*a - 2^X + 1)/(-2);
        else
            D1 = ((a - 2^X + 1)/(-2)) + H;
        end
        
        if b < 0
            D2 = (-1*b - 2^X + 1)/(-2);
        else
            D2 = ((b - 2^X + 1)/(-2)) + H;
        end
        
        %convert to binary equivalent
        C1 = de2bi(D1,X,'left-msb');
        C2 = de2bi(D2,X,'left-msb');
        
        demodulator(m,:) = [C1, C2];
    end