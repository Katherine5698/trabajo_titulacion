%____________________________________________________________________
%
%                    Custom Component for MATLAB
%          Automatically generated from VBS template
%
% Name         : user1_TRANSMISOR
% Author       : DOCENTE
% Cration Date : Wed Jun 01 01:15:19 2022
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
%
% - Output signals
%
% signaltx :: double vector [num_samples 1]
%   electrical signal signaltx time domain samples
%
%
%
%____________________________________________________________________

% Write MATLAB code here
save parametros.mat
close all;
clear all;
clc
setPath
gfdm = get_defaultGFDM('TTI');
gfdm.K =2^7; % 2^7 no afecta cambiar este valor
gfdm.Kset = 0:3;  % Only allocate some subcarriers (0:33)
gfdm.pulse = 'rrc_fd';
gfdm.a = 0.3;  %0:3(aumento aumenta el ancho de banda)
gfdm.Mon = 400; %(400) no afecta cambiareste valor
gfdm.mu=8; % orden de modulación 
nB =1; % Number of GFDM blocks to generate (1)
gfdm.L=0;%Number of overlapping subcarrier for frequency domain GFDM implementation..
gfdm.Kon=0;%Number of actives subcarriers. (0) (0)
gfdm.oQAM=1;
%% Generate the signals
% Currently only works without CP
%assert(~isfield(gfdm, 'Ncp') || gfdm.Ncp == 0);

% Allocate enough space for the signals
blockLen = gfdm.M*gfdm.K
% sGFDM = zeros(nB * blockLen, 1);
% sOFDM = zeros(size(sGFDM));

for b = 1:nB
    s = get_random_symbols(gfdm);
   
    save simrandomicos.txt s -ascii 
 
    A=do_qammodulate(s, gfdm.mu);
    %A= qammod(s,16);
    scatterplot(A)
%      Areal=real(A); save sim4QAMrealtx.txt Areal -ascii
%      Aimag=imag(A); save sim4QAMimagtx.txt Aimag -ascii
%     save A.mat
    D = do_map(gfdm, A);
          x = do_modulate(gfdm,D,'F');
      %sGFDM((b-1)*blockLen+(1:blockLen)) = x;
      
end
x1= x';
close all

  
x2 = x ;% señal a graficar
fs=0.75e8;% frecuencia de muestreo (1.25)
R=1;% impedancia de entrada
[Spdx,f] = psd_signal(x2,fs,R); %grafica la Power Spectrum Density (PSD)

gfdm_real=real(x);
gfdm_imag=imag(x);

%-------- Genero trama para sincronismo---------------------
xprbsr=PRBS([1 0 1 1 0 1 1 1 1],[9 8]);  % generador PRBS 7 para sincronismo
xprbsr =xprbsr * max(abs(x1));   % mas amplitud para diferenciarlos
z=zeros(90001,1)';
gfdm_r=[z 0 xprbsr gfdm_real']; 
xprbsi=PRBS([0 1 0 1 0 1 1],[7 6]);  % generador PRBS 7 para sincronismo
xprbsri =xprbsi * max(abs(x1));   % mas amplitud para diferenciarlos
gfdm_i=[0 xprbsi gfdm_imag' z]; 
 
%concatenación  real e imaginario
%amp=80;
GFDM=[gfdm_r gfdm_i];

valorsamples=1092005;
dif=valorsamples-length(GFDM);
relleno=zeros(1,dif);
GFDM=[GFDM relleno];

figure
plot(GFDM);

ylabel('Amplitud [V]');
xlabel('Tiempo [ns]');
xtickformat('%.0f');

simtx = load('simrandomicos.txt');

    save simt1.txt simtx -ascii    
    save GFDM.txt GFDM -ascii    
save ('parametros_tx.mat')
signaltx=GFDM';
%____________________________________________________________________
%
% End of file
%____________________________________________________________________
