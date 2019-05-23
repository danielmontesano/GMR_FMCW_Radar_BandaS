addpath('/Users/danielmontesano/Documents/MATLAB/rend_v2')
rend('default','painters')
clear all
Pin = -20; %dBm

% I_10M = dlmread('Trace_1012.csv',',',46,0); 
% I_1M = dlmread('Trace_1013.csv',',',46,0); 
% 
% I(:,1) = [I_1M(:,1); I_10M(1002:end,1)];
% I(:,2) = [I_1M(:,2); I_10M(1002:end,2)];
% 
% Q_10M = dlmread('Trace_1015.csv',',',46,0); 
% Q_1M = dlmread('Trace_1014.csv',',',46,0); 
% 
% Q(:,1) = [Q_1M(:,1); Q_10M(1002:end,1)];
% Q(:,2) = [Q_1M(:,2); Q_10M(1002:end,2)];

I_10M = dlmread('Trace_0112.csv',',',46,0); 
I_1M = dlmread('Trace_0113.csv',',',46,0); 
I_100k = dlmread('Trace_0114.csv',',',46,0); 

I(:,1) = [I_100k(:,1); I_1M(101:end,1); I_10M(100:end,1)];
I(:,2) = [I_100k(:,2); I_1M(101:end,2); I_10M(100:end,2)];

Q_10M = dlmread('Trace_0117.csv',',',46,0); 
Q_1M = dlmread('Trace_0116.csv',',',46,0); 
Q_100k = dlmread('Trace_0115.csv',',',46,0); 


Q(:,1) = [Q_100k(:,1); Q_1M(101:end,1); Q_10M(100:end,1)];
Q(:,2) = [Q_100k(:,2); Q_1M(101:end,2); Q_10M(100:end,2)];

Pin = -40;
Gain = 17;
ADS = dlmread('bbFilt.txt','\t',2,0); 

Q(1:30,2) = Pin + Gain;
I(1:30,2) = Pin + Gain;

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

%%
figure;
hold on;

plot(I(:,1),smooth(I(:,2)-Pin-Gain,200),'linewidth',2)
plot(Q(:,1),smooth(Q(:,2)-Pin-Gain,200),'linewidth',2)
% plot(ADS(:,1),smooth(ADS(:,2),1),'linewidth',2)


xlim([1e2 1e6]);
xticks(logspace(0,7,8))
ylim([-3 1]);
% yticks([-40:2:0])
set(gca, 'XScale', 'log')
grid on
title('Mixer and baseband filters frequency response')
xlabel('Frequency [Hz]')
ylabel('Gain [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
legend('I','Q','location','southwest');


print('V2_bbFilt_spectrum_mix_zoom','-depsc')
savefig('V2_bbFilt_spectrum_mix_zoom')