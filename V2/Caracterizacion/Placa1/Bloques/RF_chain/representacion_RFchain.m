addpath('/Users/danielmontesano/Documents/MATLAB/rend_v2')
rend('default','painters')

%con bobina
PA_VCO = dlmread('Trace_2004.csv',',',46,0); 
PA_VCO_att = dlmread('Trace_2005.csv',',',46,0);
% PA_VCO_LNA = dlmread('Trace_1011.csv',',',46,0); %Att 49db entrad LNA
PA_VCO_LNA = dlmread('Trace_2007.csv',',',46,0); %VCO PA vivaldi separadas 20cm en la mesa y LNA1
%%
figure;
hold on;
plot(PA_VCO(:,1),smooth(PA_VCO(:,2),20)+1,'linewidth',2);
plot(PA_VCO_att(:,1),smooth(PA_VCO_att(:,2)+1,20),'linewidth',2);

grid on
legend({'VCO directly connected to PA','VCO conected to PA with 5 dB Att'},...
    'location','southeast','FontSize',12);
 xlim([1.5e9 3.3e9])
xticks(1.5e9:0.2e9:3.3e9);
ylim([12 22])
yticks(12:1:24)
title('PA driven by VCO');
xlabel('Frequency [Hz]')
ylabel('Power [dBm]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)

print('V2_PA_VCO','-depsc')
savefig('V2_PA_VCO')

%%
figure;
hold on;
plot(PA_VCO_LNA(:,1),smooth(PA_VCO_LNA(:,2)-10,20),'linewidth',2); 
grid on
 xlim([1.5e9 3.3e9])
xticks(1.5e9:0.2e9:3.3e9);
 ylim([-3 7])
yticks(-24:1:50)
title('RF chain');
xlabel('Frequency [Hz]')
ylabel('Received power [dBm]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)

print('V2_RF_chain','-depsc')
savefig('V2_RF_chain')

% 



