clc, clear, close all
delete(instrfindall)

%% Configuracion
c = 3e8;
Ts = 1000e-6;
Fo = 2.5e9
Fs = 2e6;
time = 0.5;
g=3.3/2^12; %El rango del DAC de 12 bits es 3.3 V 
fft_points = 2^21; %Zero padding

ser = serial('COM3', 'InputBufferSize', 2e6); %Windows
% ser = serial('/dev/tty.usbmodemFD121', 'InputBufferSize', 2e6); %Mac/Linux
fclose(ser)
fopen(ser)
fprintf(ser, 'init 1\n') %Iniciar generacion de rampa
fprintf(ser, 'envco 1\n')%Habilitar VCO
fprintf(ser, 'setramplength %d\n', floor(Ts/1e-6));
fprintf(ser, 'setvoltage %d\n',flor(Fo/g)); %Frecuencia fija
flushinput(ser);
buffer = [];

%% Representacion
n_rampas = floor(time/Ts);
subplot(211)
data_p = plot(1);
subplot(212)
fft_p = plot(1);
x = linspace(0, Fs/2, fft_points/2);

%% Captura continua
while 1
    acc = 0;
    data_read = zeros((n_rampas+10)*Ts*Fs, 1);
    seq = zeros((n_rampas+10), 1);
    tic
    while acc < n_rampas
        data = fread(ser, 2^16, 'uint8');
        if isempty(data)
            break
        end
        buffer = cat(1, buffer, data);
        [buffer, packets] = packet_decode(buffer); 
        if isempty(packets)
            continue
        else
            len = length(packets);
            data_len = packets(1).length/2;
            for i=0:len-1
                data_read((acc+i)*data_len+1:(acc+i)*data_len+data_len) = packets(i+1).data*3.3/2^12;
                seq(acc+i+1) = packets(i+1).sequence_num;
            end
            acc = acc + len;
            %         fprintf("Paquetes: %d!\n", length(packets));
        end
    end
    length(find(diff(seq)>1))
    data = data_read(1:acc*Ts*2e6);% - mean(data_read);
    datos = hamming(length(data))/sum(hamming(size(data,1))).*data;
    y = 20*log10(abs(fft(datos, fft_points)))+30-10*log10(50)-3;
    set(data_p,'YData',data);
    set(fft_p,'XData', x, 'YData', y(1:end/2));
    axis([0 1e6 -120 -20])
    [ma, pos] = max(y(1:floor(40/Fs*fft_points)));
    freq = pos/fft_points*Fs;
    fprintf('Frecuencia: %.3f Hz, Velocidad: %.3f m/s\n', freq, freq*c/2/Fo);
    flushinput(ser);
    toc
    drawnow 
%     pause(0.001)

end

fclose(ser)