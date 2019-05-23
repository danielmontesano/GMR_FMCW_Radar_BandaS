addpath('/Users/danielmontesano/Documents/MATLAB/rend_v2')
rend('default','painters')

load('measurements.mat'); %Freq; mVpp;
dlmread('Trace_1003_100k_0000.csv',',',46,0); 

%%
figure;
hold on;

plot(I_p(:,1),20*log10(I_p(:,2)/Vin),'linewidth',2)
plot(I_n(:,1),20*log10(I_n(:,2)/Vin),'linewidth',2)
plot(Q_p_6900pF(:,1),20*log10(Q_p_6900pF(:,2)/Vin),'linewidth',2)

xlim([1 1e7]);
xticks(logspace(0,7,8))
% ylim([-40 0]);
% yticks([-40:2:0])
set(gca, 'XScale', 'log')
grid on
title('Baseband filters')
xlabel('Frequency [Hz]')
ylabel('Voltage gain [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
legend('I_p','I_n','Q_p','Q_n','location','southwest');


print('BB_filt','-depsc')
savefig('BB_filt')