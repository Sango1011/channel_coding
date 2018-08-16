% Sarah Ngo
% Channel Coding - Linear Block code [N,K] - [7,4]
% ECE 631 Digital Communication
% March/April 2018

% VARIABLES
N0 = 4; % used for the M-ary QAM
M = 2^N0;    %M-ary needed
L = 960;  % total information length
index2 = 1;

for N0 = 4:2:8
index1 = 1;
M = 2^N0;
offset = 10*log10(N0);
    for SNR = 0:20
        E = 0;
        for j = 1:10
            for i = 1:100
                % Binary Source
                s = randi([0 1],1,L);   

                C = reshape(s,N0,[]);    %information is split into columns
                CT = C';            % switch information into rows

                % QAM Modulation
                U = mymodulator(CT,N0);  % pass in information and data bit size
                % AWGN Channel
                UN = awgn(U,SNR+offset, 'measured');  % adding noise to signal, measured - SNR
                % Detector
                D = mydetector(UN,M);     % UN = input signal with noise and M-ary 
                %Demodulator
                R = mydemodulator(D,N0);     % Input the Dected value and N0

                E = biterr(CT,R)+E;
            end
        end

        Avg = E/1000;  % average eorrors 
        x(index1) = SNR;
        Error(index2,index1) = Avg/L;
        yb = 10^(SNR/10);
        Pb(index2,index1) = (4/log2(M))*qfunc(sqrt((3*yb*log2(M))/(M-1)));
        index1 = index1 + 1;    
    end
    index2 = index2 + 1;
end
figure()
semilogy(x,Error(1,:),x,Pb(1,:),'--',x,Error(2,:),'-*',x,Pb(2,:),'--',x,Error(3,:),'-o',x,Pb(3,:),'--');
%plot(x,Error(1,:),x,Error(2,:),'-*',x,Error(3,:),'-o');
legend('16-QAM','16-Theory','64-QAM','64-Theory','256-QAM','256-Theory')
%legend('16-QAM','64-QAM','256-QAM')
ylabel('Probability of Bit Error')
xlabel('Signal to Noise Ratio (dB)')
title('Bit Errors without Channel Coding')
grid on

