close all;
clear all;
clc;

%4QAM
% Datos
Potencia_dBm1 = [-27.650 -28.150 -28.650 -29.150 -29.650 -30.150 -30.650 -31.150 -31.650 -32.150 -32.650 -33.150 -33.650 -34.150 -34.650 -35.150 -35.650 -36.150 -36.650 -37.150];
BER1 = [0 0 0 0 4.5e-6 1.3e-5 1.8e-5 4.5e-5 7.2e-5 1.26e-4 3.15e-4 6.30e-4 1.17e-3 2.04e-3 2.25e-3 2.88e-3 3.15e-3 3.60e-3 4.05e-3 4.50e-3];

% Gráfico
figure;
semilogy(Potencia_dBm1, BER1, 'o-')
xlabel('Potencia de recepción [dBm]')
ylabel('BER')
title('Potencia VS BER 4-QAM');
grid on
% Datos
Potencia_dBm1 = [-27.650 -28.150 -28.650 -29.150 -29.650 -30.150 -30.650 -31.150 -31.650 -32.150 -32.650 -33.150 -33.650 -34.150 -34.650 -35.150 -35.650 -36.150 -36.650 -37.150];
EVM1 = [6.662 7.071 7.652 8.413 9.141 10.475 11.243 12.742 14.084 15.680 17.821 20.969 22.648 25.980 28.821 32.295 36.666 42.315 49.726 59.050];

% Gráfico
figure;
semilogy(Potencia_dBm1, EVM1, 'o-')
xlabel('Potencia de recepción [dBm]')
ylabel('EVM [%]')
title('Potencia VS EVM 4-QAM');
grid on

%16-QAM
% Datos de la tabla
potencia21 = [-19.258 -20.258 -21.258 -22.258 -23.258 -24.258 -25.258 -26.258 -27.258 -28.258 -29.258 -30.258 -31.258 -32.258 -33.258];
ber2 = [2.00E-05 3.00E-05 5.00E-05 1.20E-04 3.50E-04 1.10E-03 4.50E-03 1.35E-02 3.30E-02 5.80E-02 7.10E-02 7.80E-02 8.00E-02 8.10E-02 8.20E-02];

% Gráfica de BER vs Potencia en escala semilog
figure;
semilogy(potencia21, ber2, 'o-', 'LineWidth', 2, 'MarkerFaceColor', 'b')
title('BER vs Potencia de Recepción 16-QAM')
xlabel('Potencia de Recepción (dBm)')
ylabel('BER')
grid on
% Datos de la tabla
potencia2 = [-19.258 -20.258 -21.258 -22.258 -23.258 -24.258 -25.258 -26.258 -27.258 -28.258 -29.258 -30.258 -31.258 -32.258 -33.258];
evm2 = [1.56, 2.567, 2.987, 3.543, 4.123, 5.678, 7.456, 12.345, 18.234, 32.567, 48.234, 65.432, 78.654, 89.543, 95.678];

% Gráfica de EVM vs Potencia en escala semilog
figure;
semilogy(potencia2, evm2, 'o-', 'LineWidth', 2, 'MarkerFaceColor', 'b')
title('EVM vs Potencia de Recepción 16-QAM')
xlabel('Potencia de Recepción (dBm)')
ylabel('EVM (%)')
grid on


%64-QAM


% Definimos los datos de la tabla
prx2 = [-19.258 -20.258 -21.258 -22.258 -23.258 -24.258 -25.258 -26.258 -27.258 -28.258 -29.258 -30.258 -31.258 -32.258 -33.258];
ber2 = [1.00E-05 1.50E-05 2.50E-05 6.00E-05 1.75E-04 5.50E-04 2.25E-03 6.75E-03 1.65E-02 2.90E-02 3.55E-02 3.90E-02 4.00E-02 4.05E-02 4.10E-02];
evm3 = [3.826 4.321 4.824 6.212 8.189 11.339 16.462 26.379 46.230 83.746 93.596 96.659 98.547 99.456 99.989];

% Graficamos BER vs Potencia
figure;
semilogy(prx2, ber2, 'o-');
xlabel('Potencia de Recepción [dBm]');
ylabel('BER');
title('BER vs Potencia de Recepción 64-QAM');
grid on;

% Graficamos EVM vs Potencia
figure;
semilogy(prx2, evm3, 'o-');
xlabel('Potencia de Recepción [dBm]');
ylabel('EVM [%]');
title('EVM vs Potencia de Recepción 64-QAM');
grid on;

%256-QAM

% Definir los datos de la medición
potencia4 = [-19.258, -20.258, -21.258, -22.258, -23.258, -24.258, -25.258, -26.258, -27.258, -28.258, -29.258, -30.258, -31.258, -32.258, -33.258];
ber4 = [5.00E-07, 8.00E-07, 1.50E-06, 3.00E-06, 9.00E-06, 3.20E-05, 1.15E-04, 3.45E-04, 8.50E-04, 1.60E-03, 2.20E-03, 2.70E-03, 2.90E-03, 3.00E-03, 3.10E-03];
evm4 = [2.015, 2.300, 2.650, 3.134, 4.000, 5.953, 9.052, 16.062, 34.920, 61.335, 80.231, 89.543, 93.541, 95.774, 97.229];

% Hacer el gráfico en escala semylog
figure;
hold on;
semilogy(potencia4, ber4, 'b.-');
grid on;
xlabel('Potencia de recepción [dBm]');
ylabel('BER');
title('Gráfico de Potencia vs. BER 256-QAM');
figure;
hold on;
semilogy(potencia4, evm4, 'r.-');
grid on;
xlabel('Potencia de recepción [dBm] ');
ylabel('EVM [%]');
title('Gráfico de Potencia vs. EVM 256-QAM');


