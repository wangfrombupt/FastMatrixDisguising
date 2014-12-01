function  t  = TimeTestForBenjamin08Client( narr,reptime )

% This function is the time test function for Benjamin08's client part.
% Benjamin08 is a kind of outsourcing matrix disguising algorithm.
% The detailed information of Benjamin08 is in the paper:

% "Benjamin, D. & Atallah, M. J. Private and cheating-free outsourcing of
% algebraic computations Privacy, Security on about Benjamin08 is in the paper:
% and Trust, 2008. PST'08. Sixth Annual Conference on, 2008, 240-245"

% We assume that matrix C is the result received from outsourcing server U1 and U2.
% 'narr' is a vector of the size of disguised matrix.
% 'reptime' is the repeat time for the time test.
% 't' is a vector of the test time which is corresponded to 'narr'.

    t = zeros(1,size(narr,2));
    for j = 1:size(narr,2)
        for r = 1:reptime
            clear A;clear A1;clear A2;clear res;
            clear B1;clear B2;clear C;clear R;
             
            n = narr(1,j);
            A = rand(n,n);   
        tic
            B = rand(n,n);
            A1 = rand(n,n);
            B1 = rand(n,n);
            A2 = A - A1;
            B2 = B - B1;
            R1 = rand(n,n);
            R2 = rand(n,n);
            R = R1 .* R2;
            clear R1;clear R2;clear B;
        t(1,j) = t(1,j) + toc;

  %      C = rand(n,n);   
  %     
  %      tic
  %          res = zeros(n,n);
  %          C = C - R;
  %          res = C + A1 * B1 + A2 * B2; 
  %      t(1,j) = t(1,j) + toc;
        
        end
    end
end



