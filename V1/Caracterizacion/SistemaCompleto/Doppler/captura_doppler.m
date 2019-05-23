clear, close all
delete(instrfindall)
ser = serial('COM7', 'InputBufferSize', 50*2e6);
% ser = serial('/dev/cu.usbmodemFD121', 'InputBufferSize', 5*2e6);
ramp_length = 200000; %us
fclose(ser)
fopen(ser)
fprintf(ser, 'envco 1\n');
 fprintf(ser, 'setramplength %d\n',ramp_length);
fprintf(ser, 'setvoltage 1000\n');

Fs = 2e6;
time = 10;
fft_muestras = (ramp_length*1e-6)*Fs;
rampas = time/(ramp_length*1e-6);
points = 2^21;
x = linspace(0, time, rampas);

data_read = [];
for i=1:floor(rampas)
%     i
%     data = fread(ser, fft_muestras, 'uint16');
%     data_read(:,i) = data();
%     data_read(:,i) = data_read(:,i) - mean(data_read(:,i));

    data_read(:,i)  = fread(ser, fft_muestras, 'uint16');
    data_read(:,i) = data_read(:,i) - mean(data_read(:,i));

end
data_fft = fft(data_read*3.3/4096, points, 1);
fclose(ser);
frecuencias = linspace(0,Fs/2, size(data_fft,1)/2);


figure(7)
c = (20*log10(abs(data_fft(1:end/2,:))));
% imagesc(x,frecuencias,(20*log10(abs(data_fft(1:end/2,:)))))
imagesc(c(:,1:200))

set(gca, 'YDir', 'normal');
% axis([0 time 0 200])
% set(gca, 'XTick', 1:100)
colormap('jet')
c=colorbar;
caxis([0 100])

c.Label.String = 'Amplitud (dB)';
c.Label.FontSize = 11;
xlabel('Slot')
ylabel('Frecuencia')
% title('Diezmada')
grid
shading flat


% close all
% open('doppler_dani_carrito.fig')
% h = gcf
% [~,objTypes] = h.Children.Children
% data_fft_log = objTypes.CData(1:50,:);
% imagesc(objTypes.XData,objTypes.YData(1:50),data_fft_log)
% set(gca, 'YDir', 'normal');
% colormap('jet')
% c=colorbar;
% caxis([0 80])