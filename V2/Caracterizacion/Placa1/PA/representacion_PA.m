addpath('/Users/danielmontesano/Documents/MATLAB/rend_v2')
rend('default','painters')

Pref = dlmread('Trace_0025.csv',',',46,0); %-5 dBm
%con bobina
PA_men5dbm_L = dlmread('Trace_0027.csv',',',46,0); %PA Pin=-5dBm
PA_0dbm_L = dlmread('Trace_0028.csv',',',46,0); %PA Pin=0dBm
PA_mas5dbm_L = dlmread('Trace_0030.csv',',',46,0); %PA Pin=+5dBm
PA_byp_mas5dbm_L = dlmread('Trace_0031.csv',',',46,0); %PA bypased Pin=+5dBm

%sin bobina
PA_men5dbm = dlmread('Trace_0040.csv',',',46,0); %PA Pin=-5dBm
PA_0dbm = dlmread('Trace_0041.csv',',',46,0); %PA Pin=0dBm
PA_mas5dbm = dlmread('Trace_0042.csv',',',46,0); %PA Pin=+5dBm
PA_byp_mas5dbm = dlmread('Trace_0043.csv',',',46,0); %PA bypased Pin=+5dBm

%%
figure;
hold on;
plot(PA_men5dbm_L(:,1),smooth(PA_men5dbm_L(:,2)-Pref(:,2)),'linewidth',2);
plot(PA_0dbm_L(:,1),smooth(PA_0dbm_L(:,2)-Pref(:,2)-5),'linewidth',2);
plot(PA_mas5dbm_L(:,1),smooth(PA_mas5dbm_L(:,2)-Pref(:,2)-10),'linewidth',2);
plot(PA_byp_mas5dbm_L(:,1),smooth(PA_byp_mas5dbm_L(:,2)-Pref(:,2)-10),'linewidth',2);



grid on
legend({'P_{in}=-5dBm','P_{in}=0dBm','P_{in}=+5dBm','byp'},...
    'location','southeast','FontSize',12);
xlim([0 6e9])
xticks(0:0.5e9:6e9);
ylim([-8 24])
yticks(-8:2:24)
xlabel('Frequency [Hz]')
ylabel('Gain [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)

print('PA_gain','-depsc')
savefig('PA_gain')

figure;
hold on;
plot(PA_men5dbm(:,1),smooth(PA_men5dbm(:,2)-Pref(:,2)),'linewidth',2);
plot(PA_0dbm(:,1),smooth(PA_0dbm(:,2)-Pref(:,2)-5),'linewidth',2);
plot(PA_mas5dbm(:,1),smooth(PA_mas5dbm(:,2)-Pref(:,2)-10),'linewidth',2);
plot(PA_byp_mas5dbm(:,1),smooth(PA_byp_mas5dbm(:,2)-Pref(:,2)-10),'linewidth',2);


grid on
legend({'P_{in}=-5dBm','P_{in}=0dBm','P_{in}=+5dBm','byp'},...
    'location','southeast','FontSize',12);
xlim([0 6e9])
xticks(0:0.5e9:6e9);
ylim([-8 24])
yticks(-8:2:24)
xlabel('Frequency [Hz]')
ylabel('Gain [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)

print('PA_gain_withoutL','-depsc')
savefig('PA_gain_withoutL')


