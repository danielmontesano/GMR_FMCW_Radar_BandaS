%Script que configura el radar en modo doppler, procesando la captura y representandolos en tiempo real. 

clc, clear, close all
delete(instrfindall)

%% Apertura de puerto serie
% ser = serial('COM3', 'InputBufferSize', 2e6); %WINDOWS
ser = serial('/dev/tty.usbmodemFA131', 'InputBufferSize', 2e6); %MAC
fclose(ser)
fopen(ser)

c = 3e8;
Ts = 1000e-6; %Duracion de la FFT
time = 1; %Tiempo de captura
freq = 3e9;
g=6*3.3/2^12; %El rango del DAC de 12bits es 3.3 V con un amplificador de ganancia 6
Fs = 2e6;
%% Configuracion

fprintf(ser, 'setramplength %d\n', floor(Ts/1e-6));
fprintf(ser, 'setvoltage %d\n',floor(freq/g)); %Frecuencia fija
fprintf(ser,'enabledevice 0 %d\n', 1) %VCO
fprintf(ser,'enabledevice 4 %d\n', 1) %DEMOD
fprintf(ser,'setgain 40\n') 
fprintf(ser,'setfilter 220\n') %esto de 0 a 255, 0 es el filtro menos restrictivo
fprintf(ser,'enabledevice 3 %d\n', 1) %PA
flushinput(ser);
buffer = [];


%% Representacion de los datos capturados
n_rampas = floor(time/Ts);

subplot(311)
data_i = plot(1, 'LineWidth', 1);
title('Data I')
subplot(312)
data_q = plot(1, 'LineWidth', 1);
title('Data Q')
subplot(313)
fft_p = plot(1, 'LineWidth', 1.2);
title('FFT I-jQ'),xlabel('Frecuencia [Hz]')
FFT_points = 2^21;
x = linspace(-Fs/2, Fs/2, FFT_points); % Eje de frecuencias
%% Adquisicion y representacion continua
while 1
%     flushinput(ser);
    tic
    packets = [];
    received_packets = 0;
    while received_packets < n_rampas %se recibe la captura de la longitud deseada
        data = fread(ser, 12000, 'uint8'); %ahora mismo con 6000 solo podria recibir paquetes de 1 en 1
        if isempty(data)
            break
        end
        buffer = cat(1, buffer, data);
        [buffer, packets_recv, crc_errors] = packet_decode(buffer); %Se decodifican los paquetes recibidos
        if isempty(packets_recv)
            continue
        else
            %         fprintf("Paquetes: %d!\n", length(packets));
        end
        packets = [packets packets_recv];
        received_packets = received_packets + length(packets_recv);
    end
    toc
    time = packets(1).length/4;
    data_read_i = extractfield(packets,'data_i')*3.3/2^12;
    data_read_i = data_read_i - mean(data_read_i); %Se parsean los datos del canal I
    
    data_read_q = extractfield(packets,'data_q')*3.3/2^12;
    data_read_q = data_read_q - mean(data_read_q); %Se parsean los datos del canal I
    seq = extractfield(packets,'sequence_num');
    length(find(diff(seq)>1))
    
    data_IQ = data_read_i-j*data_read_q;
    window = blackmanharris(size(data_read_i,1));
    %     window = hanning(size(data_read_i,1));
    window = window/sum(window);
    data_window = repmat(window, 1, size(data_read_i,2)).*(data_IQ);%Enventanado
    data_fft = fftshift(fft(data_window,FFT_points));
    data_power = 20*log10(abs(data_fft))+30-10*log10(50);%Se hace la FFT y se pasa a dbm
    
    %Representacion
    set(data_i, 'YData', data_read_i);
    set(data_q, 'YData', data_read_q);
    set(fft_p, 'XData', x, 'YData', data_power);
    axis([-300 300 -10 100])
    
    drawnow
end

fclose(ser)
