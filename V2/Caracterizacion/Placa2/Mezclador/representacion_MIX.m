addpath('/Users/danielmontesano/Documents/MATLAB/rend_v2')
rend('default','painters')

Pin = -45;

G20 = dlmread('Trace_0032.csv',',',46,0); 
G30 = dlmread('Trace_0034.csv',',',46,0); 
G40 = dlmread('Trace_0033.csv',',',46,0); 


LO_1500MHz = dlmread('Trace_0035.csv',',',46,0); 
LO_2500MHz = dlmread('Trace_0036.csv',',',46,0); 
LO_3000MHz = dlmread('Trace_0037.csv',',',46,0); 



%%
figure;
hold on;

plot(G20(:,1),G20(:,2)-Pin,'linewidth',2)
plot(G30(:,1),G30(:,2)-Pin,'linewidth',2)
plot(G40(:,1),G40(:,2)-Pin,'linewidth',2)

xlim([2e4 2e6]);
ylim([0 50]);
xticks(0:0.25e6:2e6)
% set(gca, 'XScale', 'log')
grid on
title('Mixer gain')
xlabel('Frequency [Hz]')
ylabel('Gain [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
legend('Gain = 20 dB','Gain = 30 dB','Gain = 40 dB','location','southwest');


print('V2_MIX_gain','-depsc')
savefig('V2_MIX_gain')




%%
figure;
hold on;

plot(LO_1500MHz(:,1),smooth(LO_1500MHz(:,2)-Pin,100),'linewidth',2)
plot(LO_2500MHz(:,1),smooth(LO_2500MHz(:,2)-Pin,100),'linewidth',2)
plot(LO_3000MHz(:,1),smooth(LO_3000MHz(:,2)-Pin,100),'linewidth',2)


xlim([2e4 1.5e6]);
 ylim([0 25]);
xticks(0:0.25e6:2e6)
% set(gca, 'XScale', 'log')
grid on
title('Mixer gain along LO frequency')
xlabel('Frequency [Hz]')
ylabel('Gain [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
legend('LO freq = 1.5 GHz','LO freq = 2.5 GHz','LO freq = 3 GHz','location','southwest');


print('V2_MIX_gain_LOfreq','-depsc')
savefig('V2_MIX_gain_LOfreq')