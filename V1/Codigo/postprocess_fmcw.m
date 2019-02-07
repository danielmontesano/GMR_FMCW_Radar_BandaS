clc, clear, close all
file = fopen('data-27-Dec-2018-14-21.txt', 'r');

B = 200e6; %Hz
c = 3e8;
Ts = 1000e-6;
Fs = 2e6;
factor = (Ts)*c/(2*B);
max = 1;
time = Ts*1.1*Fs;%tiempo de repeticion de rampa
toread = time*max;

% subplot(211)
% data_p = plot(1);
% subplot(212)
% fft_p = plot(1);
points = 2^12;
x = linspace(0, 2e6/2, points/2)*factor;
recorte = 50;
N = 128;
j = 0
while ~feof(file)
    j = j + 1
    data_power = zeros(points, N);
    for i=1:N
        data_read = fread(file, toread, 'uint16');
        data_read = data_read*3.3/2^12;
        data_mean = mean(data_read);
%         data_read = reshape(data_read, time, max);
        
        data_read = data_read-data_mean;
        data_read = data_read(1+recorte:(end-recorte),:);
        
        data_window = repmat(hamming(size(data_read,1))/sum(hamming(size(data_read,1))), 1, size(data_read,2)).*data_read;
        data_fft = fft(data_window,points,1);
        fft_mean = mean(abs(data_fft),2);
        data_power(:,i) = fft_mean;%%20*log10(fft_mean)+30-10*log10(50)-3;

    end
    figure(2)
    pcolor((0:N-1)*Ts, x, 20*log10(data_power(1:end/2,:))+30-10*log10(50)-3);
    xlabel('Tiempo'), ylabel('Distancia (m)')
    colormap jet
    shading flat
    colorbar
    axis([0,(N-1)*Ts, 0,40, -70,0])
    view(0,90)
    

end
fclose(file)