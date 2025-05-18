function [x1, y1] = Rotman_Meander(x, y, x2, y2, A, sign)
    % Validate sign input
    if sign ~= 1 && sign ~= -1
        error('The "sign" parameter must be either +1 (right) or -1 (left).');
    end

    r = A / 2;

    % Vector from center1 to center2
    dx = x2 - x;
    dy = y2 - y;
    D = sqrt(dx^2 + dy^2);  % Distance between centers

    % Check feasibility
    if D > 2 * r
        error('No solution: points too far apart for given total length.');
    end

    % Midpoint between centers
    xm = (x + x2) / 2;
    ym = (y + y2) / 2;

    % Distance from midpoint to intersection point
    h = sqrt(r^2 - (D/2)^2);

    % Direction perpendicular to line connecting centers
    perp_dx = -dy / D;
    perp_dy = dx / D;

    % Use sign to choose left/right jag
    x1 = xm + sign * h * perp_dx;
    y1 = ym + sign * h * perp_dy;

    % === Length Check ===
    len1 = sqrt((x1 - x)^2 + (y1 - y)^2);
    len2 = sqrt((x2 - x1)^2 + (y2 - y1)^2);
    total_len = len1 + len2;
    deviation = total_len - A;

    fprintf('[INFO] Total path length = %.4f mm (target = %.4f mm)\n', total_len, A);
    fprintf('[INFO] Deviation = %.6f mm\n', deviation);
end
