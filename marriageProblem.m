% https://hungarianalgorithm.com/examplehungarianalgorithm.php
% Hungarian Algorythm

%% Build random transportation problem data
p = 20; % num people
%% set up attractions: Larger the number, the greater the attraction
mFeature=rand(p,1);
fFeature=rand(p,1);
C = abs(mFeature-fFeature');

%% Hungarian algorithm

% minimisation for hungarian algorythm. For maximisation:
hC = 1 - C;

solutions = functions.applyHungarianAlgorithm(hC);

%% intlinprog solution
% 
% 
% A = functions.populateA(p, p, 'marriage');
% 
% b = 2*ones(p+p);
% 
% 




