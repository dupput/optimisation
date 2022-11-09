clear; clc


%% Question 1
% Create symbols
syms x_1 x_2

% Define function
func = 0.5*x_1^2 - x_2^2 - x_1*x_2 - 2*x_1 - 6*x_2;

% Define hessian and function
H = double(hessian(func, [x_1, x_2]));
f = [-2; -6];

% Inequality constraints
A = [1 1; -1 2; 2 1];
b = [2; 2; 3];

% Minimisation as f is positive
[x, fval] = quadprog(H, f, A, b)


%% Question 2
syms x

n = 5;
m = 16;
A = rand(m,n);
b = rand(n,1);
