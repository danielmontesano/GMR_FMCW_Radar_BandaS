function [total_length] = lineal_ramp(fmin,fmax,time,ser)

% Genera una rampa lineal en frecuencia compensando la curva de tuning del VCO.
% Se le especifica los limites de la banda de frecuencia [Hz] y el tiempo [s], ademas del objeto serial
% del microcontrolador.

fall = 0.05; %porcentaje del tiempo de caida de la rampa
vco = csvread('vco_caracterizacion.txt'); %Fichero con la curva medida de tuning del VCO. DAC value, Voltaje, F[GHz],
valores = vco(:,1);
voltaje = vco(:,2);
freq = vco(:,3)*1e9; %La medida esta en GHz
g = 3.3/4096; %El rango del ADC son 3.3V y 12 bits.


%% Representacion curva VCO
plot(valores, freq, 'x') % curva del tuning del VCO medida
int_valores = 20:0.5:4095;
int_freq = spline(valores, freq, int_valores); %Se interpola para sacar mas puntos
hold on
plot(int_valores, int_freq, 'r') %Se superpone la interpolacion
title('Frecuencia/Tensión VCO')
xlabel('Valor DAC'),ylabel('Frecuencia (GHz)'),
grid on;

%% Calculo de rampa de subida
n_muestras = time*1e6; %La frecuencia de muestreo del DAC es fija a 1 MSPS.
fall_m = floor(n_muestras*fall); %Numero de muestras de rampa de bajada
total_length = n_muestras+fall_m;
deseados = linspace(fmin, fmax, n_muestras); %Se obtiene la rampa en frecuencia deseada
% int_deseados = spline(freq, valores, deseados);
int_deseados = interp1(freq, valores, deseados); %Se obtiene la rampa en tension linearizada en el rango de frecuencias deseado y numero de muestras deseadas
plot(int_deseados, deseados, 'b', 'LineWidth', 2) %Se representa
legend('Medido', 'Total', 'Deseado', 'Location','SouthEast')

%% Calculo de rampa de bajada
caida = linspace(max(int_deseados), min(int_deseados), fall_m); %Se calcula la rampa de bajada en linear en tension.
int_deseados = [int_deseados caida];
figure, plot(int_deseados*g)% Se representa la rampa en tension que se cargara al micro
title('Rampa generada en tensión'),xlabel('Time (\mus)'),ylabel('Voltage (V)')
points = floor(int_deseados);%El micro solo acepta valores enteros.
set_ramp(ser, points, total_length); %Se cargan los datos al micro.]

end

