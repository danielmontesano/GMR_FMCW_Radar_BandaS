addpath('/Users/danielmontesano/Documents/MATLAB/rend_v2')
rend('default','painters')

Loss_cableIN = [1.4, 2.1, 2.7]%[1.65, 2.5, 2.6]; %1.5GHz, 2.5 GHz, 3.5 GHz 
Loss_cableOUT = [2.7, 3.8, 4.2]%[2.8, 3.9, 4.7]; %1.5GHz, 2.5 GHz, 3.5 GHz
Pin = [-15:2:15];
% Pin = [-60,-55,-50,-45,-40,-35,-30,-25,-20,-15,-14,-13,-12,-11,-10,-9,-8,-7,-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];
Pout1500MHz = [];
Pout2500MHz = [];
Pout3500MHz = [];

for k=115:130
    name = sprintf('Medidas/Trace_0%03.0f.csv',k);
    fileID = fopen(name,'r');
    formatSpec = '%*s%*s%*s%*s%*s%f%*s%*s%*s%*s%[^\n\r]';
    startRow = 39;
    endRow = 41;
    dataArray = textscan(fileID, formatSpec, endRow-startRow+1, 'Delimiter', ',', 'TextType', 'string', 'HeaderLines', startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
    Trace0001 = [dataArray{1:end-1}(1)];
Pout1500MHz = [Pout1500MHz dataArray{1:end-1}(1)];
Pout2500MHz = [Pout2500MHz dataArray{1:end-1}(2)];
Pout3500MHz = [Pout3500MHz dataArray{1:end-1}(3)];
end
%%
figure;
hold on;
plot(Pin-Loss_cableIN(1),Pout1500MHz+Loss_cableOUT(1)-0.5,'linewidth',2);
plot(Pin-Loss_cableIN(2),Pout2500MHz+Loss_cableOUT(2)+1,'linewidth',2);
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

