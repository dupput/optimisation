% Choosing optimal groups for the unit MDM3 — more bipartite matching

% There are p students in the class each of whom must be allocated to work 
% in a group on exactly one of q problems. Each student i has expressed a 
% preference order for each problem j, taking values 1, 2, . . . , q, where
% 1 denotes the student’s top preference and q denotes their least favourite. 
% The preferences are provided in a big matrix cij , and a synthesised 
% example will be provided.
% Write down and experiment with integer linear programs that allocate 
% students to groups. Here are some principles to bear in mind:

% • There should ideally be minimum and maximum group sizes.
% • Probably objective is to have best average satisfaction across the class 
% (least sum scores of preferences of allocated problems)
% • We might also try to enforce a constraint that no student gets allocated
% worse than (say) 3rd or 4th preference.
% ** Consider how this might work if students are of two genders and there 
% are rules like "no student can be allocated to a group which is otherwise 
% completely of the opposite gender”

clc; clear

%% Create preferences and set up cost matrix
RANDOMISE = false;
slack = 1;

% If a group needs removing
% REMOVE_GROUP = 4;

if RANDOMISE
    numStudents = 100;
    numGroups = 30;
    
    allPreferences = zeros(numStudents, numGroups);
    for i = 1 : numStudents
        preferences = 1 : numGroups;
        preferences = preferences(randperm(length(preferences)));
        allPreferences(i, :) = preferences;
    end
    C = allPreferences;
else
    C = readmatrix('ProblemRankData.csv');
    % Punish lower scores more
    C_heightened = C;
    numStudents = length(C);
    numGroups = width(C);
end

f = reshape(C_heightened', [], 1);

%% Set up constraints and apply linprog function
minSize = 3%ceil(numStudents / numGroups) - slack;
maxSize = 5%ceil(numStudents / numGroups) + slack;


% Define group constraints
% A_circ = zeros(1, numGroups);
% A_circ(1, 1) = 1;
% circ = functions.circulant(A_circ, 1);
circ = eye(numGroups);
A1 = repmat(circ, 1, numStudents);
A2 = -A1;

b2 = zeros(numGroups, 1);
b2(:,1) = maxSize;

b3 = zeros(numGroups, 1);
b3(:,1) = -minSize;

A = [A1; A2];
b = [b2; b3];

if exist('REMOVE_GROUP', 'var')
    b([REMOVE_GROUP, REMOVE_GROUP + numGroups]) = 0;
end

% Define student constraints
A_circ = zeros(1, numGroups*numStudents);
A_circ(1:numGroups) = 1;
circ = functions.circulant(A_circ, 1);

Aeq = A_circ;
for i = 1:numStudents-1
    rowIndex = numGroups * i + 1;
    row = circ(rowIndex, :);
    Aeq = [Aeq; row];    
end

beq = ones(numStudents, 1);
 
% Enforce all results to equal 1
intcon = ones(numStudents, 1);

% Enforce binary results
lb = zeros(numStudents*numGroups,1);
ub = ones(numStudents*numGroups, 1);

% Apply intlinprog func
[x, fval, exitFlag] = intlinprog(f,intcon,A,b,Aeq,beq,lb,ub);
%%
% Load in problem data
C = readmatrix('ProblemRankData.csv');

% Unravel C into one dimensional array
X = reshape(C', [], 1);

% Determine hyperparameters of problem from data
q = width(C);
p = length(C);

% Set min, max group sizes
gmin = 3;
gmax = 7;

% Initialise Aeq
Aeq = zeros(p, p*q);

% Iteratively populate each new row corresponding to its unravelled postion in X
shift = 1;
for i = 1:p
    Aeq(i, shift:i*14) = 1;
    shift = shift + 14;
end

beq = ones(p, 1);

% Build the inequality matrices A and b
pattern = eye(q);
A_max = repmat(pattern, 1, p);
b_max = gmax * ones(q, 1);

A_min = -A_max;
b_min = -gmin * ones(q, 1);

% Concatanate the min and max inequality matrices
A = [A_max; A_min];
b = [b_max; b_min];


% b([4, 18]) = 0;
b([6, 20]) = 0;


% Enforce all results to be integer values
intcon = ones(p, 1);

% Enforce binary results
lb = zeros(p*q,1);
ub = ones(p*q, 1);

% Apply intlinprog func
x = intlinprog(X,intcon,A,b,Aeq,beq,lb,ub);

% Each column represents group # and row represents student
solutions = reshape(x, numGroups,numStudents)';

plotSolutions(solutions, C, gmin, gmax)
% groups = assignNames(solutions, numGroups);

%% Assignment tables
function groupings = assignNames(solutions, numGroups)
groupings = struct;
for col = 1:numGroups
    students = find(solutions(:,col));
    groupings.(['group' num2str(col)]) = students;
end
end

%% Graphical checks
function plotSolutions(solutions, C, minSize, maxSize)

numGroups = width(C);
realSolutions = solutions .* C;
labels = {'1st Choice', '2nd Choice', '3rd Choice', '4th Choice', ...
    '5th Choice'};
worstChoice = max(max(realSolutions));

close all
figure()

xLabels = {};
plottingData = [];
for i = 1: numGroups
    xLabels{i} = ['Group ' num2str(i)];
    scores = zeros(1, worstChoice);

    for j = 1:worstChoice

        scores(1, j) = sum(realSolutions(:, i)==j);
    end
    plottingData = [plottingData; scores];
end

X = categorical(xLabels);
X = reordercats(X,xLabels);
bar(X, plottingData, 'stacked')
title(['Group sizes: ' num2str(minSize) ' to ' num2str(maxSize)])
ylabel('Number of students per group')
legend(labels{1:worstChoice}, 'location', 'best')
ylim([0 7])
end

