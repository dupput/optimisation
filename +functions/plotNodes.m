function fig = plotNodes(x, y)

fig = figure;
plot(x, y, '.', 'Color', [0 0.5 0], 'MarkerSize',10); 
axis equal; grid on; 
xlim([0.00 6.00]); 
ylim([0.00 6.00])

end