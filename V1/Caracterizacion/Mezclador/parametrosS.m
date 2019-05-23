close all; clc; clear all;

figure;
hold on;
grid on;
rfplot(sparameters('2.10.s1p'))
rfplot(sparameters('1.10.s1p'))
title('S11 del puerto LO del mezclador')
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]')
legend('Placa 2', 'Placa 1')

figure;
hold on;
grid on;
rfplot(sparameters('1.11.s1p'))
rfplot(sparameters('1.12.s1p'))
rfplot(sparameters('1.13.s1p'))
title('S11 del puerto RF del mezclador placa 1')
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]')
legend('2.25 GHz', '2.45 GHz', '2.6 GHz')

figure;
hold on;
grid on;
rfplot(sparameters('2.11.s1p'))
rfplot(sparameters('2.12.s1p'))
rfplot(sparameters('2.13.s1p'))
title('S11 del puerto RF del mezclador placa 2')
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]')
legend('2.25 GHz', '2.45 GHz', '2.6 GHz')