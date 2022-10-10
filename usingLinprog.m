%% With equalities
% Maximise value
f = [-1 -2];

A = [1 0;
     0 1];
b = [7;
     6];

Aeq = [2/3 1/4; 
       1/3 3/4];
beq = [5; 
       5];

lb = zeros(size(f));
ub = [];

% [x,fval,exitflag] = linprog(f, A, b, Aeq, beq, lb, ub);

%% With slack
% Maximise value
f = [-1 -2 0 0];

A = [
    1   0      1 1
    0   1      1 1
    2/3 1/4    1 1
    1/3 3/4    1 1
];
b = [7; 6; 5; 5];

Aeq = [];
beq = [];

lb = zeros(size(f));
ub = [];

[x,fval,exitflag] = linprog(f, A, b, Aeq, beq, lb, ub)


