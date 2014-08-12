function time = TimeTestForRMD( narr, reptime )

% This is the time test function for Random Matrix Disguising(RMD)
% The disguising method: matrix A is multiplied by a random reversible matrix, 
% 'res' is the disguising result of the matrix A
% 'narr' is a vector of the size of disguised matrix ,
% 'reptime' is the repeat time for the time test.
% 'time' is a vector of the test time which is corresponded to 'narr'

    time = zeros(1,size(narr,2));
    for j = 1:size(narr,2)
        for r = 1:reptime
            clear A;
            clear B;
            clear C;
            n = narr(1,j);
            A = rand(n,n);   
            tic
                B = rand(n,n);
                while(rank(B)~= n)
                    B = rand(n,n);
                end
                res = zeros(n,n);           
                res = A * B;
            time(1,j) = time(1,j) + toc;
        end
        time(1,j) = time(1,j) / reptime;
    end
end

