close all

pin=-20:3; %dBm
f22=[6.95 8.1 9.2 10.2 11.3 12.7 13.9 15 16.2 17.2 18.4 19.7 20.7 21.7 22.6 23.4 24 24.5 24.8 25.1 25.3 25.46 25.53 25.55];
f245=[3.4 4.5 5.5 6.5 7.5 9 10.1 11.1 12.2 13.2 14.6 15.7 16.8 17.8 18.8 19.9 20.9 21.7 22.3 22.7 23.1 23.3 23.4 23.5];
f27=[6.4 7.5 8.6 9.6 10.6 11.7 12.7 13.8 14.8 15.8 16.75 17.7 18.55 19.33 19.95 20.525 20.95 21.3 21.57 21.78 21.975 22.09 22.15 22.16];

figure
hold on
z=@(xx) interp1(pin,f22,xx,'spline');
fplot(z,[pin(1),pin(end)])
z=@(xx) interp1(pin,f245,xx,'spline');
fplot(z,[pin(1),pin(end)])
z=@(xx) interp1(pin,f27,xx,'spline');
fplot(z,[pin(1),pin(end)])
xlabel('Potencia de entrada (dBm)');
ylabel('Potencia de salida (dBm)');
xlim([pin(1) pin(end)]);
grid on
legend('2.2 GHz','2.45 GHz','2.6 GHz','Location','northwest')
saveas(gcf,'PA_Po_vs_Pin','fig');
hold off

gain = zeros(3,length(pin));
gain(1,:) = f22 - pin;
gain(2,:) = f245 - pin;
gain(3,:) = f27 - pin;

pout = zeros(3,length(pin));
pout(1,:)=f22;
pout(2,:)=f245;
pout(3,:)=f27;

figure
hold on
z=@(xx) interp1(f22,gain(1,:),xx,'spline');
fplot(z,[f22(1),f22(end)])

z=@(xx) interp1(f245,gain(2,:),xx,'spline');
fplot(z,[f245(1),f245(end)])
z=@(xx) interp1(f27,gain(3,:),xx,'spline');
fplot(z,[f27(1),f27(end)])
ylabel('Ganancia (dB)');
xlabel('Potencia de salida (dBm)');
grid on
legend('2.2 GHz','2.45 GHz','2.7 GHz','Location','northwest')
xlim([min(min(pout))-0.5,max(max(pout)) + 0.5]);
saveas(gcf,'PA_Gain_vs_Pout','fig');
hold off

% Consumo
I = [0.259 0.261 0.263 0.267 0.273 0.281 0.294 0.309 0.330 0.355 0.387 0.427 0.478];
I = I - I(1);
poutC = 0:2:25;

figure
hold on
z=@(xx) interp1(poutC,I(1,:),xx,'spline');
fplot(z,[poutC(1),poutC(end)])
ylabel('Icc (A)');
xlabel('Potencia de salida (dBm)');
grid on
saveas(gcf,'Consumo_PA','fig');
