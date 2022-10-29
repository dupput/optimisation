function solutions = applyHungarianAlgorithm(C)
% /*----------------- applyHungarianAlgorithm -----------------
%  |  Function applyHungarianAlgorithm
%  |
%  |  Purpose:  Utilises an algorithm to solve the assignment problem 
%  |            in polynomial time. Algorithm works by minimising the best
%  |            solutions and maximising the worst solutions. This
%  |            algorithm works as a minimisation problem. Should the
%  |            maximum solution be required, the cost matrix needs to be
%  |            inverted.
%  |
%  |  Parameters:
%  |	C -- A square matirx consisting of the associated costs between
%  |         rows and columns
%  |
%  |  Returns:  The optimal matching of rows to columns of the cost matrix
% *-------------------------------------------------------------------*/
hC = C;
p = length(C);


%% Subtract row and column minimas
for ii = 1:p
    rowValues = hC(ii,:);
    minV = min(rowValues);
    hC(ii,:) = hC(ii,:) - minV;
end

for jj = 1:p
    colValues = hC(:,jj);
    minV = min(colValues);
    hC(:,jj) = hC(:,jj) - minV;
end

%% Reduce cost matrix
reducer = functions.determineZeroRows(hC, p);
linesRequired = sum(sum(reducer));
loops = 0;

while linesRequired < p
    zC = hC;

    % Convert covered rows/cols to NaN
    coveredRows = reducer(1,:)==1;
    coveredCols = reducer(2,:)==1;
    zC(coveredRows, :) = NaN;
    zC(:, coveredCols) = NaN;

    % Find minimum non covered value and subtract from all uncovered elem
    val = min(min(zC));
    subtract = ~isnan(zC)*val;
    hC = hC - subtract;

    for ii = 1:length(coveredRows)
        i = coveredRows(ii);

        for jj = 1:length(coveredCols)
            j = coveredCols(jj);
            hC(i, j) = hC(i, j) + val;
        end
    end    
    
    %% Determine zero rows
    reducer = functions.determineZeroRows(hC, p);
    linesRequired = sum(sum(reducer));
    loops = loops + 1;

    disp(['Iterations: ' num2str(loops)])
end

%% Determine optimal solution
optimalSolutions = functions.findOptimalSolutions(hC, p);

solutions = zeros(p);
for i = 1:length(optimalSolutions)
    rowI = optimalSolutions(1, i);
    colI = optimalSolutions(2, i);
    
    solutions(rowI, colI) = C(rowI, colI);
end
end