function reducer = determineZeroRows(zC, p)
% /*----------------- determineZeroRows -----------------
%  |  Function determineZeroRows
%  |
%  |  Purpose:  Function finds the minimum number of rows and columns
%  |            required to 'cover' all zeros in the matrix.
%  |
%  |  Parameters:
%  |	zC -- An edited C matrix with row and column minimisations taken
%  |          place already
%  |
%  |  Returns:  Reducer array of (2, p) shape where row 1 corresponds to
%  |            the row indices and row 2 corresponds to the column
%  |            indices. Array represents map to cover all zeros in hC
%  |            
% *-------------------------------------------------------------------*/

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