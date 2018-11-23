pkg load signal;
pkg load communications
close all;



tmax = 30;


[smues, fmuestreo] = audioread('20181121_1339.wav');
plot(smues);

%% Graficar la señal muestreada
%figure();
%subplot(2,1,1);
%stem(tvecmues, smues);
%title("Señal muestreada a 8kHz");
%% Graficar el espectro de la señal muestreada
%subplot(2,1,2);
%stem(0:(fmuestreo-1), abs(fft(smues, fmuestreo)));
%title("Espectro señal muestreada a 8kHz");

% FILTROS ----------------------------------------------------------------------
% Primer banda 
filtro1 = fir1(80, 1/4);
% Segunda banda
filtro2 = fir1(80, [1/4 2/4]);
% Tercer banda
filtro3 = fir1(80, [2/4 3/4]);
% Cuarta banda 
filtro4 = fir1(80, 3/4,"high");

%% Graficar respuesta del filtro 1
%figure();
%freqz(filtro1);
%subplot(2,1,1); title("Filtro banda 1")
%% Graficar respuesta del filtro
%figure();
%freqz(filtro2);
%subplot(2,1,1); title("Filtro banda 2")
%% Graficar respuesta del filtro
%figure();
%freqz(filtro3);
%subplot(2,1,1); title("Filtro banda 3")
%% Graficar respuesta del filtro
%figure();
%freqz(filtro4);
%subplot(2,1,1); title("Filtro banda 4")

% APLICANDO LOS FILTROS --------------------------------------------------------
% Primer banda
smues1f = filter(filtro1, 1, smues); 
% Segunda banda 
smues2f = filter(filtro2, 1, smues);
% Tercer banda
smues3f = filter(filtro3, 1, smues);
% Cuarta banda
smues4f = filter(filtro4, 1, smues);

%% Graficar la señal filtrada 1
%figure();
%subplot(2,1,1);
%stem(tvecmues, smues1f);
%title("Señal filtrada 1");
%% Graficar el espectro de la señal filtrada 1
%% Descartar las primeras muestras, pues tiene la transición del filtro
%subplot(2,1,2);
%stem(0:(fmuestreo-1), abs(fft(smues1f(61:length(smues)), fmuestreo)));
%axis([0 90 0 600]);
%title("Espectro señal banda1 filtrada 1")
%
%% Graficar la señal filtrada 2
%figure();
%subplot(2,1,1);
%stem(tvecmues, smues2f);
%title("Señal filtrada 2");
%% Graficar el espectro de la señal filtrada 1
%% Descartar las primeras muestras, pues tiene la transición del filtro
%subplot(2,1,2);
%stem(0:(fmuestreo-1), abs(fft(smues2f(61:length(smues)), fmuestreo)));
%axis([0 90 0 600]);
%title("Espectro señal banda1 filtrada 2")
%
%% Graficar la señal filtrada 3
%figure();
%subplot(2,1,1);
%stem(tvecmues, smues3f);
%title("Señal filtrada 3");
%% Graficar el espectro de la señal filtrada 1
%% Descartar las primeras muestras, pues tiene la transición del filtro
%subplot(2,1,2);
%stem(0:(fmuestreo-1), abs(fft(smues3f(61:length(smues)), fmuestreo)));
%axis([0 90 0 600]);
%title("Espectro señal banda1 filtrada 3")
%
%% Graficar la señal filtrada 4
%figure();
%subplot(2,1,1);
%stem(tvecmues, smues4f);
%title("Señal filtrada 4");
%% Graficar el espectro de la señal filtrada 1
%% Descartar las primeras muestras, pues tiene la transición del filtro
%subplot(2,1,2);
%stem(0:(fmuestreo-1), abs(fft(smues4f(61:length(smues)), fmuestreo)));
%axis([0 90 0 600]);
%title("Espectro señal banda1 filtrada 4")

% ********** DECIMADO **********------------------------------------------------
factDecimado = 3;

smues1 = downsample(smues1f,factDecimado);
smues2 = downsample(smues2f,factDecimado);
smues3 = downsample(smues3f,factDecimado);
smues4 = downsample(smues4f,factDecimado);

fmuestreoD = fmuestreo/factDecimado;
tmuestreoD = 1/fmuestreoD;
tvecmuesD = 0:tmuestreoD:(tmax-tmuestreoD);
%% Graficar la señal decimada 1
%figure();
%stem(tvecmuesD, smues1);
%% Graficar el espectro de la señal decimada 1
%% Descartar las primeras muestras, pues tiene la transición del filtro
%figure();
%stem(0:(fmuestreoD-1), abs(fft(smues1(21:length(smues1)), fmuestreoD)));
%axis([0 30 0 600]);
%title("Espectro señal banda1 decimada 1")
%
%% Graficar la señal decimada 2
%figure();
%stem(tvecmuesD, smues2);
%% Graficar el espectro de la señal decimada 2
%% Descartar las primeras muestras, pues tiene la transición del filtro
%figure();
%stem(0:(fmuestreoD-1), abs(fft(smues2(21:length(smues2)), fmuestreoD)));
%axis([0 30 0 600]);
%title("Espectro señal banda1 decimada 2")
%
%% Graficar la señal decimada 3
%figure();
%stem(tvecmuesD, smues3);
%% Graficar el espectro de la señal decimada 3
%% Descartar las primeras muestras, pues tiene la transición del filtro
%figure();
%stem(0:(fmuestreoD-1), abs(fft(smues3(21:length(smues3)), fmuestreoD)));
%axis([0 30 0 600]);
%title("Espectro señal banda1 decimada 3")
%
%% Graficar la señal decimada 4
%figure();
%stem(tvecmuesD, smues4);
%% Graficar el espectro de la señal decimada 4
%% Descartar las primeras muestras, pues tiene la transición del filtro
%figure();
%stem(0:(fmuestreoD-1), abs(fft(smues4(21:length(smues4)), fmuestreoD)));
%axis([0 30 0 600]);
%title("Espectro señal banda1 decimada 4")

% COMPANDING -------------------------------------------------------------------

Mu = 128;
% Primer banda
v1 = max(smues1);
smues1c = compand(smues1,Mu,v1);
% Segunda banda
v2 = max(smues2);
smues2c = compand(smues2,Mu,v2);
% Tercer banda
v3 = max(smues3);
smues3c = compand(smues3,Mu,v3);
% Cuarta banda
v4 = max(smues4);
smues4c = compand(smues4,Mu,v4);


%Seccion de receptor, esto luego se separa en un codigo aparte

smues4=compand(smues4c,Mu,v4,'mu/expander');
smues3=compand(smues3c,Mu,v3,'mu/expander');
smues2=compand(smues2c,Mu,v2,'mu/expander');
smues1=compand(smues1c,Mu,v1,'mu/expander');


smues1f=interp(smues1,3);
smues2f=interp(smues2,3);
smues3f=interp(smues3,3);
smues4f=interp(smues4,3);


smues1f=filter(filtro1,1,smues1f);
smues2f=filter(filtro2,1,smues2f);
smues3f=filter(filtro3,1,smues3f);
smues4f=filter(filtro4,1,smues4f);

smues_final=smues1f+smues2f+smues3f+smues4f;
audiowrite('20181121_1339_reconstruido.wav',smues_final,fmuestreo);

