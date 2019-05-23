rend('default','painters')
points = 2^15;
c = 3e8;
Ts = 1e-3;

v = 0.71*2; %Porcentaje de c al transmitirse en el cable. por 2 al ser un cable y no tener ida y vuelta 

figure;
hold on;

load('cableLargo_230_255');
B = 250e6;
factor = 0.9*Ts*c/(2*B);
x = linspace(0, 2e6/2, points/2)*factor*v;
plot(x,y(1:end/2),'linewidth',2);

load('cableLargo_230_240');
B = 100e6;
factor = 0.9*Ts*c/(2*B);
x = linspace(0, 2e6/2, points/2)*factor*v;
plot(x,y(1:end/2),'linewidth',2);

load('cableLargo_226_260');
B = 340e6;
factor = 0.9*Ts*c/(2*B);
x = linspace(0, 2e6/2, points/2)*factor*v;
plot(x,y(1:end/2),'linewidth',2);

load('cableLargo_226_240');
B = 140e6;
factor = 0.9*Ts*c/(2*B);
x = linspace(0, 2e6/2, points/2)*factor*v;
plot(x,y(1:end/2),'linewidth',2);


set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
legend('2.3-2.55 GHz','2.3-2.4 GHz','2.26-2.6 GHz','2.26-2.4 GHz')
title('26 meters long cable');
xlabel('Distance [m]')
ylabel('Amplitude [dB]')
grid on
xlim([0 100])
xticks(0:10:100);
yticks(-60:10:60);

print('Cable_26m','-depsc')
savefig('Cable_26m')

figure;
hold on;

load('cableCorto_230_255');
B = 250e6;
factor = 0.9*Ts*c/(2*B);
x = linspace(0, 2e6/2, points/2)*factor*v;
plot(x,y(1:end/2),'linewidth',2);

load('cableCorto_230_240');
B = 100e6;
factor = 0.9*Ts*c/(2*B);
x = linspace(0, 2e6/2, points/2)*factor*v;
plot(x,y(1:end/2),'linewidth',2);

load('cableCorto_226_260');
B = 340e6;
factor = 0.9*Ts*c/(2*B);
x = linspace(0, 2e6/2, points/2)*factor*v;
plot(x,y(1:end/2),'linewidth',2);

load('cableCorto_226_240');
B = 140e6;
factor = 0.9*Ts*c/(2*B);
x = linspace(0, 2e6/2, points/2)*factor*v;
plot(x,y(1:end/2),'linewidth',2);

set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)

legend('2.3-2.55 GHz','2.3-2.4 GHz','2.26-2.6 GHz','2.26-2.4 GHz')
title('20 meters long cable');
xlabel('Distance [m]')
ylabel('Amplitude [dB]')
grid on
xlim([0 100])
xticks(0:10:100);
yticks(-60:10:60);
print('Cable_20m','-depsc')
savefig('Cable_20m')