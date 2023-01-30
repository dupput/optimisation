students = 1:63;
group = zeros(63, 1);
for i = students
    row = solutions(i, :);
    group(i) = find(row~=0);
end
close all
figure
plot(group, students, '.', 'MarkerSize',30)
xticks(1:14)
yticks(0:5:65)
ylabel('Student number')
xlabel('Group number')
grid on; 

hold on

group = zeros(63, 1);
for i = students
    row = solutions_unshuffled(i, :);
    group(i) = find(row~=0);
end
plot(group, students, '.', 'MarkerSize',25)

group = zeros(63, 1);
for i = students
    row = rand1(i, :);
    group(i) = find(row~=0);
end
plot(group, students, '.', 'MarkerSize',20)

group = zeros(63, 1);
for i = students
    row = rand2(i, :);
    group(i) = find(row~=0);
end
plot(group, students, '.', 'MarkerSize',15)


legend('Initial solution', 'Alternative solution 1', 'Alternative solution 2', 'Alternative solution 3', 'Location','northoutside')


