function [Vdrop, fig] = manhattanNetwork(N)

% Position the nodes
x = (1:N)';
x = repmat(x, [N, 1]);
y = ones(N, 1);
for i = 2:N
    col = i*ones(N,1);
    y = [y;col];
end


%% Define some edges
numResistors = 2*N^2 - 2*N;
st = zeros(numResistors, 2);

rowI = 1;
elementI = 1;
for yi = 1:N
    for xi = 1:N
        if yi ~= N
            st(rowI,:) = [elementI, elementI+N];
            rowI = rowI + 1;
        end
        if xi ~= N
            st(rowI,:) = [elementI, elementI+1];
            rowI = rowI + 1;
        end
        elementI = elementI + 1;
    end
end

listAnode=1; listCnode=N^2;

% if both of the nodes are in the ACnode list, get rid of them
% tmp=(st<=numACNode)|(st>=numACNode+numNode+1);
% st(find(tmp(:,1).*tmp(:,2)),:)=[];
% NB routine auto orders these s,t pairs so that s<t, as in my notes

%% Set some edge weights or resistances
r = ones(numResistors, 1);
% example: resistances just lengths of edges.

%% Call the solver
% [x,V]=KirchoffSolve(st,r,listAnode,listCnode)
% The total source current assumed WLOG equals 1.
% st is the n x 2 list of edges defined by start and terminal nodes.
% r is the n x 1 list of resistances
% listAnode and listCnode: column vectors listing these nodes.
% x resulting edge currents, V resulting node voltages.
[X,V]=KirchoffSolve(st,r,listAnode,listCnode);
% that's that
Vdrop = V(listCnode(1))-V(listAnode(1));
% and this is just the resistance, as the current is prescribed to be 1.
% NB the problem is linear in voltages.

% %% Plot what it looks like
% close all
% fig = figure; 
% plot(x(1), y(1), '.', 'Color', '#3498db', 'MarkerSize',15+sqrt(N))
% hold on
% plot(x(end), y(end),'.','Color', '#884ea0', 'MarkerSize',15+sqrt(N))
% 
% hp=plot(x(st)',y(st)','r-');
% axis equal
% axis([1-N/10 N+N/10 1-N/10 N+2*N/10])
% for i=1:length(hp)
%    hp(i).LineWidth = max(1e-3,3*abs(X(i))/(max(abs(X)))); 
% end
% % unfortunately this formulation gives short cuts from the anode to
% % the cathode along y=0 and y=1: not ideal for illustration, but never mind
% %%
% hold on
% fac = N/200;
% for i=1:max(max(st)) % ie over nodes
%   hr(i)=rectangle('Position',[x(i)-fac,y(i)-fac,2*fac,2*fac],'Curvature',[1 1],'FaceColor',[0 1 0]*(V(i)-min(V))/(max(V)-min(V)));
% end
% 
% plot(x(1), y(1), '.', 'Color', '#3498db', 'MarkerSize',15+sqrt(N))
% 
% plot(x(end), y(end),'.','Color', '#884ea0', 'MarkerSize',15+sqrt(N))
% 
% legend('Anode', 'Cathode', 'Location', 'north')
% % title(['N: ', num2str(N), '. Vdrop: ', num2str(Vdrop), ' Voltz'])
% % saveas(figure1, ['figures/N_' num2str(N) '.png'])
end
