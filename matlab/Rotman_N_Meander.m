function [x_out, y_out] = Rotman_N_Meander(x_start, y_start, x_end, y_end, A_total, N)
    % Check that N is at least 1
    if N < 1
        error('N must be at least 1');
    end

    % Divide total path length evenly among segments
    A_segment = A_total / N;

    % Generate N+1 equally spaced points along the straight line
    x_points = linspace(x_start, x_end, N + 1);
    y_points = linspace(y_start, y_end, N + 1);

    % Initialize output arrays
    x_out = x_points(1);
    y_out = y_points(1);

    % Alternate signs for left/right meanders
    sign = 1;

    for i = 1:N
        x0 = x_points(i);
        y0 = y_points(i);
        x1 = x_points(i+1);
        y1 = y_points(i+1);

        % Compute meander point
        [xm, ym] = Rotman_Meander(x0, y0, x1, y1, A_segment, sign);

        % Append mid-point and end of segment
        x_out(end+1) = xm;
        y_out(end+1) = ym;

        x_out(end+1) = x1;
        y_out(end+1) = y1;

        % Alternate left/right for next meander
        sign = -sign;
    end
end
