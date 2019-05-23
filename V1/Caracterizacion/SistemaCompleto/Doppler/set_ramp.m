function [  ] = set_ramp( serial, points, len)

% Los parametros de la funcion son el puerto serial a utilizar
% un vector con los puntos deseados en el rango de 0 a 2^12-1
% y la longitud de la rampa en microsegundos.

if length(points) ~= len
    fprintf("ERROR: numero de puntos del archivo incorrecto\n");
    fclose(f);
    return
end

fprintf("newramp %d\n", len);
fprintf(serial, "newramp %d\n", len);
num_chunks = 20;
for j=0:len/num_chunks-1
    chop = points(j*num_chunks+1:j*num_chunks+num_chunks);
    chop = num2str(chop);
    fprintf("addpoints %d %s\n",[num_chunks chop]);
    fprintf(serial, "addpoints %d %s\n",[num_chunks chop]);
    pause(0.05)
end
rem = len - num_chunks*floor(len/num_chunks); %remaining points
if rem > 0
    chop = points(floor(len/num_chunks)*num_chunks+...
    1:floor(len/num_chunks)*num_chunks+rem);
    chop = num2str(chop);
    fprintf("addpoints %d %s\n",num_chunks, chop);
	fprintf(serial, "addpoints %d %s\n",num_chunks, chop);
    pause(0.05)
end
fprintf("setramp 1\n");
fprintf(serial, "setramp 1\n");

end