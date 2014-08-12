function [res,H,n,beta] = FastMatrixDisguising( A, coff )

% Fast Matrix Disguising(FMD) is a kind of local matrix disguising algorithm.

% 'A' is the matrix to be diguised, 'A' can be either a sparse format matrix or a
% full format matrix, but a non-sparse matrix in sparse format is not recommended.  

% 'coff' is the compressibility factor(from 0 to 1) of matrix 'A' in the disguising.
% The cost of disguising will be lower, if 'coff' is smaller. But the
% security of the disguise will decline.

% 'res' is the disguising result of 'A', 'H' is the key of the disguising,
% 'n' is the size of matrix 'A', 'beta' = ceil(n * coff);

    Size = size(A);
    n = Size(1);

    beta = ceil(n * coff);
    
    if beta >= n
        H = rand(1,n);
        res = zeros(n,1);
        res = row_sum(A);
        vec = 1;
    else
        block = ceil(n/beta);
        vec = 1:beta:(block-1)*beta+1;
        H = rand(block,n);
        H(:,vec) = orth(rand(block,block));

        res = zeros(n,block);
        B = ones(beta,1);
        if beta * block > n
            for i = 1:block-1
                res(:,i) = A(:,(i-1)*beta+1:i*beta) * B;
            end
            B = ones(n-i*beta,1);
            res(:,block) = A(:,i*beta+1:n) * B;
        else
            for i = 1:block
                res(:,i) = A(:,(i-1)*beta+1:i*beta) * B;
            end
        end
    end
    
%  **************** Optimization for sparse matrix 'A' *******************
% if 'A' is in sparse matrix format and its sparsity is smaller than 0.01,
% FMD can be optimized as below:

    res = res * H;
    if issparse(A) && (nnz(A)/n/n < 0.01)
        A(:,vec) = 0;
        nz = find(A);
        res(nz) = res(nz) + A(nz);
    else
        A(:,vec) = 0;
        res = res + A;
    end
     
    if issparse(res)
        res = full(res);
    end
    
end

