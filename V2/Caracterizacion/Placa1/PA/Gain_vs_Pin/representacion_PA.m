addpath('/Users/danielmontesano/Documents/MATLAB/rend_v2')
rend('default','painters')

Loss_cableIN = [0.8, 1.2, 1.4]; %1.5GHz, 2.5 GHz, 3.5 GHz
Loss_cableOUT = [0.4, 0.7, 1]; %1.5GHz, 2.5 GHz, 3.5 GHz
Pin = [-60,-55,-50,-45,-40,-35,-30,-25,-20,-15,-14,-13,-12,-11,-10,-9,-8,-7,-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];
Pout1500MHz = [-38.2,-33.1,-28.7,-29.0,-19.3,-14.3,-11.8,-4.6,0.5,5.5,   7,8,9,10,10.7,11.6,12.6,13.6,14.5,15.4,16.3,17.2,18,18.8,19.4,20.1,20.5,20.8,21,21.2,21.3,21.3,21.2,21.1,20.9,20.7,20.5,20.3,19.8,19.7,];
Pout2500MHz = [-37.1,-34.6,-30.8,-26.0,-21.7,-17,-15.6,-7,-1.9,3   ,4.9,5.6,6.7,7.4,8.5,9.3,10,11,12,13,13.8,14.7,15.6,16.3,17,17.6,18.2,18.7,19.1,19.4,19.6,19.7,19.7,19.7,19.4,19.4,19.1,19.0,18.8,18.7];
Pout3500MHz = [-40.2,-37.1,-33.4,-23.0,-25,-20.3,-9.4,-10.5,-5.6,-0.8    ,2.6,3.5,4.5,5.4,6.3,6.9,7.9,8.2,8.6,9.5,10.5,11.3,12.2,13.2,14.2,15,15.8,16.6,17.2,18,18.5,19.0,19.4,19.6,19.6,19.7,19.8,19.7,19.6,19.5];
%%
figure;
hold on;
plot(Pin-Loss_cableIN(1),Pout1500MHz+Loss_cableOUT(1),'linewidth',2);
plot(Pin-Loss_cableIN(2),Pout2500MHz+Loss_cableOUT(2),'linewidth',2);
plot(Pin-Loss_cableIN(3),Pout3500MHz+Loss_cableOUT(3),'linewidth',2);


grid on
legend({'Tone at 1.5 GHz','Tone at 2.5 GHz','Tone at 3.5 GHz'},...
    'location','southeast','FontSize',18);
xlim([-15 15])
% xticks(0:0.5e9:6e9);
ylim([4 24])
yticks(-8:2:25)
xlabel('P_{IN} [dBm]')
ylabel('P_{OUT} [dBm]');
title('P_{OUT} VS P_{IN} of the PA')
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)

print('V2_PA_Pin_Pout','-depsc')
savefig('V2_PA_Pin_Pout')

