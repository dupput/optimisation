function A = populateA(p, q, an)
    sA = zeros(1, p*q);
    
    % Create supply end
    for i = 1:q
        sA(1,i) = 1;
    end
    
    circ = functions.circulant(sA, 1);
    
    index = 1;
    for i = 1:p-1
        index = index + q;
        newRow = circ(index,:);
        sA = [sA;newRow];
    end
    
    if strcmp(an, 'transportation')
        % Demand section
        pattern = -eye(q);
    elseif strcmp(an, 'marriage')
        pattern = eye(q);
    end
    dA = repmat(pattern, 1, p);
    
    % Concatanate sections
    A = [sA; dA];
end
