clear, close all
file = fopen('data-28-Dec-2018-13-1.txt', 'r');

buffer = [];

c = 3e8;
Fs = 2e6;
Ts = 1000e-6;
time = 0.2;
Fo = 2.6e9
n_rampas = floor(time/Ts);
points = 2^(nextpow2(time*Fs)+1);
factor_doppler = (2*Fo)/c;

lengthRampa = Ts*2e6;
data = fread(file, 'uint16'); 
fprintf('leido\n')

longitud = length(data);
% data(find(data<2025))=2025;
% data = smooth(data,10000);
% figure; plot(data(1:100:end))
% data = data(find(data>2030));
% data = [data; ones(longitud-length(data),1)*mean(data)];

data_read = data*3.3/2^12;
data_read = reshape(data_read, n_rampas*lengthRampa, []);
% data_read = data_read(recorte_inicial:(end-recorte_final),:);
data_read = data_read - mean(data_read);

window = hanning(size(data_read,1));
window = window/sum(window);
data_window = repmat(window, 1, size(data_read,2)).*(data_read);
% clear buffer packets_recv data data_read_i data_read_q

fprintf('fft\n')
data_fft = fftshift(fft(data_window,points,1));

fprintf('representando\n')
%%
maximum_frequency_to_show = 500; % [Hz]
maximum_bin = ceil(maximum_frequency_to_show*points/Fs);
data_power = 20*log10(abs(data_fft))+30-10*log10(50);
%  data_power = data_power(:,find(mean(data_power,1)<-95));

figure;
tiempo = linspace(0,size(data_read,2)*time,size(data_power,2));
% xAxis = linspace(0,(k-1)*time,k-1);
yAxis = linspace(-Fs/2, Fs/2, points);
pcolor(tiempo, yAxis(points/2-maximum_bin:points/2+maximum_bin), data_power(points/2-maximum_bin:points/2+maximum_bin,:))
xlabel('Time [s]'),  ylabel('Frequency [Hz]')% Eje de frecuencias
colormap jet
 caxis([-110 -30])
shading flat
h = colorbar;
ylabel(h,'Power [dBm]');
shg
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)

figure;
yAxis = -linspace(-Fs/2, Fs/2, points)/factor_doppler;
pcolor(tiempo, yAxis(points/2-maximum_bin:points/2+maximum_bin), data_power(points/2-maximum_bin:points/2+maximum_bin,:))
xlabel('Time [s]'), ylabel('Speed [m/s]')
colormap jet
 ylim([0 15])
 xlim([18 30])
 caxis([-100 -40])
shading flat
h = colorbar;
ylabel(h,'Power [dBm]');
shg
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)



