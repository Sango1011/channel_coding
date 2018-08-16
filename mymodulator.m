% Sarah Ngo
% Channel Coding
% ECE 631 Digital Communication
% March 2018
%
    % This function is a 2^K-ary QAM mapper of a K bits of information (C).
    % It takes in the information matrix followed by the number of bits.
    % Where 2^K is a perfect square.
    
function modulator = mymodulator(C,N)
    
    X = N/2;    %half of the data bits for modulaiton
    H = (2^X)/2;    %used for half of decimal representation
    [L,~] = size(C);    %used for loop of information.
    modulator = zeros(1, L);   %allocate memory
    
    for k = 1:L
        v = C(k,:);
        CS = reshape(v,X,[]);  %split into two columns are info
        CST = CS';  %transpose to have into in rows 

        D1 = bi2de(CST(1,:), 'left-msb');    %convert each to decimal equivalent
        D2 = bi2de(CST(2,:), 'left-msb');    %used in calculating the mapped value

        % calculating the real part
        if D1 < H       % mapped to negavite values
            a = -1*(2^X + (-2*D1 - 1));
        else             % mapped to positve values
            a = 2^X + (-2*(D1 - H) - 1);
        end

        % calculating the imaginary part
        if D2 < H       % mapped to negavite values
            b = -1*(2^X + (-2*D2 - 1));
        else            % mapped to positve values
            b = 2^X + (-2*(D2 - H) - 1);
        end

        modulator(1,k) = complex(a,b);
    end