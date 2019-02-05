testing
clc, close all
delete(instrfindall)

% % ser = serial('COM3', 'InputBufferSize', 1e6);
ser = serial('/dev/tty.usbmodemFA131', 'InputBufferSize', 2e6);
% ser = fopen('rampa_habitacion.txt', 'r');
fclose(ser)
fopen(ser)


flushinput(ser);
buffer = [];
% fprintf(ser,'setvoltage %d\n', 1750)
B = (fmax-fmin)*1e6; %Hz
c = 3e8;
Ts = 1000e-6;

factor = (Ts-Ts*0.1)*c/(2*B);
maxi = 50;
time = Ts*2e6;
toread = time*maxi;

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
points = 2^14;
x = linspace(-2e6/2, 2e6/2, points)*factor; % Eje de distancias
% x = linspace(-2e6/2, 2e6/2, points)/1000; % Eje de frecuencias
recorte_inicial = 0.1*time/2;
recorte_final = 0.1*time/2;

while 1
    %     tic
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
    time = packets(1).length/4;
    data_read_i = extractfield(packets,'data_i')*3.3/2^12;
    data_read_i = reshape(data_read_i, time, received_packets);
    data_read_i = data_read_i(recorte_inicial:(end-recorte_final),:);
    data_read_i = data_read_i - mean(data_read_i);
    
    data_read_q = extractfield(packets,'data_q')*3.3/2^12;
    data_read_q = reshape(data_read_q, time, received_packets);
    data_read_q = data_read_q(recorte_inicial:(end-recorte_final),:);
    data_read_q = data_read_q - mean(data_read_q);
%     ex = exp(((1:size(data_read_i,1))-200)/1000);
%     ex = repmat(ex', 1, size(data_read_i,2));
%     data_read_i = data_read_i.*ex;
%     data_read_q = data_read_q.*ex;
    data_IQ = data_read_i-j*data_read_q;
%     data_IQ = data_read_q;
%     window = blackmanharris(size(data_read_i,1));
    window = hanning(size(data_read_i,1));
    window = window/sum(window);
    data_window = repmat(window, 1, size(data_read_i,2)).*(data_IQ);
    data_fft = fftshift(fft(data_window,points,1));
    fft_mean = mean(abs(data_fft),2);
    data_power = 20*log10(fft_mean)+30-10*log10(50);
    
    set(data_i, 'YData', data_read_i(:,1));
    set(data_q, 'YData', data_read_q(:,1));
    set(fft_p, 'XData', x, 'YData', data_power);
%     axis([0 50 -100 10])
    %     toc
    %     length(buffer)
    %     flushinput(ser);
    drawnow
end

fclose(ser)