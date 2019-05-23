close all

figure;
hold on;
load('LNA_100us')
plot(eje_freq, data_power(1:end/2),'LineWidth',2)
load('MIX_100us')
plot(eje_freq, data_power(1:end/2),'LineWidth',2)
load('ADC_100us')
plot(eje_freq, data_power(1:end/2),'LineWidth',2)


legend('LNA','MIX','ADC')
xlim([0 1e6])
xlabel('Frecuencias [Hz]');
ylabel('Potencia [dBm]')
title('Ruido')
grid on
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
print('Ruido_100us','-dpng')


figure;
hold on;
load('LNA_1000us')
plot(eje_freq, data_power(1:end/2),'LineWidth',2)
load('MIX_1000us')
plot(eje_freq, data_power(1:end/2),'LineWidth',2)
load('ADC_1000us')
plot(eje_freq, data_power(1:end/2),'LineWidth',2)

legend('LNA','MIX','ADC')
xlim([0 1e6])
xlabel('Frecuencias [Hz]');
ylabel('Potencia [dBm]')
title('Ruido')
grid on
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
print('Ruido_1000us','-dpng')