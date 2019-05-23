 load('bpf');
load('sumador');

data_fft = 20*log10(abs(fft(data_read*3.3/4096, points, 1)));
fclose(ser);
frecuencias = linspace(0,Fs/2, size(data_fft,1)/2);


figure()
recorte = 200;
imagesc(x,frecuencias(1:recorte),data_fft(1:recorte,:))
% imagesc(data_fft(1:300,:))

set(gca, 'YDir', 'normal');
% axis([0 time 0 200])
%  set(gca, 'XTick', 1:100)
colormap('jet')
c=colorbar;
caxis([0 100])

c.Label.String = 'Amplitud (dB)';
c.Label.FontSize = 11;
xlabel('Slot')
ylabel('Frecuencia')
% title('Diezmada')
grid
shading flat