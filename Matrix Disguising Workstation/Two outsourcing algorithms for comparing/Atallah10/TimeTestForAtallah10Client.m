function time = TimeTestForAtallah10Client( narr, reptime )

% This function is the time test function for algorithm Atallah10's client part.
% 'Atallah10' is a kind of outsourcing matrix disguising algorithm.
% The detailed information about algorithm Atallah10 is in the paper:

% "Atallah, M. J. & Frikken, K. B. Securely outsourcing linear algebra
% computations Proceedings of the 5th ACM Symposium on Information,
% Computer and Communications Security, 2010, 48-59"

% 'narr' is a vector of the size of disguised matrix ,'reptime' is the repeat time for the time test.
% 'time' is a vector of the test time which is corresponded to 'narr'

    time = zeros(1,size(narr,2));
    for f = 1:size(narr,2)
        for r = 1:reptime
            clear A;
            clear ATrans;
            clear BTrans;
            clear c;     
            n = narr(1,f);
            A = rand(n,n);
            
            tic    
          
            B = rand(n,n);
            t = 1;

%   *********** for security reason, client send 4t+2 matrices to server,
%   including 2t+1 valid matrices and 2t+1 'noise' matrices.  ************
           
            valid = sort(randperm(4*t+2,2*t+1));
            x = randn(1,2*t+1);
            ATrans = zeros(n,n,4*t+2);
            BTrans = zeros(n,n,4*t+2);

%   ************************** 2t+1 valid matrices ************************

            c = rand(n,n,1);
            for k = 1:2*t+1
                m = valid(k);
                temp = c(:,:,1) * x(k);
                ATrans(:,:,m) = temp + A;
                BTrans(:,:,m) = temp + B;
            end
            
%   ***********************2t+1 invalid matrices as noise for security ***********************

            for k = 1:4*t+2
                if ~ismember(k,valid)
                    ATrans(:,:,k) = rand(n,n);
                    BTrans(:,:,k) = rand(n,n);
                end
            end 
            
            time(1,f) = time(1,f) + toc;         
        end
        time(1,f) = time(1,f) / reptime;
    end
end

