%____________________________________________________________________
%
%                    Custom Component for MATLAB
%          Automatically generated from VBS template
%
% Name         : user1_RXT
% Author       : DOCENTE
% Cration Date : Mon Dec 19 20:57:57 2022
%
%____________________________________________________________________
%
%                  MATLAB base workspace variables
%
% - Simulation parameters
%
% sim_technique ::= 'VBS'
%   current simulation technique ('SPT'|'VBSp'|'VBS')
%
% runs :: double vector [runs_num 1]
%   run(s) of the current CCM instance execution
%
% lower_frequency :: double number
%   VBS lower bandwidth frequency expressed in THz
%
% center_frequency :: double number
%   VBS center bandwidth frequency expressed in THz
%
% upper_frequency :: double number
%   VBS upper bandwidth frequency expressed in THz
%
% is_opt_noise :: double number
%   flag indicating if the optical noise is simulated
%
% is_elt_noise :: double number
%   flag indicating if the electrical noise is simulated
%
% polarization_mode :: double number
%   polarization representation of the optical field
%   (1 = signal, 2 = double)
%
% start_valid_samples :: double number
%   instant when a measurement component should start measuring
%   expressed in ps
%
% stop_valid_samples :: double number
%   instant when a measurement component should stop measuring
%   expressed in ps
%
% delt_ps :: double number
%   time sampling step expressed in ps
%
% num_samples :: double number
%   number of signal samples in time domain
%
% time :: double vector [num_samples 1]
%   time sample values expressed in ps
%
% - Input signals
%
% RX5G :: double vector [num_samples 1]
%   electrical signal RX5G time domain samples
%
%
%
%
%____________________________________________________________________

% Write MATLAB code here

close all;
clc;

gfdm = get_defaultGFDM('TTI');
gfdm.K = 2^7;
gfdm.Kset = 0:15;  % Only allocate some subcarriers
gfdm.pulse = 'rrc_fd';
gfdm.a = 0.3;
gfdm.Mon =400;
gfdm.mu=8; %4QAM
nB = 1; % Number of GFDM blocks to generate
gfdm.L=0;%Number of overlapping subcarrier for frequency domain GFDM implementation..
gfdm.Kon=0;%Number of actives subcarriers.
gfdm.oQAM=1;


%% Generate the signals
% Currently only works without CP
%assert(~isfield(gfdm, 'Ncp') || gfdm.Ncp == 0);

% Allocate enough space for the signals
blockLen = gfdm.M*gfdm.K
fs=1.25e9;% frecuencia de muestreo
R=1;% impedancia de entrada

data= RX5G; %señal recibida por despues de que pasa por el canal


%{

%}
figure 
plot (data);
title('SEÑAL GFDM RECEPTOR');
xlabel('Frecuencia [GHZ]');
ylabel('Amplitud [V]');

%indices = find(data==0);
%data(indices) = [];
% data=in_data;
% % %sincrononización señal-markers
ref_signal=zeros(length(data),1);  
xprbsr=PRBS([1 0 1 1 0 1 1 1 1],[9 8]);  % generador PRBS 7 para sincronismo
sync1=[0 xprbsr]; 
ref_signal(1:length(sync1)) = sync1';
rect_rx_data= data- mean(data);
%Retiro de la componente DC
Y1 = fft(rect_rx_data);
Y2 = fft(ref_signal);
Y = ifft(Y1.*conj(Y2));
[max1, nmax1] = max(abs(Y(1:(length(Y)/2))));
rx_data_sync = circshift(data, [-nmax1+1 0]);

%Quitar el relleno 
data_gfdm=rx_data_sync(1:103296);
data_re=data_gfdm(1:51840);
data_im=data_gfdm(length(data_re)+1:length(data_gfdm));

rx_data1=data_re;
rx_data2=data_im;

%sincrononización real
xprbs=PRBS([1 0 1 1 0 1 1 1 1],[9 8]);  % generador PRBS 9 para sincronismo
sync1=[0 xprbs];             % generacion de la trama de sincronizacion[0+PBRS]
data_gfdm_real= rx_data1(length(sync1)+1:length(rx_data1));% 
 
% %sincrononización imaginaria
xprbsi=PRBS([0 1 0 1 0 1 1],[7 6]);  % generador PRBS 7 para sincronismo
sync12=[0 xprbsi];             % generacion de la trama de sincronizacion[0+PBRS]
data_gfdm_imag= rx_data2 (length(sync12)+1:length(rx_data2 ));% 
%  
% 
rx_data_gfdm=data_gfdm_real+data_gfdm_imag*1i;
xch=rx_data_gfdm;

%%QAM Diagrama de constelacion 
%sps = 256;%constDiagram = comm.ConstellationDiagram('SamplesPerSymbol',sps, ...
%    'SymbolsToDisplaySource','Property','SymbolsToDisplay',100);

in=do_demodulate(gfdm,xch);   %demodulacion 
dhat = do_unmap(gfdm,in);      % demapeo

scatterplot( dhat) %diagrama de constelacion
%constDiagram(dhat)
%constDiagram.ShowReferenceConstellation = false;  % para quietar la referencias del diagrama 

sh1 = do_qamdemodulate(dhat, gfdm.mu);

%%Potencia

x2=xch;% señal a graficar
fs=1.25e9;%{ frecuencia de muestreo 1.25 // se cambio a 5 para tener 6 Ghz
R=1;% impedancia de entrada
figure
[Spdx,f] = psd_signal(x2,fs,R); %grafica la Power Spectrum Density (PSD)


  save simrx1.txt sh1 -ascii 
save('parametros_Rx.mat')%Registro del workspace




%____________________________________________________________________
%
% End of file
%____________________________________________________________________
