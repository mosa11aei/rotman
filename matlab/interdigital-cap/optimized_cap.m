function optimized_cap(target_C)
    % === Fixed Parameters ===
    N = 5;                  % Number of fingers (must be odd)
    W = 0.566e-3;             % Finger width [m]
    S = 0.2e-3;             % Gap between fingers [m]
    h = 0.51e-3;             % Substrate height [m]
    er = 3.66;               % Dielectric constant

    % === Optimization to Match Target Capacitance ===
    fun = @(L) abs(interdigital_capacitance(N, L, W, S, h, er) - target_C);
    L_opt = fminbnd(fun, 0.1e-3, 10e-3);  % Length range: 0.1 mm to 10 mm

    % Final capacitance
    C_final = interdigital_capacitance(N, L_opt, W, S, h, er);

    % === Output Results ===
    fprintf('--- Interdigital Capacitor Design ---\n');
    fprintf('Target Capacitance: %.2f pF\n', target_C * 1e12);
    fprintf('Optimized Finger Length: %.2f mm\n', L_opt * 1e3);
    fprintf('Estimated Capacitance: %.2f pF\n', C_final * 1e12);

    % === Plot Interleaved Layout with Ports ===
    plot_interleaved_layout(N, L_opt, W, S);
end

function C = interdigital_capacitance(N, L, W, S, h, er)
    eeff = (er + 1)/2 + (er - 1)/2 ./ sqrt(1 + 12 * h / W);
    k = W / (W + 2*S);
    k1 = sqrt(1 - k.^2);
    [Kk, ~] = ellipke(k.^2);
    [Kk1, ~] = ellipke(k1.^2);
    C_per_length = (4 * eeff * 8.854e-12 * Kk) / Kk1;
    C = (N - 1) * C_per_length * L;
end

function plot_interleaved_layout(N, L, W, S)
    figure;
    hold on; axis equal;
    title('Interdigital Capacitor Layout with Ports');
    xlabel('x (mm)'); ylabel('y (mm)');

    % Draw interleaved fingers
    for i = 0:N-1
        x = i * (W + S);
        if mod(i,2) == 0
            % Port 1: fingers start from the bottom
            y = 0;
            color = [0.1, 0.4, 0.8]; % blue
        else
            % Port 2: fingers start from the top
            y = L / 2;
            color = [0.85, 0.1, 0.1]; % red
        end
        rectangle('Position', [x*1e3, y*1e3, W*1e3, L*1e3/2], ...
                  'FaceColor', color, 'EdgeColor', 'k');
    end

    % Draw port pads (left and right bar)
    pad_w = (W + S) * 2;    % wider than a single finger
    pad_h = 0.5e-3;

    % Port 1 pad (bottom)
    rectangle('Position', [-pad_w*1e3, 0, pad_w*1e3, pad_h*1e3], ...
              'FaceColor', [0.1, 0.4, 0.8], 'EdgeColor', 'k');
    text(-pad_w*1e3, -0.3, 'Port 1', 'Color', [0.1, 0.4, 0.8]);

    % Port 2 pad (top)
    rectangle('Position', [-pad_w*1e3, L*1e3 - pad_h*1e3, pad_w*1e3, pad_h*1e3], ...
              'FaceColor', [0.85, 0.1, 0.1], 'EdgeColor', 'k');
    text(-pad_w*1e3, L*1e3 + 0.3, 'Port 2', 'Color', [0.85, 0.1, 0.1]);

    xlim([-pad_w*1e3 - 0.2, N*(W+S)*1e3 + 0.5]);
    ylim([-0.5, L*1e3 + 0.5]);
    grid on;
end
