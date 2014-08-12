function SendFile(f)

    fid=fopen(f);
    data=fread(fid);
    fclose(fid);
    
    %% get local IP
    p = GetIP();

    %% establish TCP link 
    tcp=tcpip('0.0.0.0',1314,'networkrole','server');               
    set(tcp,'OutputBufferSize',100000000);                          
    disp('Prepared!');
    fopen(tcp);                                                     
    fwrite(tcp,abs(f),'uint16');                                    
    while tcp.BytesAvailable~=2                                    
        pause(0.1);
    end
    disp('Filename transmitted!');
    fwrite(tcp,length(data),'uint32');                             
    while tcp.BytesAvailable~=4                                    
        pause(0.1);
    end
    disp('Filesize transmitted!');
    fwrite(tcp,data,'uint8'); 
    while tcp.BytesAvailable~=6                                   
        pause(0.1);
    end
    disp('File transmitted!');
    fclose(tcp);

end


