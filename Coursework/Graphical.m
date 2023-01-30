close all
figure

% 1
plot([0, 1.5], [3, 0], 'LineWidth',1.5)

hold on
% 2
plot([1, 0], [0, 2/3], 'LineWidth',1.5)

%3
plot([1, 0], [0, 1/3], 'LineWidth',1.5)
plot(1.5, 0, '.', 'Color', [0 0.5 0], 'MarkerSize',20)


plot([0, 0], [0, 5], 'k', 'LineWidth',1.5)

plot([0, 1.5], [0.8, 0], 'k-.', 'LineWidth',1)

plot([0, 2], [0, 0], 'k', 'LineWidth',1.5)


plot([0, 2], [2, 0.9333], 'k-.', 'LineWidth',1)
plot([0, 2], [3, 1.9333], 'k-.', 'LineWidth',1)
plot([0, 2], [4, 2.9333], 'k-.', 'LineWidth',1)
plot([0, 2], [5, 3.9333], 'k-.', 'LineWidth',1)


p1S = [0.35, -0.6];
p1 = [0.4, 0.2];
D = p1 - p1S;
quiver( p1S(1), p1S(2), D(1), D(2), 0,'k', 'LineWidth',1)


p1S = [0.4, -0.5];
p1 = [0.5, 1/3];
D = p1 - p1S;
quiver( p1S(1), p1S(2), D(1), D(2), 0,'k', 'LineWidth',1)


p1S = [0.55, 0.5];
p1 = [0.75, 1.5];
D = p1 - p1S;
quiver( p1S(1), p1S(2), D(1), D(2), 0,'k',  'LineWidth',1)

plot(1.5, 0, '.', 'Color', [0 0.5 0], 'MarkerSize',20)

xlim([-0.2, 2])
ylim([-0.2, 5])

grid on; grid minor
txt = {'FEASIBLE REGION'};
text(1,2.75,txt)

legend('Inequality equation 1.6','Inequality equation 1.7','Inequality equation 1.8', 'Inequality constraint 1.9', 'Graphical solution', 'Objective function', 'location', 'northoutside')