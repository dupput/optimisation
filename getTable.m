function Table = getTable

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
  500.0000    7.9900   90.1843
  600.0000    8.2221  230.2268
  700.0000    8.4184  475.5943];

% Iteratively calling manhattanNetwork for different values of N
% for N =[750 800]
%     tic
%     Vdrop = manhattanNetwork(N);
%     et = toc;
%     data(end+1, [1,2,3]) = [N, Vdrop, et]
% end
% close all
    



Table = array2table(data, 'VariableNames', {'N', 'Resistance (Ohm)', 'Time (s)'});
end
% figure
% grid on; grid minor
% yyaxis left
% plot(Table.N, Table.("Time (s)"),'o-', 'LineWidth',1)
% ylabel('Time (s)')
% 
% hold on
% yyaxis right
% plot(Table.N, Table.('Resistance (Ohm)'), '-o' , 'LineWidth',1)
% ylabel('Resistance (Ohm)')








