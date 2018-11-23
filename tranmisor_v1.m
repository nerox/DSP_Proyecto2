pkg load signal;
pkg load communications
close all;


% SEÑAL DE PRUEBA --------------------------------------------------------------
fsenal = [555, 1111, 1666, 2221, 2776, 3331, 3886, 4441, 5000];
% Usar diferentes amplitudes para reconocer cada frecuencia
asenal = [6, 8, 7, 2, 4, 3, 10, 12, 11];
% La secuencia se genera durante 13 segundos
tmax = 30;

% Generar una versión sobremuestreada para representar la señal continua
tveccont = 0:0.00001:tmax;
scont = zeros(1, length(tveccont));
for (fi = 1:9)
  scont = scont + asenal(fi)*cos(2*pi*fsenal(fi).*tveccont);
end

% Graficar la señal de prueba
%figure();
%subplot(2,1,1);
%plot(tveccont, scont);
%title("Señal de prueba");
%
%% Graficar el espectro de la señal de prueba
%subplot(2,1,2);
%stem(abs(fft(scont)));
%title("Espectro señal prueba");

% SEÑAL MUESTREADA -------------------------------------------------------------
% General una señal muestreada tasa de 8kHz
fmuestreo = 8000;
tmuestreo = 1/fmuestreo;
tvecmues = 0:tmuestreo:(tmax-tmuestreo);
smues = zeros(1, length(tvecmues));
for (fi = 1:9)
  smues = smues + asenal(fi)*cos(2*pi*fsenal(fi).*tvecmues);
end

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

j=1;
% Primer banda
for (i=1:3:length(smues1f))
  smues1(j) = smues1f(i);
  j = j+1;
end
% Segunda banda
for (i=1:3:length(smues2f))
  smues2(j) = smues2f(i);
  j = j+1;
end
% Tercer banda
for (i=1:3:length(smues3f))
  smues3(j) = smues3f(i);
  j = j+1;
end
% Cuarta banda
for (i=1:3:length(smues4f))
  smues4(j) = smues4f(i);
  j = j+1;
end
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
v = max(smues1);
smues1c = compand(smues1,Mu,v);
% Segunda banda
v = max(smues2);
smues2c = compand(smues2,Mu,v);
% Tercer banda
v = max(smues3);
smues3c = compand(smues3,Mu,v);
% Cuarta banda
v = max(smues4);
smues4c = compand(smues4,Mu,v);


