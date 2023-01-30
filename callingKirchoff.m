function T = getTable


% Iteratively calling manhattanNetwork for different values of N
% for N = [2,5, 10, 20, 50, 100, 200, 300, 400, 500, 1000]
%     tic
%     Vdrop = manhattanNetwork(N);
%     et = toc;
%     data(end+1, [1,2,3]) = [N, Vdrop, et];
% end

    
data = [
    2.0000    1.0000    0.0453
    5.0000    2.1364    0.0094
   10.0000    3.0117    0.0096
   20.0000    3.8923    0.0251
   50.0000    5.0584    0.0613
  100.0000    5.9408    0.2089
  200.0000    6.8234    2.0277
  300.0000    7.3396    9.2630
  400.0000    7.7059   34.1972
  500.0000    7.9900   90.1843];

data(:,4) = [6;42;182;762;4902;19802;79602;179402;319202;499002];

T = array2table(data, 'VariableNames', {'N', 'Resistance (Ohm)', 'Time (s)', 'Number of variables'});
