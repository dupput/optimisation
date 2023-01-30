clc
nvars = 2;
fun = @(x) eddieSecretFunction(x');

options = optimoptions("particleswarm",...
    'MaxIterations', 1000, ...
    'Display','none', ...
    'SwarmSize', 1000);
    
min_fval = Inf;
% tolerance = 0.001;
i = 1;
allMinimum = [1,1,1];
notWorthy = [1,1];
while i < 1000
    disp(i/10)
    [x, fval] = particleswarm(fun,nvars,[],[],options);
    
    allMinimum(i,:) = [x, fval];
    if fval < min_fval
        disp('Found new minimum')
        notWorthy(end+1,:) = x;
        min_fval = fval;
        disp(min_fval)
        disp(x)
    elseif (fval-min_fval) < 0.1
        % Close enough
        notWorthy(end+1,:) = x;
    end
    i = i+1;
end

save('bulkAnalysis','allMinimum','notWorthy', 'min_fval', 'min_x', 'extremeMinima')

0.0142

min_x = [1.9943    3.9994];
