function GetFile(ip)
    tcp=tcpip(ip,1314);
    set(tcp,'InputBufferSize',100000000);
    fopen(tcp);
    while tcp.BytesAvailable==0
        pause(0.1);
    end
    filename=fread(tcp,tcp.BytesAvailable/2,'uint16'); %get filename
    filename=char(filename);
    filename=filename';
    fwrite(tcp,1314,'uint16');  %filename got successfully
    while tcp.BytesAvailable==0
        pause(0.1);
    end
    disp(['File receiving...',filename]);
    filesize = fread(tcp,1,'uint32');
    disp(['File size:',num2str(filesize),'bytes']);
    fwrite(tcp,1314,'uint16');  %filesize got successfully
    while tcp.BytesAvailable~=filesize
        pause(0.5);
    end
    data=fread(tcp,filesize,'uint8');
    fwrite(tcp,1314,'uint16');  
    [path, name, ext]=fileparts(filename);
%     filename=[name, '_' , num2str(round(rand*10000)), ext];
    filename = [name, ext];
    fid=fopen(filename,'w');
    fwrite(fid,data,'uint8');
    fclose(fid);
    fclose(tcp);
end