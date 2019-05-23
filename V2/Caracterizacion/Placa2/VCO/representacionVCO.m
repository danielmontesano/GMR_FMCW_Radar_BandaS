clear
% T = csvread('vco_caracterizacion.txt');
T = csvread('vco_caracterizacion.txt');

manufacturer = dlmread('Manufacturer/Vtuning.csv',',',2,0);

figure;
hold on;
plot(T(:,1)*6*3.3/2^12,T(:,3)*1e9, 'LineWidth', 2)
plot(manufacturer(:,1),manufacturer(:,2),'linewidth',2)

% Ganancia_opamp = mean(T(2:end,2)./(T(2:end,1)/4096*3.3))

xlim([1 20]);
xticks(0:2:20)
ylim([1.5e9 3.5e9]);
yticks(1.5e9:0.2e9:3.5e9)

grid on;
title('VCO tuning curve');
legend('Measured','Manufacturer','location','southeast');

xlabel('Tuning voltage [V]')
ylabel('Frequency [Hz]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)

print('V2_VCO_tuning','-depsc')
savefig('V2_VCO_tuning')