function plotExtremeMinima(extremeMinima)


figure('Renderer', 'painters', 'Position', [10 10 900 300]); hold on
histogram(extremeMinima(:,1), 5, 'EdgeAlpha',0.2)
histogram(extremeMinima(:,2), 5, 'EdgeAlpha',0.2)
ax = gca; chart = ax.Children(2); datatip(chart,1.998,28); chart = ax.Children(1); datatip(chart,3.998,27);
grid on; grid minor; xlabel('x'); ylabel('Quantity'); 
legend('x(1) Values', 'x(2) Values', 'Location','north')