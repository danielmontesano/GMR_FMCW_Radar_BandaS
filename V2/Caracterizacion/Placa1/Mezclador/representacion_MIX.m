addpath('/Users/danielmontesano/Documents/MATLAB/rend_v2')
rend('default','painters')

Pin = -50;

%Fcorte
F255 = dlmread('Trace_0001.csv',',',46,0); 
F225 = dlmread('Trace_0002.csv',',',46,0); 
F195 = dlmread('Trace_0003.csv',',',46,0); 
F165 = dlmread('Trace_0004.csv',',',46,0); 
F135 = dlmread('Trace_0005.csv',',',46,0); 
F105 = dlmread('Trace_0006.csv',',',46,0); 
F75 = dlmread('Trace_0020.csv',',',46,0); 
F45 = dlmread('Trace_0021.csv',',',46,0); 
F15 = dlmread('Trace_0022.csv',',',46,0); 
F0 = dlmread('Trace_0023.csv',',',46,0); 

% G17 = dlmread('Trace_0012.csv',',',46,0); 
G20 = dlmread('Trace_0011.csv',',',46,0); 
G25 = dlmread('Trace_0010.csv',',',46,0); 
G30 = dlmread('Trace_0009.csv',',',46,0); 
G35 = dlmread('Trace_0008.csv',',',46,0); 
G40 = dlmread('Trace_0007.csv',',',46,0); 


LO_mas5dbm = dlmread('Trace_0016.csv',',',46,0); 
LO_min10dbm = dlmread('Trace_0013.csv',',',46,0); 
LO_min20dbm = dlmread('Trace_0014.csv',',',46,0); 
LO_min30dbm = dlmread('Trace_0015.csv',',',46,0); 

Q_n = dlmread('Trace_0009.csv',',',46,0); 
Q_p = dlmread('Trace_0017.csv',',',46,0); 
I_n = dlmread('Trace_0018.csv',',',46,0); 
I_p = dlmread('Trace_0019.csv',',',46,0); 

LO_1500MHz = dlmread('Trace_0024.csv',',',46,0); 
LO_2000MHz = dlmread('Trace_0025.csv',',',46,0); 
LO_2500MHz = dlmread('Trace_0007.csv',',',46,0); 
LO_3000MHz = dlmread('Trace_0026.csv',',',46,0); 
LO_3500MHz = dlmread('Trace_0027.csv',',',46,0); 

bw_tune = dlmread('Manufacturer/bw.csv',',',3,0); 
gain_tune = dlmread('Manufacturer/gain.csv',',',3,0); 



%% BW conf
figure;
hold on;

plot(F255(:,1),smooth(F255(:,2)-Pin,100),'linewidth',2)
plot(F225(:,1),smooth(F225(:,2)-Pin,100),'linewidth',2)
plot(F195(:,1),smooth(F195(:,2)-Pin,100),'linewidth',2)
plot(F165(:,1),smooth(F165(:,2)-Pin,100),'linewidth',2)
plot(F135(:,1),smooth(F135(:,2)-Pin,100),'linewidth',2)
plot(F105(:,1),smooth(F105(:,2)-Pin,100),'linewidth',2)
plot(F75(150:end,1),smooth(F75(150:end,2)-Pin,100),'linewidth',2)
plot(F45(150:end,1),smooth(F45(150:end,2)-Pin,100),'linewidth',2)
plot(F15(150:end,1),smooth(F15(150:end,2)-Pin,100),'linewidth',2)
plot(F0(150:end,1),smooth(F0(150:end,2)-Pin,100),'linewidth',2)

set(gca, 'XScale', 'log')
xlim([1e5 2e7]);
xticks(logspace(0,7,8))
ylim([10 45]);
% yticks([-40:2:0])
grid on
title('Mixer LPF cutoff frequency')
xlabel('Frequency [Hz]')
ylabel('Gain [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
legend({'Conf value = 255','Conf value = 225','Conf value = 195','Conf value = 165','Conf value = 135','Conf value = 105','Conf value = 75','Conf value = 45','Conf value = 15','Conf value = 0'},'fontsize',12,'location','southwest');


print('V2_MIX_bw_sweep','-depsc')
savefig('V2_MIX_bw_sweep')

 fc255 = find(F255(:,2)<-10);%dado que la potencia es alrededor de -9dbm, se eligoe -10dbm como Fc a -1dB
 fc255_I = fc255(1);
 fc225 = find(F225(:,2)<-10);
 fc225_I = fc225(1);
  fc195 = find(F195(:,2)<-10);
 fc195_I = fc195(1);
  fc165 = find(F165(:,2)<-10);
 fc165_I = fc165(1);
  fc135 = find(F135(:,2)<-10);
 fc135_I = fc135(1);
  fc105 = find(F105(:,2)<-10);
 fc105_I = fc105(1);
  fc75 = find(F75(:,2)<-10);
 fc75_I = fc75(1);
  fc45 = find(F45(:,2)<-10);
 fc45_I = fc45(1);
  fc15 = find(F15(:,2)<-10);
 fc15_I = fc15(1);
  fc0 = find(F0(:,2)<-10);
 fc0_I = fc0(1);
 
 
 figure;
 hold on;
 factores = [255 225 195 165 135 105 75 45 15 0];
 fc = [F255(fc255_I)  F225(fc225_I)  F195(fc195_I)  F165(fc165_I)  F135(fc135_I)  F105(fc105_I)  F75(fc75_I) F45(fc45_I) F15(fc15_I) F0(fc0_I) ];
 plot(factores, fc,'linewidth',2);
 plot(bw_tune(:,1),bw_tune(:,2),'linewidth',2);
 
xlim([0 255]);
% xticks(logspace(0,7,8))
ylim([0 14e6]);
% yticks([-40:2:0])
grid on
title('Mixer LPF cutoff configuration')
xlabel('Configuration value (2^{8} bits digital word)')
ylabel('1-dB corner frequency [Hz]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)

legend({'Measured','Manufacturer'},'fontsize',18,'location','northeast');


print('V2_MIX_bw_values','-depsc')
savefig('V2_MIX_bw_values')
%% Gain conf
figure;
hold on;

% plot(G17(:,1),G17(:,2),'linewidth',2)
plot(G20(:,1),G20(:,2)-Pin,'linewidth',2)
plot(G25(:,1),G25(:,2)-Pin,'linewidth',2)
plot(G30(:,1),G30(:,2)-Pin,'linewidth',2)
plot(G35(:,1),G35(:,2)-Pin,'linewidth',2)
plot(G40(:,1),G40(:,2)-Pin,'linewidth',2)

xlim([2e4 2e6]);
% ylim([-40 0]);
xticks(0:0.25e6:2e6)
% set(gca, 'XScale', 'log')
grid on
title('Mixer gain')
xlabel('Frequency [Hz]')
ylabel('Gain [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
legend('Gain = 20 dB','Gain = 25 dB','Gain = 30 dB','Gain = 35 dB','Gain = 40 dB','location','southwest');


print('V2_MIX_gain','-depsc')
savefig('V2_MIX_gain')

%% Pint in LO
figure;
hold on;

plot(LO_mas5dbm(:,1),smooth(LO_mas5dbm(:,2)-Pin,50),'linewidth',2)
plot(LO_min10dbm(:,1),smooth(LO_min10dbm(:,2)-Pin,50),'linewidth',2)
plot(LO_min20dbm(:,1),smooth(LO_min20dbm(:,2)-Pin,50),'linewidth',2)
plot(LO_min30dbm(:,1),smooth(LO_min30dbm(:,2)-Pin,50),'linewidth',2)


xlim([2e4 2e6]);
% ylim([-40 0]);
yticks([-40:5:50])
xticks(0:0.25e6:2e6)
% set(gca, 'XScale', 'log')
grid on
title('Mixer gain along LO input power')
xlabel('Frequency [Hz]')
ylabel('Gain [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
legend('LO power = 5dbm','LO power = -10dbm','LO power = -20dbm','LO power = -30dbm','location','southwest');


print('V2_MIX_gain_LOpower','-depsc')
savefig('V2_MIX_gain_LOpower')

%% IQ
figure;
hold on;

plot(I_p(:,1),smooth(I_p(:,2)-Pin,100),'linewidth',2)
plot(I_n(:,1),smooth(I_n(:,2)-Pin,100),'linewidth',2)
plot(Q_p(:,1),smooth(Q_p(:,2)-Pin,100),'linewidth',2)
plot(Q_n(:,1),smooth(Q_n(:,2)-Pin,100),'linewidth',2)


xlim([0.1e6 1.4e6]);
 ylim([10 30]);
 yticks([10:2:30])
 xticks(0.1e6:0.1e6:1.4e6)
% set(gca, 'XScale', 'log')
grid on
title('Mixer I/Q channels mismatch')
xlabel('Frequency [Hz]')
ylabel('Gain [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
legend('I_p','I_n','Q_p','Q_n','location','southwest');


print('V2_MIX_gain_mismatch','-depsc')
savefig('V2_MIX_gain_mismatch')

%% IQ zoom
figure;
hold on;

plot(I_p(:,1),smooth(I_p(:,2)-Pin,300),'linewidth',2)
plot(I_n(:,1),smooth(I_n(:,2)-Pin,300),'linewidth',2)
plot(Q_p(:,1),smooth(Q_p(:,2)-Pin,300),'linewidth',2)
plot(Q_n(:,1),smooth(Q_n(:,2)-Pin,300),'linewidth',2)


xlim([0.1e6 1e6]);
 ylim([27 30]);
 yticks(27:0.2:30)
 xticks(0.1e6:0.1e6:1.4e6)
grid on
title('Mixer I/Q channels mismatch')
xlabel('Frequency [Hz]')
ylabel('Gain [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
legend('I_p','I_n','Q_p','Q_n','location','southwest');


print('V2_MIX_gain_mismatch_zoom','-depsc')
savefig('V2_MIX_gain_mismatch_zoom')

%% Gain along LO freq
figure;
hold on;

plot(LO_1500MHz(:,1),smooth(LO_1500MHz(:,2)-Pin,100),'linewidth',2)
plot(LO_2000MHz(:,1),smooth(LO_2000MHz(:,2)-Pin,100),'linewidth',2)
plot(LO_2500MHz(:,1),smooth(LO_2500MHz(:,2)-Pin,100),'linewidth',2)
plot(LO_3000MHz(:,1),smooth(LO_3000MHz(:,2)-Pin,100),'linewidth',2)
plot(LO_3500MHz(:,1),smooth(LO_3500MHz(:,2)-Pin,100),'linewidth',2)


xlim([2e4 1.5e6]);
 ylim([10 50]);
xticks(0:0.25e6:2e6)
% set(gca, 'XScale', 'log')
grid on
title('Mixer gain along LO frequency')
xlabel('Frequency [Hz]')
ylabel('Gain [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
legend('LO freq = 1.5 GHz','LO freq = 2 GHz','LO freq = 2.5 GHz','LO freq = 3 GHz','LO freq = 3.5 GHz','location','southwest');


print('V2_MIX_gain_LOfreq','-depsc')
savefig('V2_MIX_gain_LOfreq')