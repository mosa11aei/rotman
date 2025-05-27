x_start = -0.3;
y_start = -294;
x_end = -0.1;
y_end = -314.7579;  % always fixed in this setup
total_length = 50.87736;
num_meanders = 3;
start_sign = 1;

[x_meander, y_meander] = Rotman_N_Meander(x_start, y_start, x_end, y_end, total_length, num_meanders, start_sign);
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