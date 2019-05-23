close all; clc; clear all;
sinL = sparameters('paSinAcopSinL.s2p');
conL = sparameters('paConAcopConL.s2p');
figure
rfplot(sinL, '-+')
% title('Sin bobina y sin acoplador')
hold on;
rfplot(conL, '-*')
% title('Con bobina y Con acoplador')


s22_hpa = abs(rfparam(sinL,2,2));
s21_cp = (10^(-20/10))*ones(length(s22_hpa),1);
s12_cp = (10^(-20/10))*ones(length(s22_hpa),1);
s22_cp = (10^(-30/10))*ones(length(s22_hpa),1);


s22tot = s22_cp + (s21_cp.*s12_cp.*s22_hpa)./(1-s22_cp);%.*s22_hpa);
figure;
plot(sinL.Frequencies,10*log10(s22tot))
