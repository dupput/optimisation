%% Build random transportation problem data
p = 4; % num people

% Experiment with these bits
%% set up demands and supplies
mFeature = rand(p,1);
mFeature = mFeature/sum(mFeature);
d = rand(p,1);
d = d/sum(d);

%% set up coords of supplies and demands
Xs = rand(p,1); Ys = rand(p,1);
Xd = rand(p,1); Yd = rand(p,1);

%% compute a cost matrix
XXs = repmat(Xs,1,p); YYs = repmat(Ys,1,p);
XXd = repmat(Xd',p,1); YYd = repmat(Yd',p,1);
C = ((XXs-XXd).^2 + (YYs-YYd).^2).^0.5;  % cost matrix

%% Subtract minimas
hC = C;
for ii = 1:p
    rowValues = hC(ii,:);
    minV = min(rowValues);
    hC(ii,:) = hC(ii,:) - minV;
end

for jj = 1:p
    colValues = hC(:,jj);
    minV = min(colValues);
    hC(:,jj) = hC(:,jj) - minV;
end

%% Determine zero rows

% https://hungarianalgorithm.com/examplehungarianalgorithm.php












