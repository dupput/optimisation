% 1. (a) Consider some generally pretty nasty function of three decision variables 
% x, y, z like for starters F (x, y, z) = x3 + 2y2 + z4 − x
% Prepare an anonymous function that encodes F for use with fmincon. See my livescript IntroFmin-
% con.mlx, for some guide as to how to do this.
% (b) Encode the linear equality constraint
% z = 1
% 2
% using Aeq and Beq for use in fmincon. (Of course, you could just change the F , but I want you
% to practice coding constraints.) Then encode the linear inequality constraints
% x + y ≥ 1
% using A and B for use in fmincon. Thus solve the resulting constrained minimisation problem,
% experimenting with the choice of initial solution guess.
% (c) Now, ditch the constraints in part (b). Instead, encode the nonlinear constraint
% G := x2 + y2 + z2 − 1 = 0
% using the nonlcon argument, and run fmincon. You’ll have to read through the manual page to
% work out how to do this — but of course a livescript model solution will follow.
% (d) What is the geometry implied in the part (c) constraint? Consider / analytically solve if possible
% the Lagrange multiplier problem ∇F = λ∇G. What does this mean, i.e., what is ∇G doing,
% geometrically? Use full return arguments
% [x,fval,exitglag,output]=...
% to analyse the Lagrange multiplier output returned by fmincon.
% (e)* Repeat with both of the equality constraints from (b) and (c) — and read up on multiple Lagrange
% multipliers.
% (f)* Experiment with different F , and design beautiful ways of plotting F on the equality constraint
% defined in (c).

fun = @(x)x(1).^3 + 2*x(2)^2 +x(3)^4 - x(1);

x0 = [1, 3, 0.5];

A = [-1 -1 0];
b = [-1];
% A = [];
% b = [];

Aeq = [0 0 1];
beq = [0.5];

ub = [];
lb = [];

nonclon = [];%@nonlcon;

[x,fval,exitglag,output] = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonclon);



function [c,ceq] = circlefun(x) 
c = [];
ceq = x(1)^2 + x(2)^2 + x(3)^2 - 1;
end






