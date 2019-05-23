clear, close all
delete(instrfindall)
ser = serial('COM7', 'InputBufferSize', 2e6);
% ser = serial('/dev/cu.usbmodemFD121', 'InputBufferSize', 2e6);

fclose(ser)
fopen(ser)
fprintf(ser, 'envco 1\n');
fprintf(ser, 'setramplength 1000\n');
fprintf(ser, 'setvoltage 3500\n');

c = 3e8;
time = 0.5;
toread = time*2e6;
subplot(212)
fft_p = plot(1);
axis([0 100 0 100])
subplot(211)
data_p = plot(1);
points = 2^21;
x = linspace(0, 2e6/2, points/2);
i = 0;
while 1
    i = i+1
    data = fread(ser, toread, 'uint16')*3.3/2^12;
    data = data - mean(data);
    datos = hamming(length(data)).*(data);
    y = 20*log10(abs(fft(datos, points)));
    set(data_p,'YData',data);
    set(fft_p,'XData', x, 'YData', y(1:end/2));
    [ma, pos] = max(y(1:floor(40/2e6*points)));
    freq = pos/points*2e6;
    fprintf('Frecuencia: %.3f Hz, Velocidad: %.3f m/s', freq, freq*c/2/2.61e9);
    pause(0.001)

end
fclose(f)