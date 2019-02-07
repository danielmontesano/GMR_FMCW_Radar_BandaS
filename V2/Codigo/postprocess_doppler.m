%Script para procesar los datos doppler capturados con captura_datos.m. 
%Genera un espectrograma. Puede llenar la RAM con capturas muy largas.

clear, close all
file = fopen('data-19-Dec-2018-11-46.txt', 'r');

c = 3e8;
Fs = 2e6;
Fo = 3.292e9; %Frecuencia de onda continua configurada
Ts = 1000e-6; %Duracion de la FFT, que se representara en columnas en el espectrograma
time = 0.1; %Tiempo de captura
maximum_frequency_to_show = 10000; % [Hz] Recorte en frecuencia
factor_doppler = (c/(2*Fo))*3.6; %Para pasar de frecuencia doppler a km/h

limit_pot = [-90 -40]; %limite de potencia para la representacion del espectrograma
n_rampas = floor(time/Ts);
fft_points = 2^(nextpow2(time*Fs)+2);

packet_size = Ts*Fs*2 + 10; %10 es el tamaño de la cabecera de los paquetes
k = 1;
data_fft = [];
buffer = [];
% while ~feof(file)
while k<50
    %     flushinput(ser);
    packets = [];
    received_packets = 0;
    while received_packets < n_rampas
        data = fread(file, n_rampas*packet_size, 'uint8');
        if isempty(data)
            break
        end
        buffer = cat(1, buffer, data);
        [buffer, packets_recv, crc_errors] = packet_decode(buffer);
        if isempty(packets_recv)
            continue
        else
            %         fprintf("Paquetes: %d!\n", length(packets));
        end
        packets = [packets packets_recv];
        received_packets = received_packets + length(packets_recv);
    end
    data_read_i = extractfield(packets,'data_i')*3.3/2^12;
    data_read_i = data_read_i - mean(data_read_i);
    
    data_read_q = extractfield(packets,'data_q')*3.3/2^12;
    data_read_q = data_read_q - mean(data_read_q);
    seq = extractfield(packets,'sequence_num');
%     fprintf('Errores: %d\n',length(find(diff(seq)>1)))
    
    data_IQ = data_read_i-j*data_read_q;
%     window = hanning(size(data_IQ,2));
    window = blackmanharris(size(data_IQ,2));
    window = window./sum(window);
    data_window = window'.*(data_IQ);
    data_fft(:,k) = fftshift(fft(data_window,fft_points));
    k = k+1
end
fclose(file);
figure

%% Representacion espectrograma
maximum_bin = ceil(maximum_frequency_to_show*fft_points/Fs);
data_power = 20*log10(abs(data_fft))+30-10*log10(50);
xAxis = linspace(0,(k-1)*time,k-1);
 yAxis = linspace(-Fs/2, Fs/2, points)*factor_doppler; % Eje de velocidad
% yAxis = linspace(-Fs/2, Fs/2, fft_points);
pcolor(xAxis, yAxis(fft_points/2-maximum_bin:fft_points/2+maximum_bin), data_power(fft_points/2-maximum_bin:fft_points/2+maximum_bin,:))
xlabel('Tiempo (s)'), ylabel('Velocidad (Km/h)')
caxis(limit_pot)
colormap jet
shading flat
colorbar
shg


