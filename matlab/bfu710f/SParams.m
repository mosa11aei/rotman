% --- Load and extract S-parameters ---
filename = 'Spar_BFU710F/BFU710F_2V_6mA_S_N.s2p';
sparams = sparameters(filename);
freq = sparams.Frequencies;
s11 = rfparam(sparams, 1, 1);
s22 = rfparam(sparams, 2, 2);

% --- Reference impedance ---
Z0 = sparams.Impedance;  % Usually 50 Ohms

% --- Extract frequency and S-parameters ---
freq = sparams.Frequencies;        % In Hz
s11 = rfparam(sparams, 1, 1);
s22 = rfparam(sparams, 2, 2);

% --- Calculate impedance ---
zin = Z0 * (1 + s11) ./ (1 - s11);
zout = Z0 * (1 + s22) ./ (1 - s22);

% --- Find the index closest to 10 GHz ---
target_freq = 10e9;  % 10 GHz in Hz
[~, idx] = min(abs(freq - target_freq));

% --- Output results ---
fprintf('--- Impedance at %.2f GHz ---\n', freq(idx)/1e9);
fprintf('Zin  = %.2f + j%.2f Ohms\n', real(zin(idx)), imag(zin(idx)));
fprintf('Zout = %.2f + j%.2f Ohms\n', real(zout(idx)), imag(zout(idx)));

gamma_zin = (zin - Z0) ./ (zin + Z0);

% Plot on Smith chart
figure;
smithplot(gamma_zin);
title('Smith Chart of Input Impedance (Z_{in})');

plot(freq/1e9, real(zin), 'b', freq/1e9, imag(zin), 'r');
xlabel('Frequency (GHz)');
ylabel('Impedance (Ohms)');
legend('Real(Zin)', 'Imag(Zin)');
grid on;