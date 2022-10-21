% https://hungarianalgorithm.com/examplehungarianalgorithm.php
% Hungarian Algorythm

%% Build random transportation problem data
p = 400; % num people
%% set up attractions: Larger the number, the greater the attraction
mFeature = rand(p);
fFeature = rand(p);

%% compute a cost matrix
C = mFeature .* fFeature;
% For hungarian algorythm, minimisation. For maximisation:
hC = 1 - C;


%% Subtract minimas
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

%%
reducer = determineZeroRows(hC, p);
linesRequired = sum(sum(reducer));
loops = 0;
while linesRequired < p
    zC = hC;

    % Convert covered rows/cols to NaN
    coveredRows = find(reducer(1,:)==1);
    coveredCols = find(reducer(2,:)==1);
    zC(coveredRows, :) = NaN;
    zC(:, coveredCols) = NaN;

    % Find minimum non covered value and subtract from all uncovered elem
    val = min(min(zC));
    [rowV, colV] = find(zC==val);
    subtract = ~isnan(zC)*val;
    hC = hC - subtract;

    % Elements covered twice, add val
    rowIndices = find(reducer(1,:)==1);
    colIndices = find(reducer(2,:)==1);

    for ii = 1:length(rowIndices)
        i = rowIndices(ii);

        for jj = 1:length(colIndices)
            j = colIndices(jj);
            hC(i, j) = hC(i, j) + val;
        end
    end    
    
    reducer = determineZeroRows(hC, p);
    linesRequired = sum(sum(reducer));
    loops = loops + 1;

    disp(loops)
end

%% Determine optimal solution
optimalSolutions = findOptimalSolutions(hC, p);

solutions = zeros(p);
for i = 1:length(optimalSolutions)
    rowI = optimalSolutions(1, i);
    colI = optimalSolutions(2, i);
    
    msg = ['Man ' num2str(rowI) ' is paired with Woman ' num2str(colI)];
%     disp(msg)
    
    msg = ['Mans attraction to women is ' num2str(mFeature(rowI, colI))];
%     disp(msg)
    
    msg = ['Womans attraction to man is ' num2str(fFeature(rowI, colI))];
%     disp(msg)
    
    solutions(rowI, colI) = C(rowI, colI);
end


%% Functions

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



%% Determine zero rows
function reducer = determineZeroRows(zC, p)

numZero = sum(sum(zC==0));

% Reducer array: row 1 corresponds to rows, row 2 corresponds to cols
reducer = zeros(2, p);

while numZero > 0
    
    reducerRows = sum(zC'==0);
    [maxR, maxRi] = max(reducerRows);

    reducerCols = sum(zC==0);
    [maxC, maxCi] = max(reducerCols);    

    if maxR >= maxC
        % Remove zeros from the row
        zC(maxRi,:) = zC(maxRi,:) + 1;

        % Record the row
        reducer(1, maxRi) = 1;
    else
        % Remove zeros from the row
        zC(:,maxCi) = zC(:,maxCi) + 1;

        % Record the row
        reducer(2, maxCi) = 1;
    end
    numZero = sum(sum(zC==0));
end
end




