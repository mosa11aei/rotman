function costFunc = func_Optimize(param_X)

runPyCmd = ['ipy64 1x8_HFSS_Optimize.py ',num2str(param_X)];
[~,msg] = system(runPyCmd);

SData = readtable('S11.csv');
% figure(2)
% plot(SData{:,1},SData{:,2})

S11 = SData{:,2};
costFunc = max(S11(192:212)); % 51 to 251 is from 8.5 GHz to 10.5 GHz

T = [param_X,costFunc]
dlmwrite('Sim_History.csv',T,'delimiter',',','-append') %Saving a record of all results

end

