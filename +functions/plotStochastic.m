function plotStochastic(allMinimum)


figure('Renderer', 'painters', 'Position', [10 10 900 300]); 

subplot(1,3,[1,2]);
hold on
histogram(allMinimum(:,1), 200, 'EdgeAlpha', 0.2)
histogram(allMinimum(:,2), 200, 'EdgeAlpha', 0.2)
grid on; grid minor; xlabel('x'); ylabel('Quantity'); 
legend('x(1) Values', 'x(2) Values')

maxMinama = max(allMinimum);
subplot(1,3,3);
scatter(allMinimum(:,1), allMinimum(:,2), 30, allMinimum(:,3), '.')
colorbar
axis equal; grid on; grid minor; xlabel('x(1)'), ylabel('x(2)')