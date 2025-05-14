clc
clear
clf

v0 = 299792458;
f=15e9;
lambda0 = v0/10e9;
lambda = v0/f;

sd = 0.5;
d = sd*lambda0;
Na = 8;
Nb = 9;
theta = 30;

y3 = (1:1:Na)*d - (Na + 1)*d/2;
theta = linspace(-2*pi*theta/360, 2*pi*theta/360, Nb);
dPhase = (2*pi/lambda).*(y3.')*sin(theta);

data = sparameters('Rotman_solo_SParams.s17p');

Freq = data.Frequencies;
SnP = data.Parameters;
freqrange = 1:length(Freq);

C = {'c', 'm', 'b', 'r', 'k', 'r', 'b', 'm', 'c'};

for ind = 1:9
    freq_ind = freqrange(Freq == f);
    plot(unwrap(angle(SnP(10:17,ind,freq_ind))) - angle(SnP(10,ind,freq_ind)), 'color', C{ind}, 'LineWidth', 3)

    hold on
    plot(unwrap(dPhase(:,ind)) - dPhase(1,ind), '--', 'color', C{ind}, 'LineWidth', 3)
end

ylabel('Beam-forming unwrapped phase (rad)')
xlabel('Array element number')
hold on
grid on

qw{1} = plot(nan, 'k-', 'LineWidth', 3);
qw{2} = plot(nan, 'k--', 'LineWidth', 3);
legend([qw{:}], {'HFSS', 'Analytical (GO)'}, 'location', 'northwest');