addpath('/Users/danielmontesano/Documents/MATLAB/rend_v2')
rend('default','painters')

Loss_cableIN = [1.4, 2.1, 2.7]%[1.65, 2.5, 2.6]; %1.5GHz, 2.5 GHz, 3.5 GHz Incluyendo atenuador 10 dB
Loss_cableOUT = [2.7, 3.8, 4.2]%[2.8, 3.9, 4.7]; %1.5GHz, 2.5 GHz, 3.5 GHz Incluyendo atenuador 10 dB
Pin = [-55:5:-15, -13:2:15];
% Pin = [-60,-55,-50,-45,-40,-35,-30,-25,-20,-15,-14,-13,-12,-11,-10,-9,-8,-7,-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];
LNA1_Pout1500MHz = [];
LNA1_Pout2500MHz = [];
LNA1_Pout3500MHz = [];

for k=73:96
    name = sprintf('Medidas/Trace_00%02.0f.csv',k);
    fileID = fopen(name,'r');
    formatSpec = '%*s%*s%*s%*s%*s%f%*s%*s%*s%*s%[^\n\r]';
    startRow = 39;
    endRow = 41;
    dataArray = textscan(fileID, formatSpec, endRow-startRow+1, 'Delimiter', ',', 'TextType', 'string', 'HeaderLines', startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
    Trace0001 = [dataArray{1:end-1}(1)];
LNA1_Pout1500MHz = [LNA1_Pout1500MHz dataArray{1:end-1}(1)];
LNA1_Pout2500MHz = [LNA1_Pout2500MHz dataArray{1:end-1}(2)];
LNA1_Pout3500MHz = [LNA1_Pout3500MHz dataArray{1:end-1}(3)];
end

%%
figure;
hold on;
plot(Pin-Loss_cableIN(1),smooth(LNA1_Pout1500MHz+Loss_cableOUT(1)-Pin-Loss_cableIN(1))+1.5,'linewidth',2);
plot(Pin-Loss_cableIN(2),smooth(LNA1_Pout2500MHz+Loss_cableOUT(2)-Pin-Loss_cableIN(2))+2,'linewidth',2);
plot(Pin-Loss_cableIN(3),smooth(LNA1_Pout3500MHz+Loss_cableOUT(3)-Pin-Loss_cableIN(3)+4,15),'linewidth',2);
% 


grid on
legend({'Tone at 1.5 GHz','Tone at 2.5 GHz','Tone at 3.5 GHz'},...
    'location','southwest','FontSize',18);
xlim([-40 15])
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
