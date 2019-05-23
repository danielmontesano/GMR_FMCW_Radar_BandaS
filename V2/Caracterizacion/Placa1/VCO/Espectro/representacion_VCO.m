addpath('/Users/danielmontesano/Documents/MATLAB/rend_v2')
rend('default','painters')

Iloss_splitter = 4;
%con bobina
manufacturer = dlmread('../Manufacturer/Pout.csv',',',2,0);
VCO_noload = dlmread('Trace_2000.csv',',',46,0);  %el otro puerto del splitter se deja al aire
VCO_loaded50ohm = dlmread('Trace_0026.csv',',',46,0);  % el otro puerto del splitter es cargado con 50 ohm

% VCO_loaded50ohm = dlmread('Trace_2001.csv',',',46,0);  % el otro puerto del splitter es cargado con 50 ohm
VCO_loadedMIX = dlmread('Trace_2002.csv',',',46,0);  %el otro puerto del splitter es cargado con el puerto LO del mixer encendido
VCO_loadedPA = dlmread('Trace_2003.csv',',',46,0);  %el otro puerto del splitter es cargado con el PA encendido

VCO_0V = dlmread('Trace_1003.csv',',',46,0);  
VCO_4094V = dlmread('Trace_1004.csv',',',46,0);  
VCO_2000V = dlmread('Trace_1005.csv',',',46,0); 
VCO_1000V = dlmread('Trace_1005.csv',',',46,0);  

%%
figure;
hold on;
% plot(VCO_noload(:,1),smooth(VCO_noload(:,2),20)+Iloss_splitter,'linewidth',2);
plot(VCO_loaded50ohm(:,1),smooth(VCO_loaded50ohm(:,2),20)+Iloss_splitter,'linewidth',2);
% plot(VCO_loadedMIX(:,1),smooth(VCO_loadedMIX(:,2),20)+Iloss_splitter,'linewidth',2);
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

%%
figure;
hold on;
plot(VCO_0V(:,1),smooth(VCO_0V(:,2),20),'linewidth',2);
plot(VCO_1000V(:,1),smooth(VCO_1000V(:,2),20),'linewidth',2);
plot(VCO_2000V(:,1),smooth(VCO_2000V(:,2),20),'linewidth',2);
plot(VCO_4094V(:,1),smooth(VCO_4094V(:,2),20),'linewidth',2);

grid on
% xlim([1.5e9 3.3e9])
% xticks(1.5e9:0.2e9:3.3e9);
% ylim([9 16])
% yticks(0:1:16)
title('VCO harmonics');
xlabel('Frequency [Hz]')
ylabel('Power [dBm]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)

print('VCO_tones','-depsc')
savefig('VCO_tones')

