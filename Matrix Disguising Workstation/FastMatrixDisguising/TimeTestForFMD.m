function time = TimeTestForFMD( narr, coff, reptime )

% This function is the time test function for algorithm Fast Matrix Disguising(FMD).
% 'narr' is a vector of the size of disguised matrix ,'reptime' is the repeat time for the time test.
% 'coff' is the compressibility factor(from 0 to 1) of matrix 'A' in the disguise.
% The cost of disguise will be lower, if 'coff' is smaller. But the
% security of the disguise will decline.
% 'time' is a vector of the test time which is corresponded to 'narr'

    time = zeros(1,size(narr,2));
    for j = 1:size(narr,2)
        for r = 1:reptime
            clear A;
            clear res;
            clear H;
            n = narr(1,j);
            A = rand(n,n);

            beta = ceil(n * coff);
            
            tic
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

%  ***********************************************************************  

% If you want to test FMD in the situation that 'A' is in sparse matrix format,without optimization.
% In folder named "Sparse Matrix Sample",there are 4 sparse matrices provided.
% You can uncomment this segment and uncomment the segment above:

%       A(:,vec) = 0;
%       res = res * H + A;
      
%  ***********************************************************************        

        if issparse(res)
            res = full(res);
        end
        
            time(1,j) = time(1,j) + toc;
        end
        time(1,j) = time(1,j) / reptime;
    end
end

