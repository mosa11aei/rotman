x_start = -52.932;
y_start = 59.754;
x_end = -50;
y_end = 90.5;  % always fixed in this setup
total_length = 31.25;

[x_meander, y_meander] = Rotman_N_Meander(x_start, y_start, x_end, y_end, total_length, 4);
plot(x_meander, y_meander, '-o');
axis equal;
grid on;
title('Meander Path');
xlabel('X (mm)');
ylabel('Y (mm)');

fprintf('\nUseful Meander Path Points:\n');
fprintf('----------------------------\n');
fprintf('Start Point: (%.4f, %.4f) mm\n', x_meander(1), y_meander(1));
for i = 2:2:length(x_meander)-1
    fprintf('Meander %d: (%.4f, %.4f) mm\n', (i-1)/2, x_meander(i), y_meander(i));
end
fprintf('End Point  : (%.4f, %.4f) mm\n', x_meander(end), y_meander(end));