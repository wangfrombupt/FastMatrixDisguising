function Atallah10Server(ClientIP)

    % This function is the Server Part for 'Atallah10'.
    % 'Atallah10' is a kind of outsourcing matrix disguising algorithm.
    % The detailed information of Atallah10 is in the paper:

    % "Atallah, M. J. & Frikken, K. B. Securely outsourcing linear algebra
    % computations Proceedings of the 5th ACM Symposium on Information,
    % Computer and Communications Security, 2010, 48-59"
    
    % ATrans and BTrans are the matrix received from the client.
    % ABTrans is the diguising result,which is to be sent back to client.
    
    GetFile(ClientIP);  % 'Client IP' should be replaced by the client's IP address
    disp('File received successfully!');

    load ws1.mat
    SizeA = size(ATrans);
    n = SizeA(1);
    mat_num = SizeA(3);
    ABTrans = zeros(n,n,mat_num);
    
    for k = 1:mat_num
        ABTrans(:,:,k) = ATrans(:,:,k) * BTrans(:,:,k);
    end

    disp('Disguising completed!');
    save 'PATH\ws2.mat' ABTrans;  %'PATH' should be replaced by the workstation path
   
    SendFile('ws2.mat');
    disp('File sent successfully!');
    
end

