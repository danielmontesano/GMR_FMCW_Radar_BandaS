% Guarda y representa
close all;
clear;
load('data.mat');

figure
hold on
plot(PA10dBmPvsfrec(:,1),smooth(PA10dBmPvsfrec(:,2)) + 11.4)
xlabel('Frecuencia (Hz)');ylabel('Potencia (dBm)');
xlim([2.2e9 2.7e9]);
plot(PA3dBmPvsfrec(:,1),PA3dBmPvsfrec(:,2) + 11.4)
plot(PA3dBmPvsfrec1(:,1),PA3dBmPvsfrec1(:,2) + 11.4)
legend('Pin = -10 dBm', 'Pin = -3 dBm', 'Pin = 3 dBm')
grid on
saveas(gcf,'Espectro_menos10menos3y3dBm','fig');
hold off

figure 
plot(PA3dBmPvsfrec1(:,1),smooth(PA3dBmPvsfrec1(:,2) + 11.4 + 3))
xlabel('Frecuencia (Hz)');ylabel('Potencia (dBm)');
xlim([2.4e9 2.5e9]);

figure 
plot(PAVCOplaca1(:,1),PAVCOplaca1(:,2) + 11.4)
xlabel('Frecuencia (Hz)');ylabel('Potencia (dBm)');
grid on
xlim([2.265e9 2.621e9]);
saveas(gcf,'PA_VCO','fig');

