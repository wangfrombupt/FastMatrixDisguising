function B = ExtendB ( B1,n,beta )
    block = ceil(n/beta);
    B(n,n) = 0;
    for i = 1:block
        for j = 1:n
            B((i-1)*beta+1:i*beta,j) = B1(i,j);
        end
    end
    sz = size(B);
    if sz(1) > n
        B(n+1:sz(1),:) = [];
    end
end

