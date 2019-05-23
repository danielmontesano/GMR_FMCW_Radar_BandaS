clear, close all
T1 = dlmread('ruido_fase_alimentacion_interna_tuningexterno_pila2.csv',',',52,0);
T2 = dlmread('ruido_fase_alimentacion_interna_tuningexterno.csv',',',52,0); 
T3 = dlmread('ruido_fase_alimentacion_interna_tuningexterno_pila2.csv',',',52,0);
T4 = dlmread('ruido_fase_alimentacion_pila_no_res.csv',',',52,0);
T5 = dlmread('ruido_fase_ampliOPA_alimentcion_interna_modulacion_filtrada.csv',',',54,0);
manuf = dlmread('PhaseNoise_manufacturer.csv',',',2,0);

f = T1(1:2:end,3);
data1 = T1(2:2:end,3);
data2 = T2(2:2:end,3);
data3 = T3(2:2:end,3);
data4 = T4(2:2:end,3);
data5 = T5(:,2);

figure, hold on
plot(f,data1,'LineWidth', 1.5)
plot(f,data2,'LineWidth', 1.5)
% plot(f,data3,'LineWidth', 1.5)
plot(f,data4,'LineWidth', 1.5)
plot(f,data5,'LineWidth', 1.5)
plot(manuf(:,1), manuf(:,2), '-', 'LineWidth', 1.5)
xlabel('Frecuencia [Hz]'), ylabel('Ruido de fase [dBc]')

l = legend( 'Alimentación interna tuning externo pila',...
            'Alimentacion interna tuning externo fuente',...
            'Alimentado pila tuning cortocircuitado',...
            'Alimentacion interna modulación interna',...
            'Datasheet',...
            'Location', 'SouthWest');
set(l,'FontSize',10)
set(gca, 'XScale', 'log')
grid

%%
clear, close all

T1 = dlmread('ruido_fase_alimentacion_interna_2_4GHz.csv',',',52,0);
T2 = dlmread('ruido_fase_alimentacion_interna_tuning_alimentacion_ext.csv',',',52,0);
T3 = dlmread('ruido_fase_ampliOPA_alimentcion_interna_vtune_micro.csv',',',52,0); 
T4 = dlmread('ruido_fase_ampliOPA_alimentacion_externa_cargado.csv',',',52,0);
T5 = dlmread('ruido_fase_ampliOPA_alimentcion_interna_filtrada.csv',',',52,0);
T6 = dlmread('ruido_fase_ampliOPA_alimentcion_interna_modulacion_filtrada.csv',',',54,0);
T7 = dlmread('ruido_fase_alimentacion_interna_filtrada_no_opamp.csv',',',54,0);
T8 = dlmread('ruido_fase_alimentacion_pila_no_opamp.csv',',',52,0);
T9 = dlmread('ruido_fase_alimentacion_pila_no_res.csv',',',52,0);
T11 = dlmread('ruido_fase_alimentacion_interna_tuning_pila.csv',',',52,0);
manuf = dlmread('PhaseNoise_manufacturer.csv',',',2,0);

f = T1(1:2:end,3);
data1 = T1(2:2:end,3);
data2 = T2(2:2:end,3);
data3 = T3(2:2:end,3);
data4 = T4(2:2:end,3);
data5 = T5(2:2:end,3);
data6 = T6(:,2);
data7 = T7(:,2);
data8 = T8(2:2:end,3);
data9 = T9(2:2:end,3);
data11 = T11(2:2:end,3);

teorico_x = [1e3 1e4 1e5 1e6];
teorico_y = [-62.62 -90.34 -117.60 -141.67];

figure, hold on
plot(f,data1,'LineWidth', 1.5)
plot(f,data2,'LineWidth', 1.5)
% plot(f,data3,'LineWidth', 1.5)
% plot(f,data4,'LineWidth', 1.5)
% plot(f,data5,'LineWidth', 1.5)
plot(f,data6,'LineWidth', 1.5)
plot(f,data7,'LineWidth', 1.5)
plot(f,data8,'LineWidth', 1.5)
plot(f,data9,'LineWidth', 1.5)
plot(f,data11,'LineWidth', 1.5)
plot(manuf(:,1), manuf(:,2), '-', 'LineWidth', 1.5)
% plot(teorico_x, teorico_y, '-d', 'MarkerFaceColor', 'c','LineWidth', 1.5)
xlabel('Frecuencia [Hz]'), ylabel('Ruido de fase [dBc]')


%% Calculo teorico degradacion suponiendo el ruido del regulador ADP7142
% https://www.analog.com/en/analog-dialogue/articles/power-management-design-for-plls.html
Kv = 16e6; %Pushing del VCO V600ME10-LF
N =   [200e-9   80e-9   40e-9   30e-9   5e-9];
fos = [100      1e3     10e3    100e3   1e6];
L = 20*log10(N*Kv/sqrt(2)./fos);
% plot(fos,L,'-o','LineWidth', 1.5)
result = 10*log10(10.^(teorico_y/10)+10.^(L(2:end)/10));
% plot(teorico_x,result,'-','LineWidth', 1.5)
%% Calculo de la degradacion por el ruido en el tuning del VCO
R1 = 1.1e3;
R2 = 5.1e3;
Rs = 22;
k = 1.38e-23;
T = 293;
e1 = sqrt(4*k*T*R1)*(1+R2/R1);
e2 = sqrt(4*k*T*R2);
es = sqrt(4*k*T*Rs)*R2/R1;
en = 2.2e-9;
in = 530e-12;
E0 = sqrt((1+R2/R1)^2*en.^2+e1^2+e2^2+(in*R2).^2+es^2+(in*Rs).^2*(1+R2/R1)^2);
Kv = 108e6;
L_tuning = 20*log10(E0*Kv/sqrt(2)./teorico_x);
result_tuning = 10*log10(10.^(teorico_y/10)+10.^(L_tuning/10));
% plot(teorico_x,result_tuning,'-','LineWidth', 1.5)


l = legend('Sistema sin cambios','Alimentacion interna op amp alimentado ext',...
    'Alimentacion interna mod filtrada','Alimentación interna no opamp',...
    'Alimentado pila no opamp', 'Alimentado pila sin resistencias',...
    'Alimentacion interna tuning pila',...
    'Datasheet',...
    'Location', 'SouthWest');
set(l,'FontSize',10)
set(gca, 'XScale', 'log')
grid

