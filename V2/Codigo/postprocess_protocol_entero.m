clc, clear all
file = fopen('data-19-Dec-2018-11-13.txt', 'r');
% fseek(file, 147056000, 0); %%
B = 1000e6; %Ancho de banda configurado. [Hz]
c = 3e8; 
Ts = 1000e-6; %Tiempo de rampa de subida configurado
Fs = 2e6;
integracion = 20; %Integracion horizontal (tiempo lento). Numero de muestras
limiteDis = 100; %Maxima distancia representada
factor = (Ts)*c/(2*B); %Factor FMCW
lengthRampa = Ts*1.1*Fs; %La rampa de bajada suele ser un 10%.
fft_points = 2^13;
limit_pot = [-70 -30]; %Limite para el eje de potencias en representacion
x = linspace(0, Fs/2, fft_points/2)*factor; % Eje de distancias
limiteInd = find(x>limiteDis);
limiteInd = limiteInd(1); %Indice del limite de distancias
% x = linspace(-2e6/2, 2e6/2, points)/1000; % Eje de frecuencias
recorte_inicial = 0.1*lengthRampa/2;
recorte_final = 0.1*lengthRampa/2;

data = fread(file, 'uint8'); 
fprintf('leido\n')
[buffer, packets, crc_errors] = packet_decode(data);%se decodifican todos los paquetes
fprintf('decodificado\n')
received_packets = size(packets,2);
lengthRampa = packets(1).length/4;

data_read_i = extractfield(packets,'data_i')*3.3/2^12;
data_read_i = reshape(data_read_i, lengthRampa, received_packets);
data_read_i = data_read_i(recorte_inicial:(end-recorte_final),:);
data_read_i = data_read_i - mean(data_read_i); %Canal I

data_read_q = extractfield(packets,'data_q')*3.3/2^12;
data_read_q = reshape(data_read_q, lengthRampa, received_packets);
data_read_q = data_read_q(recorte_inicial:(end-recorte_final),:);
data_read_q = data_read_q - mean(data_read_q); %Canal I

data_IQ = data_read_i-1i*data_read_q;


window = hanning(size(data_IQ,1)); %Enventanado
window = window/sum(window);
data_window = repmat(window, 1, size(data_read_i,2)).*(data_IQ);
clear buffer packets_recv data data_read_i data_read_q %Se eliminan variables que no se usaran para vaciar RAM
%% Procesado
fprintf('fft\n')
data_fft = fft(data_window,fft_points,1);

fprintf('filtrando\n')
fft_filt = movmean(20*log10(abs(data_fft(1:limiteInd,:)))+30-10*log10(50),integracion,2);
fft_filt = fft_filt(1:limiteInd,1:integracion:end);
fprintf('representando\n')

%% Representacion
figure
tiempo = linspace(0,received_packets*Ts,size(fft_filt,2));
pcolor(tiempo, x(1:limiteInd),fft_filt);
xlabel('Time [s]'), ylabel('Distance [m]')
colormap jet
shading flat
colorbar
caxis(limit_pot)

view(0,90)
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
ax = gca;
drawnow
