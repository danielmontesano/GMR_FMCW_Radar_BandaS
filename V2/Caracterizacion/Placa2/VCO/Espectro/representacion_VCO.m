addpath('/Users/danielmontesano/Documents/MATLAB/rend_v2')
rend('default','painters')

Iloss_splitter = 4;
%con bobina
manufacturer = dlmread('../Manufacturer/Pout.csv',',',2,0);
VCO_loaded50ohm = dlmread('Trace_0025.csv',',',46,0);  % el otro puerto del splitter es cargado con 50 ohm
VCO_loadedPA = dlmread('Trace_0038.csv',',',46,0);  %el otro puerto del splitter es cargado con el PA encendido


%%
figure;
hold on;
plot(VCO_loaded50ohm(:,1),smooth(VCO_loaded50ohm(:,2),20)+Iloss_splitter,'linewidth',2);
% plot(VCO_loadedPA(:,1),smooth(VCO_loadedPA(:,2),20)+Iloss_splitter,'linewidth',2);

plot(manufacturer(:,1),manufacturer(:,2),'linewidth',2);

grid on
xlim([1.5e9 3.3e9])
xticks(1.5e9:0.2e9:3.3e9);
ylim([3 11])
yticks(0:1:16)

legend('Measured','Manufacturer','location','northeast');
% legend('Measured no load','Measured 50 ohm','Measured MIX','Measured PA','Manufacturer','location','northeast');
title('VCO spectrum');
xlabel('Frequency [Hz]')
ylabel('Power [dBm]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)

print('V2_VCO_spectrum','-depsc')
savefig('V2_VCO_spectrum')

