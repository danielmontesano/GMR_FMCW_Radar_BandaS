clc, clear, close all
delete(instrfindall)

if 1
    ser = serial('COM3', 'InputBufferSize', 2e6);
    % ser = serial('/dev/tty.usbmodemFD121', 'InputBufferSize', 2e6);
    fclose(ser)
    fopen(ser)
    % fprintf(ser, 'setramplength 200\n');
    fprintf(ser, 'setvoltage 4000\n');
    fprintf(ser,'enabledevice 0 %d\n', 1) %VCO
    fprintf(ser,'enabledevice 4 %d\n', 1) %DEMOD
    fprintf(ser,'setgain 40\n') %esto es en dB de forma aproximada, por ahora solo acepta valores enteros
    fprintf(ser,'setfilter 220\n') %esto de 0 a 255, 0 es el filtro menos restrictivo
    fprintf(ser,'enabledevice 3 %d\n', 1) %PA
    flushinput(ser);
else
    ser = fopen('data-05-Dec-2018-1-7.txt');
end
buffer = [];

c = 3e8;
Ts = 1000e-6;
time = 1;
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
points = 2^21;
x = linspace(-2e6/2, 2e6/2, points); % Eje de frecuencias

while 1
%     flushinput(ser);
    tic
    packets = [];
    received_packets = 0;
    while received_packets < n_rampas
        data = fread(ser, 12000, 'uint8'); %ahora mismo con 6000 solo podria recibir paquetes de 1 en 1
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
    toc
    time = packets(1).length/4;
    data_read_i = extractfield(packets,'data_i')*3.3/2^12;
    data_read_i = data_read_i - mean(data_read_i);
    
    data_read_q = extractfield(packets,'data_q')*3.3/2^12;
    data_read_q = data_read_q - mean(data_read_q);
    seq = extractfield(packets,'sequence_num');
    length(find(diff(seq)>1))
    
    data_IQ = data_read_i-j*data_read_q;
    %     data_IQ = data_read_q;
    window = blackmanharris(size(data_read_i,1));
    %     window = hanning(size(data_read_i,1));
    window = window/sum(window);
    data_window = repmat(window, 1, size(data_read_i,2)).*(data_IQ);
    data_fft = fftshift(fft(data_window,points));
    data_power = 20*log10(abs(data_fft))+30-10*log10(50);
    
    set(data_i, 'YData', data_read_i);
    set(data_q, 'YData', data_read_q);
    set(fft_p, 'XData', x, 'YData', data_power);
    axis([-300 300 -10 100])
    
    %     length(buffer)
    %     flushinput(ser);
    drawnow
end

fclose(ser)
