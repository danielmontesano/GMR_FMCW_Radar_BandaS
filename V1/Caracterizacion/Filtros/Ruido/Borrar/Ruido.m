close all
load('ruido.mat')

figure; hold on;
f_adc = linspace(0,2e6/2,size(RuidoADC,1)/2);
fftADC = 20*log10(abs(fft(RuidoADC)));

f_lna = linspace(0,2e6/2,size(RuidoLNA,1)/2);
fftLNA = 20*log10(abs(fft(RuidoLNA)));

f_mix = linspace(0,2e6/2,size(RuidoMIX,1)/2);
fftMIX = 20*log10(abs(fft(RuidoMIX)));

f_osci = linspace(0,(5e7)/2,size(RuidoOsci,1));
fftOsci = 20*log10(abs(fft(RuidoOsci(:,2))));

%plot(f_osci, fftOsci);
plot(f_adc,fftADC(1:end/2));
plot(f_lna,fftLNA(1:end/2));
plot(f_mix,fftMIX(1:end/2));
%legend('Osci','ADC','MIX','LNA')
legend('ADC','MIX','LNA')
xlim([0 1e6])
xlabel('Frecuencias [Hz]');
ylabel('Potencia [dBm]')
title('Ruido')
grid on
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
print('Ruido','-dpng')