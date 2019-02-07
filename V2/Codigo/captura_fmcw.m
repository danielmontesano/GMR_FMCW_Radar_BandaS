%Script que configura el radar en modo FMCW, procesando la captura y representandolos en tiempo real. 	
clc, close all
delete(instrfindall)

%% Configuracion 
fmin = 1.6e9; %[Hz]
fmax = 3.2e9; %[Hz]
Ts = 1e-3; %[s]
Gain = 20; %[dB] Ganancia del mezclador 

% % ser = serial('COM3', 'InputBufferSize', 1e6); %Windows
ser = serial('/dev/tty.usbmodemFA131', 'InputBufferSize', 2e6); %Mac/Linux
fclose(ser)
fopen(ser)

toread = lineal_ramp(fmin,fmax,Ts,ser);
fprintf(ser,'enabledevice 0 %d\n', 1) %Enable VCO
fprintf(ser,'enabledevice 4 %d\n', 1) %Enable DEMOD
fprintf(ser,'setgain 20\n') %esto es en dB de forma aproximada, por ahora solo acepta valores enteros
fprintf(ser,'setfilter 200\n') %esto de 0 a 255, 0 es el filtro menos restrictivo
%  fprintf(ser,'enabledevice 1 %d\n', 1) %Enable LNA1
% fprintf(ser,'enabledevice 2 %d\n', 1) %Enable LNA2
fprintf(ser,'enabledevice 3 %d\n', 1) %Enable PA


flushinput(ser);
buffer = [];
% fprintf(ser,'setvoltage %d\n', 1750)
B = (fmax-fmin)*1e6; %Hz
c = 3e8;

factor = (Ts)*c/(2*B);
maxi = 50;
toread = toread*maxi;

%% Plot
subplot(311)
data_i = plot(1, 'LineWidth', 1);
title('Data I')
subplot(312)
data_q = plot(1, 'LineWidth', 1);
title('Data Q')
subplot(313)
fft_p = plot(1, 'LineWidth', 1.2);
title('FFT I-jQ')
% xlabel('Frecuencia [kHz]')
xlabel('Distancia [m]')
fft_points = 2^14;
x = linspace(-2e6/2, 2e6/2, fft_points)*factor; % Eje de distancias
% x = linspace(-2e6/2, 2e6/2, points)/1000; % Eje de frecuencias
recorte_inicial = 0.1*Ts/2;
recorte_final = 0.1*Ts/2;

%% Adquisicion continua
while 1

    packets = [];
    received_packets = 0;
    while received_packets < maxi
        data = fread(ser, 6000, 'uint8'); %ahora mismo con 6000 solo podria recibir paquetes de 1 en 1
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
    Ts = packets(1).length/4;
    data_read_i = extractfield(packets,'data_i')*3.3/2^12;
    data_read_i = reshape(data_read_i, Ts, received_packets);
    data_read_i = data_read_i(recorte_inicial:(end-recorte_final),:);
    data_read_i = data_read_i - mean(data_read_i); %Canal I
    
    data_read_q = extractfield(packets,'data_q')*3.3/2^12;
    data_read_q = reshape(data_read_q, Ts, received_packets);
    data_read_q = data_read_q(recorte_inicial:(end-recorte_final),:);
    data_read_q = data_read_q - mean(data_read_q); % Canal Q

    data_IQ = data_read_i-1i*data_read_q;

%     window = blackmanharris(size(data_read_i,1));
    window = hanning(size(data_read_i,1)); %Enventanado 
    window = window/sum(window);
    data_window = repmat(window, 1, size(data_read_i,2)).*(data_IQ);
    
    data_fft = fftshift(fft(data_window,fft_points,1));%FFT
    fft_mean = mean(abs(data_fft),2);
    data_power = 20*log10(fft_mean)+30-10*log10(50);
    
    set(data_i, 'YData', data_read_i(:,1)); %Representacion
    set(data_q, 'YData', data_read_q(:,1));
    set(fft_p, 'XData', x, 'YData', data_power);
    drawnow
end

fclose(ser)