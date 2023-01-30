function figure1 = plotNetwork(x, y, st, X, V)
N = 5;

figure1 = figure; 
grid on
plot(x(1), y(1), '.', 'Color', '#3498db', 'MarkerSize',12)
hold on
plot(x(end), y(end),'.','Color', '#884ea0', 'MarkerSize',12)

hp=plot(x(st)',y(st)','r-');
axis equal
xlim([0.00 6.00]); 
ylim([0.00 6.00]);

for i=1:length(hp)
   hp(i).LineWidth = max(1e-3,3*abs(X(i))/(max(abs(X)))); 
end

fac = N/200;
for i=1:max(max(st)) % ie over nodes
  hr(i)=rectangle('Position',[x(i)-fac,y(i)-fac,2*fac,2*fac],'Curvature',[1 1],'FaceColor',[0 1 0]*(V(i)-min(V))/(max(V)-min(V)));
end

plot(x(1), y(1), '.', 'Color', '#3498db', 'MarkerSize',12)

plot(x(end), y(end),'.','Color', '#884ea0', 'MarkerSize',12)
grid on
legend('Anode', 'Cathode', 'Location', 'north')
end