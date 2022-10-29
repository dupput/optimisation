% https://hungarianalgorithm.com/examplehungarianalgorithm.php
% Hungarian Algorythm

%% Build random transportation problem data
p = 20; % num people
%% set up attractions: Larger the number, the greater the attraction
mFeature = rand(p);
fFeature = rand(p);

%% compute a cost matrix
C = mFeature .* fFeature;

% minimisation for hungarian algorythm. For maximisation:
hC = 1 - C;

solutions = functions.applyHungarianAlgorithm(p, hC);



C = [82 	83 	69 	92;
	77 	37 	49 	92;
 	11 	69 	5 	86;
 	8 	9 	98 	23];






