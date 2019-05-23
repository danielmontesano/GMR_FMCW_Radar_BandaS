clc, clear, close all
delete(instrfindall)

ser = serial('COM3', 'InputBufferSize', 1e6);
% ser = serial('/dev/tty.usbmodemFD121', 'InputBufferSize', 2e6);
% ser = fopen('rampa_habitacion.txt', 'r');
fclose(ser)
fopen(ser)
fprintf(ser,'enabledevice 0 %d\n', 1) %VCO
fprintf(ser,'enabledevice 3 %d\n', 1) %VCO
% fprintf(ser,'enabledevice 4 %d\n', 1) %VCO

for i=0:100:4095
    fprintf(ser,'setvoltage %d\n', i)
    fprintf('DAC en %d\n', i)
    pause
end
% fprintf(ser,'enabledevice 4 %d\n', 1) %DEMOD
% fprintf(ser,'enabledevice 1 %d\n', 1) %LNA1
% fprintf(ser,'enabledevice 2 %d\n', 1) %LNA2
% fprintf(ser,'enabledevice 3 %d\n', 1) %PA
% fprintf(ser,'setgain 20\n') %esto es en dB de forma aproximada, por ahora solo acepta valores enteros
% fprintf(ser,'setfilter 220\n') %esto de 0 a 255, 0 es el filtro menos restrictivo
fclose(ser)