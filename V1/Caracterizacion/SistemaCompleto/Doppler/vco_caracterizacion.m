clear, close all
% Datos de entrada
fmin = 2.26;    %fcrecuencia minima deseada (GHz)
fmax = 2.6;    %fcrecuencia maxima deseada (GHz)
time = 1000;    %tiempo de rampa deseado (uS)
puerto_serie = 'COM3'; 
% puerto_serie = '/dev/cu.usbmodemFA131';
% -----------
vco = csvread('vco_caracterizacion.txt');
voltaje = vco(:,1);
freq = vco(:,2);
g = 3.3/4096;

fall = 0.05; %porcentaje del tiempo de caida de la rampa
plot(voltaje*g, freq, 'x')
int_voltaje = 20:0.5:4095;
int_freq = spline(voltaje, freq, int_voltaje);
hold on
plot(int_voltaje*g, int_freq, 'r')
title('Frecuencia/Tensión VCO'),xlabel('Tensión (V)'),ylabel('Frecuencia (GHz)'), grid

fall_m = floor(time*fall);
deseados = linspace(fmin, fmax, time - fall_m);
int_deseados = spline(freq, voltaje, deseados);
plot(int_deseados*g, deseados, 'b', 'LineWidth', 2)
legend('Total', 'Deseado', 'Location','SouthEast')

caida = linspace(max(int_deseados), min(int_deseados), fall_m);
int_deseados = [int_deseados caida];
figure, plot(int_deseados*g)
title('Rampa generada en tensión'),xlabel('Time (\mus)'),ylabel('Voltage (V)')

delete(instrfindall)
serial = serial(puerto_serie);
fclose(serial);
fopen(serial);

points = floor(int_deseados);
set_ramp(serial, points, time);
fclose(serial);