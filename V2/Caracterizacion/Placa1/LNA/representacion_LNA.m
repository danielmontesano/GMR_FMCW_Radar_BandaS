addpath('/Users/danielmontesano/Documents/MATLAB/rend_v2')
rend('default','painters')

Pref = dlmread('Trace_0025.csv',',',46,0); %-5 dBm
LNA2_men20dbm = dlmread('Trace_0032.csv',',',46,0); %LNA2 Pin=-20dBm
LNA2_men5dbm = dlmread('Trace_0033.csv',',',46,0); %LNA2 Pin=-5dBm
LNA2_mas5dbm = dlmread('Trace_0034.csv',',',46,0); %LNA2 Pin=+5dBm
LNA2_byp_mas5dbm = dlmread('Trace_0035.csv',',',46,0); %LNA2 bypased Pin=+5dBm

LNA1_men20dbm = dlmread('Trace_0039.csv',',',46,0); %LNA1 Pin=-20dBm
LNA1_men5dbm = dlmread('Trace_0038.csv',',',46,0); %LNA1 Pin=-5dBm
LNA1_mas5dbm = dlmread('Trace_0037.csv',',',46,0); %LNA1 Pin=+5dBm
LNA1_byp_mas5dbm = dlmread('Trace_0036.csv',',',46,0); %LNA1 bypased Pin=+5dBm


LNA1_conector = dlmread('Trace_0040.csv',',',46,0); %LNA1 Pin=-20dBm
LNA2_conector = dlmread('Trace_0041.csv',',',46,0); %LNA1 Pin=-5dBm
%%
figure;
hold on;

plot(LNA2_men20dbm(:,1),smooth(LNA2_men20dbm(:,2)-Pref(:,2)+15),'linewidth',2);
plot(LNA2_men5dbm(:,1),smooth(LNA2_men5dbm(:,2)-Pref(:,2)),'linewidth',2);
plot(LNA2_mas5dbm(:,1),smooth(LNA2_mas5dbm(:,2)-Pref(:,2)-10),'linewidth',2);
plot(LNA2_byp_mas5dbm(:,1),smooth(LNA2_byp_mas5dbm(:,2)-Pref(:,2)-10),'linewidth',2);

plot(LNA1_men20dbm(:,1),smooth(LNA1_men20dbm(:,2)-Pref(:,2)+15),'linewidth',2);
plot(LNA1_men5dbm(:,1),smooth(LNA1_men5dbm(:,2)-Pref(:,2)),'linewidth',2);
plot(LNA1_mas5dbm(:,1),smooth(LNA1_mas5dbm(:,2)-Pref(:,2)-10),'linewidth',2);
plot(LNA1_byp_mas5dbm(:,1),smooth(LNA1_byp_mas5dbm(:,2)-Pref(:,2)-10),'linewidth',2);



grid on
legend({'LNA2 P_{in}=-20dBm','LNA2 P_{in}=-5dBm',...
    'LNA2 P_{in}=+5dBm','LNA2 byp',...
    'LNA1 P_{in}=-20dBm','LNA1 P_{in}=-5dBm',...
    'LNA1 P_{in}=+5dBm','LNA2 byp'},...
    'location','southeast','FontSize',12);
xlim([0 4e9])
xticks(0:0.5e9:4e9);
ylim([-20 20])
xlabel('Frequency [Hz]')
ylabel('Gain [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)

print('LNA_gain','-depsc')
savefig('LNA_gain')

%%

figure
hold on;

plot(LNA1_conector(:,1),LNA1_conector(:,2))
plot(LNA2_conector(:,1),LNA2_conector(:,2))

legend('LNA1','LNA2')