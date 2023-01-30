function plotFiltered(allMinimum, filteredMinimum)

y = allMinimum(:,3);

figure('Renderer', 'painters', 'Position', [10 10 900 150])

%Plot all values
plot(y, ones(length(allMinimum), 1), '.', 'MarkerSize',15)
hold on; grid on; grid minor;
% Plot filtered data values
plot(filteredMinimum(:,3),ones(length(filteredMinimum),1), '.', 'MarkerSize',15)
xlabel('fval'); legend('Entire dataset', 'Data filtered by values above')