function figure1 = plotContour(fun,x, xy1)
figure1 = figure;


X = linspace(0,2,100);
Y = linspace(0,2,100);
[X,Y] = meshgrid(X,Y);
z = fun(X, Y);

contour(X, Y, z, 100)

hold on

% Plot arrows
start = [ 0 0];

D = xy1 - start;

xy2 = [0.7811 0.7811];
D2 = xy2- xy1;

plot(x(1), x(2), '.', 'MarkerSize',10)
quiver( start(1), start(2), D(1), D(2), 0, 'filled', 'LineWidth',1.5)
quiver( xy1(1), xy1(2), D2(1), D2(2), 0, 'filled', 'LineWidth',1.5)

legend('Function f', 'Quadprog solution', 'Calculated first iteration of SD', 'Estimated second iteration of SD')

end