clear, close all
file = fopen('C:\Users\luisg\Desktop\capturas radar\data-19-Dec-2018-11-46.txt', 'r');
% file = fopen('/Users/danielmontesano/Library/Mobile Documents/com~apple~CloudDocs/Universidad/Radar2.5/Capturas/data-19-Dec-2018-11-46.txt', 'r');


buffer = [];

c = 3e8;
Fs = 2e6;
Ts = 1000e-6;
time = 0.1;
n_rampas = floor(time/Ts);
points = 2^(nextpow2(time*Fs)+2);

packet_size = Ts*Fs*2 + 10; %10 es el tamaño de la cabecera de los paquetes
k = 1;
data_fft = [];
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
    data_fft(:,k) = fftshift(fft(data_window,points));
    k = k+1
end
fclose(file);
figure
%%
maximum_frequency_to_show = 10000; % [Hz]
maximum_bin = ceil(maximum_frequency_to_show*points/Fs);
data_power = 20*log10(abs(data_fft))+30-10*log10(50);
xAxis = linspace(0,(k-1)*time,k-1);
% yAxis = linspace(-Fs/2, Fs/2, points)*3e8/2/3.292e9*3.6; % Eje de velocidad
yAxis = linspace(-Fs/2, Fs/2, points);
pcolor(xAxis, yAxis(points/2-maximum_bin:points/2+maximum_bin), data_power(points/2-maximum_bin:points/2+maximum_bin,:))
xlabel('Tiempo(s)'), ylabel('Velocidad (Km/h)')
caxis([-90 -40])
colormap jet
shading flat
colorbar
shg


