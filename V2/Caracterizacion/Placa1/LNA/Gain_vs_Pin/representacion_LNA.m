addpath('/Users/danielmontesano/Documents/MATLAB/rend_v2')
rend('default','painters')

Loss_cableIN = [0.8, 1.2, 1.3]; %1.5GHz, 2.5 GHz, 3.5 GHz
Loss_cableOUT = [0.4, 0.7, 1.5]; %1.5GHz, 2.5 GHz, 3.5 GHz
Pin = [-70,-65,-60,-55,-50,-45,-40,-35,-30,-25,-20,-15,-10,-5,-4,-3,-2,-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,];
% Pin = [-60,-55,-50,-45,-40,-35,-30,-25,-20,-15,-14,-13,-12,-11,-10,-9,-8,-7,-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];
LNA1_Pout1500MHz = [-56.5,-52,-47.4,-42.7,-37.7,-32.8,-27.7,-22.8,-18.1,-13.2,-7.8,-2.8,2,7.5,8.7,9.8,10.5,11.5,12.5,13.4,14.4,15.3,16.2,17.2,18.1,18.8,19.4,20,20.5,20.5,20.7,20.9,21.2,21.3];
LNA1_Pout2500MHz = [-55.4,-51.6,-47.4,-42.5,-37.6,-32.7,-27.1,-22.9,-17.8,-12.8,-8.1,-2.7,2.2,6.8,8.8,9.5,10.7,11.3,12.3,13.4,14.1,15.2,16,16.9,17.7,18.4,18.9,19.4,19.7,20,20.3,20.5,20.5,20.7];
LNA1_Pout3500MHz = [-59.5,-55,-51.5,-47.2,-43.1,-37.9,-32.7,-27.9,-22.9,-18.1,-12.9,-8.1,-2.9,3.6,4.5,5.1,6.1,6.9,8,8.8,9.7,10.5,11.7,12.6,13.5,14.4,15.4,16.5,17.4,18.3,19.2,20.1,20.7,21.3];

LNA2_Pout1500MHz = [-56.9,-51.2,-47,-42.3,-37.3,-32.6,-27.6,-22.6,-18.7,-12.7,-7.7,-3.4,2.3,    8.05,8.9,9.9,10.6,11.6,12.6,13.7,14.5,15.4,16.3,17.2,17.9,18.6,19.2,19.8,20.4,20.7,20.9,21.2,21.5,21.7];
LNA2_Pout2500MHz = [-55.3,-51.5,-47.5,-42.8,-38.8,-33.1,-28.3,-23.7,-18.3,-14.4,-8.3,-3.3,1.7,7.7,8.6,9.6,10.2,11.2,12.1,13.1,14.1,15.1,15.8,16.7,17.5,18.2,18.8,19.4,19.8,20.1,20.4,20.5,20.7,20.9];
LNA2_Pout3500MHz = [-58.8,-54.2,-50.1,-47,-42.6,-37.5,-32.7,-28.2,-24,-17.8,-12.7,-9,-2.8,3.4,4.2,5.1,6.2,7.1,7.9,8.9,9.7,10.7,11.6,12.6,13.6,14.6,15.4,16.4,17.4,18.2,19.0,19.7,20.3,20.8];
%%
figure;
hold on;
plot(Pin-Loss_cableIN(1),smooth(LNA2_Pout1500MHz+Loss_cableOUT(1)-Pin-Loss_cableIN(1)),'linewidth',2);
plot(Pin-Loss_cableIN(2),smooth(LNA2_Pout2500MHz+Loss_cableOUT(2)-Pin-Loss_cableIN(2)),'linewidth',2);
plot(Pin-Loss_cableIN(3),smooth(LNA2_Pout3500MHz+Loss_cableOUT(3)-Pin-Loss_cableIN(3)+1,15),'linewidth',2);
% 


grid on
legend({'Tone at 1.5 GHz','Tone at 2.5 GHz','Tone at 3.5 GHz'},...
    'location','southwest','FontSize',18);
xlim([-50 15])
xticks(-70:5:15);
ylim([5 13])
yticks(5:1:15)
xlabel('Pin [dBm]')
ylabel('Gain [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
title('LNA2')

print('V2_LNA_Pin_Gain2','-depsc')
savefig('V2_LNA_Pin_Gain2')

%%
figure;
hold on;
plot(Pin-Loss_cableIN(1),smooth(LNA1_Pout1500MHz+Loss_cableOUT(1)-Pin-Loss_cableIN(1)),'linewidth',2);
plot(Pin-Loss_cableIN(2),smooth(LNA1_Pout2500MHz+Loss_cableOUT(2)-Pin-Loss_cableIN(2)),'linewidth',2);
plot(Pin-Loss_cableIN(3),smooth(LNA1_Pout3500MHz+Loss_cableOUT(3)-Pin-Loss_cableIN(3)+2,15),'linewidth',2);
% 


grid on
legend({'Tone at 1.5 GHz','Tone at 2.5 GHz','Tone at 3.5 GHz'},...
    'location','southwest','FontSize',18);
xlim([-50 15])
xticks(-70:5:15);
ylim([5 13])
yticks(5:1:15)
xlabel('Pin [dBm]')
ylabel('Gain [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
title('LNA1')

print('V2_LNA_Pin_Gain1','-depsc')
savefig('V2_LNA_Pin_Gain1')
