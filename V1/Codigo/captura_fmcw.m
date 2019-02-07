%Script que configura el radar en modo FMCW, procesando la captura y representandola en tiempo real. 	

clc, clear, close all
delete(instrfindall)

%% Configuracion 
fmin = 2.3e9; %[Hz]
fmax = 2.6e9; %[Hz]
B = fmax-fmin; % [Hz] Bandwidth
c = 3e8;
Ts = 950e-6;  %[s] Tiempo de rampa
max = 1; %Cuantas rampas se va a leer
fft_points = 2^16; %Zero padding
xlims = [0 150];
ylims = [-100 0];
Fs = 2e6;

% ser = serial('COM3', 'InputBufferSize', 2e4); %Windows
ser = serial('/dev/tty.usbmodemFA131', 'InputBufferSize', 2e6); %Mac/Linux
fclose(ser)
fopen(ser)
fprintf(ser, 'init 1\n') %Iniciar la generacion de rampa
fprintf(ser, 'envco 1\n') %Habilitar el VCO
flushinput(ser);
buffer = [];

toread = lineal_ramp(fmin,fmax,Ts,ser); %Se genera la rampa y devuelve la longitud de esta


%% Representacion
factor = (Ts)*c/(2*B);
time = Ts*2e6; %Numero de muestras en la rampa de subida
toread = toread*2*max; %Numero de muestras a leer.

subplot(211)
data_p = plot(1);
subplot(212)
fft_p = plot(1);
x = linspace(0, Fs/2, fft_points/2)*factor;
recorte = 0.3*time/2;
i = 0;
%Captura continua
while 1
    i = i+1;
    data = fread(ser, 8000, 'uint8');
    if isempty(data) 
        break
    end
    buffer = cat(1, buffer, data);
	[buffer, packets] = packet_decode(buffer);
    if isempty(packets) || mod(i,2)==1
        continue
    else
%         fprintf("Paquetes: %d!\n", length(packets));
    end
    time = packets(1).length/2;
    data_read = packets(1).data*3.3/2^12;
    data_mean = mean(data_read);
    data_read = reshape(data_read, time, max);
  
    data_read = data_read-data_mean;
    data_read = data_read(1:(end-recorte),:);
    
    data_window = repmat(hanning(size(data_read,1))/sum(hanning(size(data_read,1))), 1, size(data_read,2)).*data_read;
    data_fft = fft(data_window,fft_points,1);
    fft_mean = mean(abs(data_fft),2);
    data_power = 20*log10(fft_mean)+30-10*log10(50)-3; 
    
    set(data_p,'YData', data_read(:,1));
    set(fft_p,'XData', x, 'YData', data_power(1:end/2));
    xlim(xlims);
    ylim(ylims);
    drawnow;

end

fclose(ser)