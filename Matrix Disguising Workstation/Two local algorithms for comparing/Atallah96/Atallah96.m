function [ res,n,D ] = Atallah96( A )

% 'Atallah96' is a local matrix disguising algorithm. 
% The detail infomation of 'Atallah96' is in the paper:

% "Atallah, M. J.; Pantazopoulos, K. N. & Spafford, E. H. Secure
% outsourcing of some computations, Computer Science Technical Reports, 1996"

% 'A' is the matrix to be disguised, 'res' is the result of the disguising, and
% matrix 'D' is the key and it is reversible.

    SizeA = size(A);
    n = SizeA(1);
    res = zeros(n,n);
    B = rand(1,n);
    D = randperm(n);
    for k = 1:n
        temp = D(k);
        for i = 1:n         
            res(i,k) = A(i,temp) * B(k);
        end   
    end
end
