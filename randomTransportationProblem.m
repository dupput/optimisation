%% Build random transportation problem data
p = 10; % num factories
q = 6; % num markets
totalSupply = 1;
totalDemand = 1;    
% Experiment with these bits
%% set up demands and supplies
s = rand(p,1);
s = totalSupply*s/sum(s);
d = rand(q,1);
d = totalDemand*d/sum(d);

%% set up coords of supplies and demands
Xs = rand(p,1); Ys = rand(p,1);
Xd = rand(q,1); Yd = rand(q,1);

%% compute a cost matrix
XXs = repmat(Xs,1,q); YYs = repmat(Ys,1,q);
XXd = repmat(Xd',p,1); YYd = repmat(Yd',p,1);
C = ((XXs-XXd).^2 + (YYs-YYd).^2).^0.5;  % cost matrix

%% Find a solution using linprog
f = reshape(C', [], 1);

A = functions.populateA(p, q);
b = [s;-d];

Aeq = [];
beq = [];

lb = zeros(size(f));
ub = [];

[x,fval,exitflag] = linprog(f, A, b, Aeq, beq, lb, ub);

%% 
% Generate a graph where line and marker thickness 
% corresponds to size of values

close all
figure
scatter(0, 0, 0.01, 'b', 'filled')
hold on
scatter(0, 0, 0.01,'g', 'filled') 

i = 0;
for ii = 1:p
    for jj = 1:q
        i = i + 1;
        
        if x(i) == 0
            continue
        end

        xvectors = [Xs(ii), Xd(jj)];
        yvectors = [Ys(ii), Yd(jj)];

        plot(xvectors, yvectors, 'k', LineWidth=x(i)*(p+q))
    end
end
scatter(Xs, Ys, s*p*30, 'b', 'filled')
scatter(Xd, Yd, d*p*30,'g', 'filled') 
grid on; grid minor;
xlim([0 1.2])
ylim([0 1.2])
legend('Factories', 'Markets')















