clear, close all

T1 = dlmread('MeasR_0014.csv',',',52,0);
T2 = dlmread('MeasR_0015.csv',',',52,0);
T3 = dlmread('MeasR_0016.csv',',',52,0); 
T4 = dlmread('MeasR_0017.csv',',',52,0);
T5 = dlmread('MeasR_0019.csv',',',52,0);
T6 = dlmread('MeasR_0021.csv',',',52,0);
manuf = dlmread('../PhaseNoise_manufacturer.csv',',',2,0);

f = T1(1:2:end,3);
data1 = T1(2:2:end,3);
data2 = T2(2:2:end,3);
data3 = T3(2:2:end,3);
data4 = T4(2:2:end,3);
data5 = T5(2:2:end,3);
data6 = T6(2:2:end,3);

figure, hold on
plot(f,data1,'LineWidth', 1.5)
plot(f,data2,'LineWidth', 1.5)
plot(f,data3,'LineWidth', 1.5)
plot(f,data4,'LineWidth', 1.5)
plot(f,data5,'LineWidth', 1.5)
plot(f,data6,'LineWidth', 1.5)
plot(manuf(:,1), manuf(:,2), '-', 'LineWidth', 1.5)
% plot(teorico_x, teorico_y, '-d', 'MarkerFaceColor', 'c','LineWidth', 1.5)
xlabel('Frecuencia [Hz]'), ylabel('Ruido de fase [dBc]')

l = legend(...
    'Alimentación con fuente OPAMP quitado tuning interno',...
    'Alimentaciones quitadas tuning con pila 1.5 V antes del filtro RC',...
    'Alimentaciones quitadas tuning interno filtro RC en 3200 Hz',...
    'Alimentaciones quitadas tuning interno filtro RC en 592 Hz',...
    'Alimentaciones quitadas tuning interno filtro RC en 592 Hz y software cambiado',...
    'Alimentaciones quitadas tuning interno filtro RC en 592 Hz alimentado micro con 2 pilas AA y software cambiado',...
    'Datasheet',...
    'Location', 'SouthWest');
set(l,'FontSize',10)
set(gca, 'XScale', 'log')
grid

