%% Build random transportation problem data
p = 10; % num factories
q = 10; % num markets
totalSupply = 1;
totalDemand = 1;    
% Experiment with these bits
%% set up demands and supplies
s = rand(p,1);
% s = ones(p,1);
s = totalSupply*s/sum(s);
% d = rand(q,1);
d = ones(q,1);
d = totalDemand*d/sum(d);

%% set up coords of supplies and demands
Xs = rand(p,1); Ys = rand(p,1);
Xd = rand(q,1); Yd = rand(q,1);

%% compute a cost matrix
XXs = repmat(Xs,1,q); YYs = repmat(Ys,1,q);
XXd = repmat(Xd',p,1); YYd = repmat(Yd',p,1);
C = ((XXs-XXd).^2 + (YYs-YYd).^2).^0.5;  % cost matrix

f = reshape(C', [], 1);
% A = [];
% b = [];

% A = zeros(
% A = [1 1 0 0
%     0 0 1 1
%     -1 0 -1 0
%     0 -1 0 -1
%     ];
A = functions.populateA(p, q);

b = [s;-d];

Aeq = [];
beq = [];

lb = zeros(size(f));
ub = [];

[x,fval,exitflag] = linprog(f, A, b, Aeq, beq, lb, ub)

close all
figure
scatter(0, 0, 0.01, 'r', 'filled')
hold on
scatter(0, 0, 0.01,'b', 'filled') 

i = 0;
for ii = 1:p
    for jj = 1:q
        i = i + 1;
        
        if x(i) == 0
            continue
        end

        xvectors = [Xs(ii), Xd(jj)];
        yvectors = [Ys(ii), Yd(jj)];

        xmid = (xvectors(1) + xvectors(2))/2;
        ymid = (yvectors(1) + yvectors(2))/2;

%       plot(xmid, ymid, 'o')
        hold on
        plot(xvectors, yvectors, 'k', LineWidth=x(i)*5)
    end
end
scatter(Xs, Ys, s*150, 'r', 'filled')
scatter(Xd, Yd, d*150,'b', 'filled') 
legend('Factories', 'Markets')















