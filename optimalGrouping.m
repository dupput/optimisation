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
REMOVE_GROUP = 4;

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
    C_heightened = C .^ 10;
    numStudents = length(C);
    numGroups = width(C);
end

f = reshape(C_heightened', [], 1);

%% Set up constraints and apply linprog function
minSize = ceil(numStudents / numGroups) - slack;
maxSize = ceil(numStudents / numGroups) + slack;

A_circ = zeros(1, numGroups);
A_circ(1, 1) = 1;
circ = functions.circulant(A_circ, 1);
    
A1 = repmat(circ, 1, numStudents);
A2 = -A1;

b1 = zeros(numGroups, 1);
b1(:,1) = maxSize;

b2 = zeros(numGroups, 1);
b2(:,1) = -minSize;

A = [A1; A2];
b = [b1; b2];

if exist('REMOVE_GROUP', 'var')
    b([REMOVE_GROUP, REMOVE_GROUP + numGroups]) = 0;
end

Aeq = ones(1, numStudents*numGroups);
beq = numStudents;
 
% Enforce all results to equal 1
intcon = ones(numStudents, 1);

% Enforce binary results
lb = zeros(numStudents*numGroups,1);
ub = ones(numStudents*numGroups, 1);

%% Apply intlinprog func
[x, fval, exitFlag] = intlinprog(f,intcon,A,b,Aeq,beq,lb,ub);

% Each column represents group # and row represents student
solutions = reshape(x, numGroups,numStudents)';

plotSolutions(solutions, C, minSize, maxSize)


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
legend(labels{1:worstChoice}, 'location', 'bestoutside')

end

