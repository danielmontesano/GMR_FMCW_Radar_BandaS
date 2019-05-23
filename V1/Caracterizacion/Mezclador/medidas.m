close all; clear all;

load('mezclador.mat');

figure; hold on; 
plot(LO_RF_P1(:,1),3-LO_RF_P1(:,2)); %Tiene 3dBm de potencia de entrada
plot(LO_RF_P2(:,1),3-LO_RF_P2(:,2)); 
grid on; legend('Placa 1', 'Placa 2'); 
xlabel('Frequency [Hz]'); ylabel('Magnitude [dB]');
title('Aislamiento LO a RF')

 figure; hold on; 
 plot(LO_IF_P1(:,1),3-LO_IF_P1(:,2));  %Tiene 3dBm de potencia de entrada
 plot(LO_IF_P2(:,1),3-LO_IF_P2(:,2)); 
 grid on; legend('Placa 1', 'Placa 2'); 
 xlabel('Frequency [Hz]'); ylabel('Magnitude [dB]');
 title('Isolation between RF and IF ports')
 %%
 figure; hold on; 
%  plot(LO_IF_P1(:,1),3-LO_IF_P1(:,2));  %Tiene 3dBm de potencia de entrada
 plot(LO_IF_P2(:,1),smooth(3-LO_IF_P2(:,2),70),'linewidth',2); 
 grid on;
%  legend('Placa 1', 'Placa 2'); 
 xlabel('Frequency [Hz]'); ylabel('Magnitude [dB]');
 set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
 title('Isolation between RF and IF ports')
 %%
 figure; hold on; 
 plot(RF_10_P1([2:2:end/2+100 round(end/2+100):2:end],1),-10-RF_10_P1([2:2:end/2+100 round(end/2)+100:2:end],2)); %Tiene -10dBm de potencia de entrada
 plot(RF_10_P2([2:2:end/2 round(end/2):2:end],1),0-RF_10_P2([2:2:end/2 round(end/2):2:end],2));   %Tiene 0dBm de potencia de entrada
 grid on; legend('Placa 1', 'Placa 2'); 
 xlabel('Frequency [Hz]'); ylabel('Magnitude [dB]')
 title('Perdidas de insercion')
 
 figure; hold on; 
 plot(RF_1_P1(:,1),-10-RF_1_P1(:,2)); 
 plot(RF_1_P2(:,1),0-RF_1_P2(:,2)); 
 grid on; legend('Placa 1', 'Placa 2'); 
 xlabel('Frequency [Hz]'); ylabel('Magnitude [dB]')
 title('Perdidas de insercion')