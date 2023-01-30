function plotFilteredHist(filteredMinimum)


% Create plot
figure('Renderer', 'painters', 'Position', [10 10 900 300]); hold on
histogram(filteredMinimum(:,1), 40, 'EdgeAlpha',0.2)
histogram(filteredMinimum(:,2), 200, 'EdgeAlpha',0.2)
grid on; grid minor; xlabel('x'); ylabel('Quantity'); 
legend('x(1) Values', 'x(2) Values')