function A = RestoreOfFMD( DisA,H,n,beta )

% This function is to restore the disguised matrix so that the original matrix 'A' can be acquired
% 'DisA' is the matrix to be restored.
% 'res' is the restore result of 'DisA', 
% 'H' is the key of the disguising,
% 'n' is the size of matrix 'DisA'.

    B = ExtendB(H,n,beta);

    for i = 2 : n
        if mod(i,beta) ~= 1
            B(i,i) = B(i,i) + 1;
        end
    end
   
    A = zeros(n,n);
    A  = DisA / B;

end

