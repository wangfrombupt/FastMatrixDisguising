function time = TimeTestForFMDcoff( n, coffarr, reptime )

% This function is the time test function for algorithm Fast Matrix Disguising(FMD).
% It is aimed to test how the 'coff' value effect the cost of Fast Matrix Disguising.

% 'coffarr' is a vector of the 'coff' of disguised matrix ,
% 'coff' is the compressibility factor(from 0 to 1) of matrix 'A' in the disguising.
% The cost of disguising will be lower, if 'coff' is smaller. But the security of the disguising will decline.

% 'reptime' is the repeat time for the time test, 'n' is the size of the disguised matrix.
% 'time' is a vector of the test time which is corresponded to 'narr'.

    time = zeros(1,size(coffarr,2));
    for j = 1:size(coffarr,2)
        for r = 1:reptime
            clear A;
            clear res;
            clear H;
            A = rand(n,n);

            bsize = ceil(n / coffarr(j));

            tic
                if bsize >= n
                    H = rand(1,n);
                    res = zeros(n,1);
                    res = row_sum(A);
                    vec = 1;
                else
                    block = ceil(n/bsize);
                    vec = 1:bsize:(block-1)*bsize+1;
                    H = rand(block,n);
                    H(:,vec) = orth(rand(block,block));

                    res = zeros(n,block);
                    B = ones(bsize,1);  
                    if bsize * block > n 
                        for i = 1:block-1
                            res(:,i) = A(:,(i-1)*bsize+1:i*bsize) * B;
                        end
                        B = ones(n-i*bsize,1);      
                        res(:,block) = A(:,i*bsize+1:n) * B;
                    else 
                        for i = 1:block
                            res(:,i) = A(:,(i-1)*bsize+1:i*bsize) * B;
                        end
                    end
                end
                
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
                    
            time(1,j) = time(1,j) + toc;
        end
        time(1,j) = time(1,j) / reptime;
    end
end

