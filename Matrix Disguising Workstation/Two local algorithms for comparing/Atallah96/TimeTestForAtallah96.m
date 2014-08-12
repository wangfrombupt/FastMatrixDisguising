function time = TimeTestForAtallah96( narr, reptime )

% This function is the time test function for algorithm 'Atallah96'.
% 'Atallah96' is a local matrix disguising algorithm. 
% The detailed infomation is in the paper:

% "Atallah, M. J.; Pantazopoulos, K. N. & Spafford, E. H. Secure
% outsourcing of some computations, Computer Science Technical Reports, 1996"

% 'narr' is a vector of the size of disguised matrix ,'reptime' is the repeat time for the time test.
% 'time' is a vector of the test time which is corresponded to 'narr'

    time = zeros(1,size(narr,2));
    for j = 1:size(narr,2)
        for r = 1:reptime
            clear A;
            clear B;
            clear res;
            clear D;
            n = narr(1,j);
            A = rand(n,n);
            tic     
                 res = zeros(n,n);
                 B = rand(1,n);
                 D = randperm(n);
                 for k = 1:n
                     temp = D(k);
                     for i = 1:n         
                         res(i,k) = A(i,temp) * B(k);
                     end   
                 end
            time(1,j) = time(1,j) + toc;         
        end
        time(1,j) = time(1,j) / reptime;
    end
end





