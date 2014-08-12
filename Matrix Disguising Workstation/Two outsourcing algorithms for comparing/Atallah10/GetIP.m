function lip = GetIP
% funtion : get local IP address
    [s,r]=system('ipconfig');
%     disp(r);
    try
        r = regexp(r,'IPv4 µÿ÷∑ . . . . . . . . . . . . : \d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}','match');
    catch
        r = regexp(r,'IPv4 Address . . . . . . . . . . . . : \d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}','match');
    end
    r=r{1};
    r=regexp(r,'\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}','match');
    lip=r{1};

end
