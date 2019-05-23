clear, close all
vco = csvread('csvs\C1mix00000.csv');
tiempo = vco(:,1);
voltaje = vco(:,2);
plot(tiempo, voltaje)
xlabel('Tiempo (s)'), ylabel('Voltaje (V)')
saveas(gcf,'Entrada','png');
saveas(gcf,'Entrada','fig');
max(voltaje)-min(voltaje)

vco = csvread('csvs\C1mix200001.csv');
tiempo = vco(:,1);
voltaje = vco(:,2);
figure, plot(tiempo, voltaje)
xlabel('Tiempo (s)'), ylabel('Voltaje (V)')
saveas(gcf,'Testpoint1','png');
saveas(gcf,'Testpoint1','fig');
max(voltaje)-min(voltaje)

vco = csvread('csvs\C1desp00000.csv');
tiempo = vco(:,1);
voltaje = vco(:,2);
figure, plot(tiempo, voltaje)
xlabel('Tiempo (s)'), ylabel('Voltaje (V)')
saveas(gcf,'Testpoint2','png');
saveas(gcf,'Testpoint2','fig');
max(voltaje)-min(voltaje)
