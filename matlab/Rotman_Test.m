clc
clear
clf

v0 = 299792458;
f=10e9;
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

data = sparameters('../hfss/Rotman_solo_SParams.s9p');