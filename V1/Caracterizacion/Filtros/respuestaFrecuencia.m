rend('default','painters')

load('respuestaFrecuencia')
figure;
input = 100; %100mVpp
plot(bpf(:,1),20*log10(bpf(:,2)/100))
set(gca, 'XScale', 'log')
xlabel('Frecuencia [Hz]')
ylabel('Gain [dB]');
grid on;

figure;
input = 100; %100mVpp
plot(sumador(:,1),20*log10(sumador(:,2)/100))
set(gca, 'XScale', 'log')
xlabel('Frecuencia [Hz]')
ylabel('Gain [dB]');
grid on