% close all
% ant = sparameters('DIPOLO_DOBLADO.s1p');
ant = sparameters('circular_patch.s1p');
n = size(ant.Parameters,3);
param = zeros(1,n);
for i=1:n
    param(i) = ant.Parameters(1,1,i);
end
plot(ant.Frequencies, 20*log10(abs(param)))
grid on
xlabel('Frequency')
ylabel('S11 [db]')
xlabel('Frequency [GHz]')
hold on