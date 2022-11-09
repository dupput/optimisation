%% Build random travelling salesman problem data
n = 7; % num cities

% set up coords of supplies and demands
Xc = rand(n,1); Yc = rand(n, 1);
XXc = repmat(Xc,1,n); YYc = repmat(Yc,1,n);
C = ((XXc-XXc').^2 + (YYc-YYc').^2).^0.5;  % cost matrix
C(C==0) = Inf;
costSize = factorial(n-1);


% Begin Branching method
tic
% Initial row and column reduction
rowReducers = zeros(n, 1);
for i = 1:5
    rowReducers(i) = min(C(i, :));
end
M = C - rowReducers;

% Col reduction
colReducers = zeros(1, n);
for i = 1:5
    colReducers(i) = min(M(:, i));
end

M1 = M - colReducers;
cost1 = sum(rowReducers) + sum(colReducers);


startNode = 1;
% State space tree
nodeOrder = startNode;
minM = M1;
remainingNodes = 2:n;
while ~isempty(remainingNodes)
    minCost = Inf;
    
    for targetNode = remainingNodes
        [cost2, M2] = branchCost(nodeOrder(end), targetNode, minM);
        
        
        if cost2 < minCost
            node = targetNode;
            minCost = cost2;
            newM = M2;
        end
        
    end
    minM = newM;
    cost1 = cost1 + minCost;
    remainingNodes = remainingNodes(remainingNodes~=node);
    nodeOrder = [nodeOrder node];
end

nodeOrder = [nodeOrder startNode]
toc
% Plotting

close all
figure

hold on
for i = 1:n
    X1 = nodeOrder(i);
    X2 = nodeOrder(i+1);
    xvectors = [Xc(X1), Xc(X2)];
    yvectors = [Yc(X1), Yc(X2)];

    plot(xvectors, yvectors, 'b')
end
scatter(Xc, Yc, 'k', 'filled')



%% Functions


function [cost, M2] = branchCost(startNode, endNode, M1)
n = length(M1);
M2 = M1;
M2(startNode, :) = NaN;
M2(:, endNode) = NaN;
M2(endNode, 1) = NaN;

rowReducers = zeros(n, 1);
for i = 1:5
    rowReducers(i) = min(M2(i, :));
end
rowReducers(isnan(rowReducers)) = 0;

colReducers = zeros(1, n);
for i = 1:5
    colReducers(i) = min(M2(:, i));
end
colReducers(isnan(colReducers)) = 0;

cost = sum(colReducers) + sum(rowReducers) + M1(startNode, endNode);
end



% %% Set up constraints and apply linprog function
% f = zeros(costSize, 1);
% ic = 1;
% A = zeros(n, costSize);
% 
% rowi = 1;
% for j = 1:n-1
%     
%     for i = j+1:n
%         f(ic) = -C(i, j);
%         A(rowi, ic) = 1;
%         A(i, ic) = 1;
%         ic = ic + 1;
%     end
% 
%     rowi = rowi + 1;
% end
% 
% b = 2* ones(n, 1);
% 
% Aeq = [];
% beq = [];
%  
% % Enforce all results to equal 1
% intcon = ones(n, 1);
% 
% % Enforce binary results
% lb = zeros(costSize,1);
% ub = ones(costSize, 1);
% 
% % Apply intlinprog func
% [x, fval, exitFlag] = intlinprog(f,intcon,A,b,Aeq,beq,lb,ub);

