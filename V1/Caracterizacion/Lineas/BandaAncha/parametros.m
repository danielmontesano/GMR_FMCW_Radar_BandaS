close all; clear all;

%%
pista_lna = sparameters('pista_lna.s2p');
figure;
rfplot(pista_lna,1,1)
hold on;
rfplot(pista_lna,2,1)
title('Parametros S de pista corta')
saveas(gcf,'parametros_pista_corta','fig');
saveas(gcf,'parametros_pista_corta','png');
figure;
smithplot(pista_lna,1,1)
hold on;
smithplot(pista_lna,2,2)
title('Parametros S de pista corta')
saveas(gcf,'smith_pista_corta','fig');
saveas(gcf,'smith_pista_corta','png');

%%
pista_if = sparameters('pista_if.s2p');
figure;
rfplot(pista_if,1,1)
hold on;
rfplot(pista_if,2,1)
title('Parametros S de pista larga')
saveas(gcf,'parametros_pista_larga','fig');
saveas(gcf,'parametros_pista_larga','png');
figure;
hold on;
smithplot(pista_if,1,1)
hold on;
smithplot(pista_if,2,2)
title('Parametros S de pista larga')
saveas(gcf,'smith_pista_larga','fig');
saveas(gcf,'smith_pista_larga','png');

%%
pa_solo = sparameters('pa_directa.s2p');
figure;
rfplot(pa_solo)
title('Parametros S de PA')
saveas(gcf,'parametros_pa_directa','fig');
saveas(gcf,'parametros_pa_directa','png');
figure;
hold on;
smithplot(pa_solo,1,1)
hold on;
smithplot(pa_solo,2,2)
title('Parametros S de PA')
saveas(gcf,'smith_pa_directa','fig');
saveas(gcf,'smith_pa_directa','png');

%%
cp_thru = sparameters('pa_directa.s2p');
figure;
rfplot(cp_thru)
title('Parametros S de salida acoplada')
saveas(gcf,'parametros_pa_directa','fig');
saveas(gcf,'parametros_pa_directa','png');
figure;
smithplot(cp_thru,1,1)
hold on;
smithplot(cp_thru,2,2)
title('Parametros S de salida acoplada')
saveas(gcf,'smith_pa_directa','fig');
saveas(gcf,'smith_pa_directa','png');

%%
cp_cp = sparameters('pa_modificado.s2p');
figure;
rfplot(cp_cp)
title('Parametros S pa modificado')
saveas(gcf,'parametros_pa_modificado','fig');
saveas(gcf,'parametros_pa_modificado','png');
figure;
hold on;
smithplot(cp_cp,1,1)
hold on;
smithplot(cp_cp,2,2)
title('Parametros S pa modificado')
saveas(gcf,'smith_pa_modificado','fig');
saveas(gcf,'smith_pa_modificado','png');