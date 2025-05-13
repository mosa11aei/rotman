%% *MAKE SURE TO INCLUDE IRONPYTHON TO SYSTEM PATH*

% Make sure there is only 1 HFSS running and it has the design open.
% If more than 1 HFSS applications are open, matlab may try to open the 
% design in the wrong HFSS application.

clc
clear

%% Set up Nelder-Mead Optimizer
%All units are in mm

% Patch W, Patch L, Line W, ArrayL
param_X = [9.6242, 7.6072, 1.2697, 10.5536]; % Initial values
LB_X = [9, 7, 1.2, 10]; % Lower bounds
UB_X = [10, 8, 1.35, 10.6]; % Upper bounds

%% Seed simulation for reference
% runPyCmd = ['ipy64 1x8_HFSS_Optimize.py ',num2str(param_X)];
% [~,msg] = system(runPyCmd);

disp(msg)

SData_original = readtable('S11.csv');

figure(1)
plot(SData_original{:,1},SData_original{:,2},'r--');
xlabel('Freq (GHz)'); ylabel('S11 (dB)'); grid on; hold on;

%% Run optimization routine

tic
options = optimset('PlotFcns',@optimplotfval);options.MaxFunctionEvaluations = 500;
optim_X = fminsearchbnd(@(param_X)func_Optimize(param_X),param_X,LB_X,UB_X,options);
time = toc;

%% Optimized results

runPyCmd = ['ipy64 1x8_HFSS_Optimize.py ',num2str(optim_X)];
[~,msg] = system(runPyCmd);

SData_final = readtable('S11.csv');

figure(1)
plot(SData_final{:,1},SData_final{:,2},'k');
xlabel('Freq (GHz)'); ylabel('S11 (dB)'); grid on; hold on;

legend('Original', 'Optimized')
title(['Simulation time: ',num2str(time/60),' minutes'])
