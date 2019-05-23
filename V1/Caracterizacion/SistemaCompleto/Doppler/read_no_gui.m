clc, clear, close all
delete(instrfindall)

ser = serial('COM3', 'InputBufferSize', 4e3);
% ser = serial('/dev/cu.usbmodemFA131', 'InputBufferSize', 16e5);
% ser = fopen('rampa_habitacion.txt', 'r');
fclose(ser)
fopen(ser)
fprintf(ser, 'init 1\n')
fprintf(ser, 'envco 1\n')
% fprintf(ser, 'setgain 5\n');

B = 140e6; %Hz
c = 3e8;
Ts = 1e-3;

factor = (Ts-Ts*0.1)*c/(2*B);
max = 1;
time = Ts*2e6;
toread = time*max;

subplot(211)
data_p = plot(1);
subplot(212)
fft_p = plot(1);
points = 2^15;
x = linspace(0, 2e6/2, points/2)*factor;
recorte = 250;
for i=1:10000
    i
    data_read = fread(ser, toread, 'uint16');
    data_read = data_read(1:toread)*3.3/2^12;
    y = zeros(points, 1);
    for j=1:max
        data = data_read(j*time-time+250:j*time-recorte);% - mean(data_read(j*time-time+250:j*time-recorte));
        datos = hamming(length(data)).*(data);
        y = sqrt(y.^2 + fft(datos, points).^2);
    end
    y = 20*log10(abs(y/max));
    set(data_p,'YData',data);
    set(fft_p,'XData', x, 'YData', y(1:end/2));
    axis([0 70 -50 70])
    pause(0.01)
    
end
fclose(f)