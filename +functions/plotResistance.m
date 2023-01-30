function fig = plotResistance(Table)

fig = figure;
grid on; grid minor
yyaxis left
plot(Table.N, Table.("Time (s)"),'o-', 'LineWidth',1)
ylabel('Time (s)')

hold on
yyaxis right
plot(Table.N, Table.('Resistance (Ohm)'), '-o' , 'LineWidth',1)
ylabel('Resistance (Ohm)')
xlabel('N')