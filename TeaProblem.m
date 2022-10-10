A = [2 1; 1 2];
b = [8; 10];
f = [-1 -1]; % Maximise
Aeb = []; Beb = [];
linprog(f, A, b, Aeb, Beb, zeros(size(f)))