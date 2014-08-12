function res = Benjamin08Client( A )

% This function is the Client Part for Benjamin08.
% Benjamin08 is a kind of outsourcing matrix disguising algorithm.
% The detailed information of Benjamin08 is in the paper:

% "Benjamin, D. & Atallah, M. J. Private and cheating-free outsourcing of
% algebraic computations Privacy, Security on about Benjamin08 is in the paper:
% and Trust, 2008. PST'08. Sixth Annual Conference on, 2008, 240-245"

% 'A' is the matrix to be disguised, 'res' is the result of the disguising.

    SizeA = size(A);
    n = SizeA(1);
    B = rand(n,n);
    A1 = rand(n,n);
    B1 = rand(n,n);
    A2 = A - A1;
    B2 = B - B1;
    R1 = rand(n,n);
    R2 = rand(n,n);
    R = R1 .* R2;
    clear R1;clear R2;clear B;

% We assume that matrix C is the result received from outsourcing server U1 and U2.

    C = rand(n,n);
 
    res = zeros(n,n);
    
    C = C - R;
    res = C + A1 * B1 + A2 * B2; 
    
end

