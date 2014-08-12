function [ ATrans,BTrans ] = Atallah10Client( A, ServerIP )

% This function is the Client Part for 'Atallah10'.
% 'Atallah10' is a kind of outsourcing matrix disguising algorithm.
% The detailed information of Atallah10 is in the paper:

% "Atallah, M. J. & Frikken, K. B. Securely outsourcing linear algebra
% computations Proceedings of the 5th ACM Symposium on Information,
% Computer and Communications Security, 2010, 48-59"

% A is the matrix to be disguised, 
% ATrans and BTrans should be sent to the outsourcing server for disguising.
% 'ServerIP' is the IP addresss of outsourcing server

    SizeA = size(A);
    n = SizeA(1);
    B = rand(n,n);
    t = 1;

%   ************ for security reason, client send 4t+2 matrices to server,
%   including 2t+1 valid matrices and 2t+1 'noise' matrices. *************

    valid = sort(randperm(4*t+2,2*t+1));
    x = randn(1,2*t+1);
    ATrans = zeros(n,n,4*t+2);
    BTrans = zeros(n,n,4*t+2);

%   ************************** 2t+1 valid matrices **************************

    c = rand(n,n,1);
    for k = 1:2*t+1
        m = valid(k);
        temp = c(:,:,1) * x(k);
        ATrans(:,:,m) = temp + A;
        BTrans(:,:,m) = temp + B;
    end
    
%   ********************* 2t+1 invalid matrices as noise for security ******************
    
    for k = 1:4*t+2
        if ~ismember(k,valid)
            ATrans(:,:,k) = rand(n,n);
            BTrans(:,:,k) = rand(n,n);
        end
    end 

%  *******************************************************************************************************
    
% if you want to test the whole process of 'Atallah10' algorithm, the program segment below may be helpful:   

%  *********************** (Client Part) Send ATrans and BTrans to server ********************************
    
    save 'PATH/ws1.mat' ATrans BTrans; %'PATH' should be replaced by the workstation path
    SendFile('ws1.mat');
    pause(5);
    
    flag = 1;
    while flag
        try
            GetFile(ServerIP) 
            flag = 0;
        catch
        end
    end
    load ws2.mat  
    
% ************************************* Restore the disguised matrix ***********************************

    res = zeros(n,n);
    y = zeros(1,2*t+1);

    for i = 1:n
        for j = 1:n
            for k = 1:2*t+1
                m = valid(k);         
                y(k) = ABTrans(i,j,m);     
              end
            res(i,j) = interp1(x,y,0,'spline');    
        end
    end
    
    AA = zeros(n,n);
    AA = res / B;
%     corr2(A,AA);
   
end

