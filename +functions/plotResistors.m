function fig = plotResistors(x, y, st)

fig = figure;
plot(x(1), y(1), '.', 'Color', '#3498db', 'MarkerSize',12)
hold on
plot(x(end), y(end),'.','Color', '#884ea0', 'MarkerSize',12)

for i = 1:length(st)
    c1 = st(i, 1);
    c2 = st(i, 2);

    x1 = x(c1);
    x2 = x(c2);

    y1 = y(c1);
    y2 = y(c2);

    plot([x1, x2], [y1, y2], 'r')

end

plot(x, y, '.', 'Color', [0 0.5 0], 'MarkerSize',10); 
axis equal; grid on; 
xlim([0.00 6.00]); 
ylim([0.00 6.00]);

plot(x(1), y(1), '.', 'Color', '#3498db', 'MarkerSize',12)
plot(x(end), y(end),'.','Color', '#884ea0', 'MarkerSize',12)
legend('Anode', 'Cathode', 'Location', 'north')

legend("Position", [0.39923,0.80404,0.23931,0.11349])

end