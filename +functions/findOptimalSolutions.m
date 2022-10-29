function optimalSolutions = findOptimalSolutions(hC, p)
optimalSolutions = zeros(2, p);
solI = 0;

while solI < p
    % Check if any rows have one 0 position
    rowZeros = sum(hC'==0);
    rowIndices = find(rowZeros==1);
    
    % If a row with one zero is found
    if ~isempty(rowIndices)
        for ii = 1:length(rowIndices)
            rowI = rowIndices(ii);
            colI = find(hC(rowI,:)==0);
            solI = solI + 1;
        
            optimalSolutions(:, solI) = [rowI, colI]; 
            hC(rowI, :) = NaN;
            hC(:, colI) = NaN;
        end
    end

    % Check if any cols have one 0 position    
    colZeros = sum(hC==0);
    colIndices = find(colZeros==1);
    
    % If a col with one zero is found
    if ~isempty(colIndices)
        for ii = 1:length(colIndices)
            colI = colIndices(ii);
            rowI = find(hC(:,colI)==0);
            solI = solI + 1;
        
            optimalSolutions(:, solI) = [rowI, colI]; 

            % Set row and col containing solution to NaN
            hC(rowI, :) = NaN;
            hC(:, colI) = NaN;
        end
    end
end
end
