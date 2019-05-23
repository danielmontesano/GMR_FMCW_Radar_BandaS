% addpath('/Users/danielmontesano/Documents/MATLAB/rend_v2')
% rend('default','painters')
clear all
Pin = -45; %dBm

I_10M = dlmread('Trace_0026.csv',',',46,0); 
I_1M = dlmread('Trace_0027.csv',',',46,0); 
I_100k = dlmread('Trace_0028.csv',',',46,0); 

I(:,1) = [I_100k(:,1); I_1M(1001:end,1); I_10M(1000:end,1)];
I(:,2) = [I_100k(:,2); I_1M(1001:end,2); I_10M(1000:end,2)];

Q_10M = dlmread('Trace_0031.csv',',',46,0); 
Q_1M = dlmread('Trace_0030.csv',',',46,0); 
Q_100k = dlmread('Trace_0029.csv',',',46,0); 


Q(:,1) = [Q_100k(:,1); Q_1M(1001:end,1); Q_10M(1000:end,1)];
Q(:,2) = [Q_100k(:,2); Q_1M(1001:end,2); Q_10M(1000:end,2)];

Gain = 20;
ADS = dlmread('bbFilt_ADS.txt','\t',2,0); 

Q(1:700,2) = Q(700,2);
I(1:700,2) = I(700,2);

%%
figure;
hold on;

plot(I(:,1),smooth(I(:,2)-Pin-Gain,20),'linewidth',2)
plot(Q(:,1),smooth(Q(:,2)-Pin-Gain,20),'linewidth',2)
% plot(ADS(:,1),smooth(ADS(:,2),1),'linewidth',2)


xlim([1e2 1e7]);
xticks(logspace(0,7,8))
ylim([-65 5]);
% yticks([-40:2:0])
set(gca, 'XScale', 'log')
grid on
title('Mixer and baseband filters frequency response')
xlabel('Frequency [Hz]')
ylabel('Gain [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
legend('I','Q','location','southwest');


print('V2_bbFilt_spectrum_mix','-depsc')
savefig('V2_bbFilt_spectrum_mix')
