% testing
clc, clear, close all
delete(instrfindall)

% ser = serial('COM3', 'InputBufferSize', 2e6);
ser = serial('/dev/tty.usbmodemFD121', 'InputBufferSize', 2e6);
fclose(ser)
fopen(ser)
time = fix(clock);
name = sprintf('data-%s-%d-%d.txt',date,time(4:5))
file = fopen(name, 'w');

flushinput(ser);
buffer = [];
% fprintf(ser,'setvoltage %d\n', 1750)
maxi = 1000;
size_chunk = 12000;
while 1
    %     tic
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