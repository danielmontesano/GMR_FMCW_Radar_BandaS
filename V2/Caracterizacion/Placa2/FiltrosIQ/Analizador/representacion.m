addpath('/Users/danielmontesano/Documents/MATLAB/rend_v2')
rend('default','painters')

Pin = dlmread('Trace_0043.csv',',',46,0); 
Pin = mean(Pin(:,2))-100;

% I_p_10M = dlmread('Trace_0044.csv',',',46,0); 
% I_p_1M = dlmread('Trace_0045.csv',',',46,0); 
% I_p_100k = dlmread('Trace_0046.csv',',',46,0); 
% 
% I_p(:,1) = [I_p_100k(:,1); I_p_1M(102:end,1); I_p_10M(102:end,1)];
% I_p(:,2) = [I_p_100k(:,2); I_p_1M(102:end,2); I_p_10M(102:end,2)];
% 
% I_n_10M = dlmread('Trace_0049.csv',',',46,0); 
% I_n_1M = dlmread('Trace_0048.csv',',',46,0); 
% I_n_100k = dlmread('Trace_0047.csv',',',46,0); 
% 
% I_n(:,1) = [I_n_100k(:,1); I_n_1M(102:end,1); I_n_10M(102:end,1)];
% I_n(:,2) = [I_n_100k(:,2); I_n_1M(102:end,2); I_n_10M(102:end,2)];
% 
% Q_p_10M = dlmread('Trace_0055.csv',',',46,0); 
% Q_p_1M = dlmread('Trace_0054.csv',',',46,0); 
% Q_p_100k = dlmread('Trace_0053.csv',',',46,0); 
% 
% Q_p(:,1) = [Q_p_100k(:,1); Q_p_1M(102:end,1); Q_p_10M(102:end,1)];
% Q_p(:,2) = [Q_p_100k(:,2); Q_p_1M(102:end,2); Q_p_10M(102:end,2)];
% 
% Q_n_10M = dlmread('Trace_0050.csv',',',46,0); 
% Q_n_1M = dlmread('Trace_0051.csv',',',46,0); 
% Q_n_100k = dlmread('Trace_0052.csv',',',46,0); 
% 
% Q_n(:,1) = [Q_n_100k(:,1); Q_n_1M(102:end,1); Q_n_10M(102:end,1)];
% Q_n(:,2) = [Q_n_100k(:,2); Q_n_1M(102:end,2); Q_n_10M(102:end,2)];

% I_p_10M = dlmread('Trace_0062.csv',',',46,0); 
% I_p_1M = dlmread('Trace_0063.csv',',',46,0); 
% I_p_100k = dlmread('Trace_0064.csv',',',46,0); 
% 
% I_p(:,1) = [I_p_100k(:,1); I_p_1M(102:end,1); I_p_10M(102:end,1)];
% I_p(:,2) = [I_p_100k(:,2); I_p_1M(102:end,2); I_p_10M(102:end,2)];
% 
% I_n_10M = dlmread('Trace_0067.csv',',',46,0); 
% I_n_1M = dlmread('Trace_0066.csv',',',46,0); 
% I_n_100k = dlmread('Trace_0065.csv',',',46,0); 
% 
% I_n(:,1) = [I_n_100k(:,1); I_n_1M(102:end,1); I_n_10M(102:end,1)];
% I_n(:,2) = [I_n_100k(:,2); I_n_1M(102:end,2); I_n_10M(102:end,2)];
% 
% Q_p_10M = dlmread('Trace_0056.csv',',',46,0); 
% Q_p_1M = dlmread('Trace_0057.csv',',',46,0); 
% Q_p_100k = dlmread('Trace_0058.csv',',',46,0); 
% 
% Q_p(:,1) = [Q_p_100k(:,1); Q_p_1M(102:end,1); Q_p_10M(102:end,1)];
% Q_p(:,2) = [Q_p_100k(:,2); Q_p_1M(102:end,2); Q_p_10M(102:end,2)];
% 
% Q_n_10M = dlmread('Trace_0061.csv',',',46,0); 
% Q_n_1M = dlmread('Trace_0060.csv',',',46,0); 
% Q_n_100k = dlmread('Trace_0059.csv',',',46,0); 
% 
% Q_n(:,1) = [Q_n_100k(:,1); Q_n_1M(102:end,1); Q_n_10M(102:end,1)];
% Q_n(:,2) = [Q_n_100k(:,2); Q_n_1M(102:end,2); Q_n_10M(102:end,2)];

Pin = -20.1;
I_p_10M = dlmread('Trace_0105.csv',',',46,0); 
I_p_1M = dlmread('Trace_0104.csv',',',46,0); 
I_p_100k = dlmread('Trace_0103.csv',',',46,0); 
I_p_100k(1:100,2) = mean(I_p_100k(:,2));

I_p(:,1) = [I_p_100k(:,1); I_p_1M(102:end,1); I_p_10M(102:end,1)];
I_p(:,2) = [I_p_100k(:,2); I_p_1M(102:end,2); I_p_10M(102:end,2)];

I_n_10M = dlmread('Trace_0100.csv',',',46,0); 
I_n_1M = dlmread('Trace_0101.csv',',',46,0); 
I_n_100k = dlmread('Trace_0102.csv',',',46,0); 
I_n_100k(1:100,2) = mean(I_n_100k(:,2));

I_n(:,1) = [I_n_100k(:,1); I_n_1M(102:end,1); I_n_10M(102:end,1)];
I_n(:,2) = [I_n_100k(:,2); I_n_1M(102:end,2); I_n_10M(102:end,2)];

Q_p_10M = dlmread('Trace_0111.csv',',',46,0); 
Q_p_1M = dlmread('Trace_0110.csv',',',46,0); 
Q_p_100k = dlmread('Trace_0109.csv',',',46,0); 
Q_p_100k(1:100,2) = mean(Q_p_100k(:,2));

Q_p(:,1) = [Q_p_100k(:,1); Q_p_1M(102:end,1); Q_p_10M(102:end,1)];
Q_p(:,2) = [Q_p_100k(:,2); Q_p_1M(102:end,2); Q_p_10M(102:end,2)];

Q_n_10M = dlmread('Trace_0106.csv',',',46,0); 
Q_n_1M = dlmread('Trace_0107.csv',',',46,0); 
Q_n_100k = dlmread('Trace_0108.csv',',',46,0); 
Q_n_100k(1:100,2) = mean(Q_n_100k(:,2));

Q_n(:,1) = [Q_n_100k(:,1); Q_n_1M(102:end,1); Q_n_10M(102:end,1)];
Q_n(:,2) = [Q_n_100k(:,2); Q_n_1M(102:end,2); Q_n_10M(102:end,2)];



ADS = dlmread('bbFilt.txt','\t',2,0); 
%%
figure;
hold on;

plot(I_p(:,1),smooth(I_p(:,2)-Pin,20),'linewidth',2)
plot(I_n(:,1),smooth(I_n(:,2)-Pin,20),'linewidth',2)
plot(Q_p(:,1),smooth(Q_p(:,2)-Pin,20),'linewidth',2)
plot(Q_n(:,1),smooth(Q_n(:,2)-Pin,20),'linewidth',2)
plot(ADS(:,1),smooth(ADS(:,2),1),'linewidth',2)


xlim([1e2 1e7]);
xticks(logspace(0,7,8))
ylim([-45 5]);
yticks(-45:5:5)
% yticks([-40:2:0])
set(gca, 'XScale', 'log')
grid on
title('Baseband filters')
xlabel('Frequency [Hz]')
ylabel('Gain [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
legend('I_p','I_n','Q_p','Q_n','Simulated','location','southwest');


print('V2_bbFilt_spectrum','-depsc')
savefig('V2_bbFilt_spectrum')

%%
figure;
hold on;

plot(I_p(:,1),smooth(I_p(:,2)-Pin,200),'linewidth',2)
plot(I_n(:,1),smooth(I_n(:,2)-Pin,200),'linewidth',2)
plot(Q_p(:,1),smooth(Q_p(:,2)-Pin,200),'linewidth',2)
plot(Q_n(:,1),smooth(Q_n(:,2)-Pin,200),'linewidth',2)
% plot(ADS(:,1),smooth(ADS(:,2),1),'linewidth',2)


xlim([1e2 1e6]);
xticks(logspace(0,7,8))
ylim([-3 1]);
% yticks([-40:2:0])
set(gca, 'XScale', 'log')
grid on
title('Baseband filters')
xlabel('Frequency [Hz]')
ylabel('Gain [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
legend('I_p','I_n','Q_p','Q_n','location','southwest');


print('V2_bbFilt_spectrum_zoom','-depsc')
savefig('V2_bbFilt_spectrum_zoom')