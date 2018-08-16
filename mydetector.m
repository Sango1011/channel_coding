% Sarah Ngo
% Channel Coding
% ECE 631 Digital Communication
% March 2018
%
    % This function takes in received information after AWGN
    % It will correlate it with the points on an M-ary QAM
    
function detector = mydetector (U,M)
    
    x = sqrt(M) - 1;    % find the vales of QAM ie -3 to 3 by 2's.
    detector = zeros(1, length(U)); %allocate memory
    
    for t = 1:length(U) % outter loop to cycle through values of U
        p = angle(U(t));    % angle of received data
        R = zeros(1,M/4);    % allocated memory
        s = 1;      %starting for storing values
        
        % generate a+bi of QAM
        if (p > 0) && (p <= pi/2)       %QI
            for a = 1:2:x
                for b = 1:2:x        %both are positive 
                    R(s) = a + b*1i;   %store generaged a+bi
                     s = s+1;       %increment the index
                end
            end
        elseif (p > pi/2) && (p <= pi)   %QII
            for a = -1:-2:-x
                for b = 1:2:x          %real is neg imag is positive
                    R(s) = a + b*1i;   %store generaged a+bi
                     s = s+1;       %increment the index
                end
            end
        elseif (p > -pi) && (p <= -pi/2)    %QIII
            for a = -1:-2:-x
                for b = -1:-2:-x        % both are negatvie
                    R(s) = a + b*1i;   %store generaged a+bi
                     s = s+1;       %increment the index
                end
            end
        else        %QIV
            for a = 1:2:x
                for b = -1:-2:-x        %real positive, imag negative
                    R(s) = a + b*1i;   %store generaged a+bi
                     s = s+1;       %increment the index
                end
            end
        end
        
        % find the difference between each
        diff = zeros(1,length(R));   %allocate memory
        for s = 1:length(R)
            diff(s) = U(1,t) - R(s);     %difference between the points
        end
        
        A = abs(diff);  % Magnitudes
        minn  = min(A); % Minimum distance
        index = A(:) == minn;    % Index of array where the min is
        detector(1,t) = R(1,index);   % Store detected modulation        
    end
    