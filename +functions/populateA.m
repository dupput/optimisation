function A = populateA(q, p)
    A = zeros(p+q, p*q);
    j = 1;
    i = 1;

    while j <= p*q
        sj = 1;
    
        while sj <= p
            A(i, j) = 1;
    
            sj = sj + 1;
            j = j + 1;
        end
        i = i + 1;
    end
    % Populate Demand
    offset = 0;
    ro = i-1 ;
    for j = 1:p 
    
        for i = 0:q-1
            loc = p*i+1 + offset;
            A(j+ro, loc) = -1;
        end
    
        offset = offset + 1;
    end
    disp(A)
end
