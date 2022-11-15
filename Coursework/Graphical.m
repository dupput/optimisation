close all
figure

plot([0, 1.5], [3, 0], 'LineWidth',1.5)

hold on
plot([1, 0], [0, 2/3], 'LineWidth',1.5)
plot([1, 0], [0, 1/3], 'LineWidth',1.5)

plot([0, 0], [0, 5], 'k', 'LineWidth',1.5)
plot([0, 2], [0, 0], 'k', 'LineWidth',1.5)


plot([0, 1.5], [0.8, 0], 'k-.', 'LineWidth',1)
plot([0, 2], [2, 0.9333], 'k-.', 'LineWidth',1)
plot([0, 2], [3, 1.9333], 'k-.', 'LineWidth',1)
plot([0, 2], [4, 2.9333], 'k-.', 'LineWidth',1)
plot([0, 2], [5, 3.9333], 'k-.', 'LineWidth',1)

plot(1.5, 0, 'g.', 'MarkerSize',20)

xlim([-0.2, 2])
ylim([-0.2, 5])

grid on; grid minor
