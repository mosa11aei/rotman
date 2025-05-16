function [x1, y1] = Rotman_Meander(x, y, x2, A)
    y2 = 90.5;
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

    % Two possible intersection points — choose one
    x1 = xm + h * perp_dx;
    y1 = ym + h * perp_dy;
end
