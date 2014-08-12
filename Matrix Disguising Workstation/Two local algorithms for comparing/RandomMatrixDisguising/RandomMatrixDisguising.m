function [ res ,n, B ] = RandomMatrixDisguising( A )

% This is the function of RandomMatrixDisguising(RMD)
% The disguise method: matrix A is multiplied by a random reversible matrix B
% 'res' is the disguise result of the matrix A, matrix B is the key.

    Size = size(A);
    n = Size(1);
    A = rand(n,n);   

    B = rand(n,n);
    while(rank(B)~= n)
         B = rand(n,n);
    end
    res = zeros(n,n);           
    res = A * B;
end

