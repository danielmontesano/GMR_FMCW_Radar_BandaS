%Script que captura los datos transmitidos por el radar y los guarda en un fichero. 
%No configura el radar, hay que hacerlo antes de ejecutar esta función. 
%Es un bucle infinito, cuando se quiera dejar de capturar, se mata el proceso.

clc, clear, close all
delete(instrfindall)

%% Apertura de puerto serie
% ser = serial('COM3', 'InputBufferSize', 2e6); %Windows
ser = serial('/dev/tty.usbmodemFD121', 'InputBufferSize', 2e6); %Mac/Linux
fclose(ser)
fopen(ser)
time = fix(clock);
name = sprintf('data-%s-%d-%d.txt',date,time(4:5)) %Fichero donde se guardaran los datos.
file = fopen(name, 'w');

buffer = [];
maxi = 1000; %Numero de paquetes recibido maximo antes de escribir en el fichero.
size_chunk = 12000; %Numero de datos leidos en puerto serie.
pause(0.5)
flushinput(ser);
while 1
    packets = [];
    received_packets = 1;
    data = zeros(maxi,size_chunk);
    while received_packets < maxi
        data(received_packets,:) = fread(ser, size_chunk, 'uint8'); %ahora mismo con 6000 solo podria recibir paquetes de 1 en 1
        if isempty(data)
            continue
        end
        received_packets = received_packets + 1;
    end
    fwrite(file, reshape(data',size(data,1)*size(data,2),1),'uint8'); 
end
fclose(file)
fclose(ser)