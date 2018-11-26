pkg load signal;
pkg load communications
close all;

function [output_signal,max_val_band,offset]=Cuantify(input_signal,bits)
  disp(mean(input_signal));
  offset= min(input_signal);
  signal=abs(offset).+input_signal;
  max_val_band=max(signal);
  output_signal=round(signal./max_val_band*(bits^2-1));
  %figure();
  %plot(output_signal);  
  output_signal=round(output_signal);
end

function output_signal=De_Cuantify(input_signal,bits,offset,max_val_band)
  output_signal=input_signal./(bits^2-1)*max_val_band; 
  output_signal=output_signal.+offset;  
end


tmax = 30;


[smues, fmuestreo] = audioread('20181121_1339.wav');
%plot(smues);

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
factDecimado = 4;

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

% CUANTIFY  -------------------------------------------------------------------
band1_bits=4;
band2_bits=12;
band3_bits=12;
band4_bits=4;
total_bits=band1_bits+band2_bits+band3_bits+band4_bits;
[output_signal_band1,max_val_band1,offset_band1]=Cuantify(smues1c,band1_bits);
[output_signal_band2,max_val_band2,offset_band2]=Cuantify(smues2c,band2_bits);
[output_signal_band3,max_val_band3,offset_band3]=Cuantify(smues3c,band3_bits);
[output_signal_band4,max_val_band4,offset_band4]=Cuantify(smues4c,band4_bits);

band1_bin=dec2bin(output_signal_band1,band1_bits);
band2_bin=dec2bin(output_signal_band2,band2_bits);
band3_bin=dec2bin(output_signal_band3,band3_bits);
band4_bin=dec2bin(output_signal_band4,band4_bits);


%Sava data in compressed file --------------------------------------------------------
filename = 'compressed_file.bin';

output_container=strcat(band1_bin,band2_bin,band3_bin,band4_bin);
output_container_dec=uint32(base2dec(output_container,2));
dimension=length(output_container_dec);
fileID = fopen(filename,'w');
fwrite(fileID,output_container_dec,'uint32');
fclose(fileID);

% End of trnasmitter module -------------------------------------------------------------------


% Start of receptor module -------------------------------------------------------------------

%Read data in compressed file -------------------------------------------------------------------
fileID = fopen('compressed_file.bin');

input_container_dec = fread(fileID,[dimension 1],'uint32'); 
fclose(fileID);
input_container=dec2bin(input_container_dec);
band1_bin= substr(input_container,1,band1_bits);
band2_bin= substr(input_container,band1_bits+1,band2_bits);
band3_bin= substr(input_container,band1_bits+band2_bits+1,band3_bits);
band4_bin= substr(input_container,band1_bits+band2_bits+band3_bits+1,band4_bits);

input_signal_band1=bin2dec(band1_bin);
input_signal_band2=bin2dec(band2_bin);
input_signal_band3=bin2dec(band3_bin);
input_signal_band4=bin2dec(band4_bin);


smues1c=De_Cuantify(input_signal_band1,band1_bits,offset_band1,max_val_band1);
smues2c=De_Cuantify(input_signal_band2,band2_bits,offset_band2,max_val_band2);
smues3c=De_Cuantify(input_signal_band3,band3_bits,offset_band3,max_val_band3);
smues4c=De_Cuantify(input_signal_band4,band4_bits,offset_band4,max_val_band4);

% Expanding -------------------------------------------------------------------

%Seccion de receptor, esto luego se separa en un codigo aparte

smues4=compand(smues4c,Mu,v4,'mu/expander');
smues3=compand(smues3c,Mu,v3,'mu/expander');
smues2=compand(smues2c,Mu,v2,'mu/expander');
smues1=compand(smues1c,Mu,v1,'mu/expander');

% Interpolation -------------------------------------------------------------------


smues1f=interp(smues1,factDecimado);
smues2f=interp(smues2,factDecimado);
smues3f=interp(smues3,factDecimado);
smues4f=interp(smues4,factDecimado);

% Filtering -------------------------------------------------------------------

smues1f=filter(filtro1,1,smues1f);
smues2f=filter(filtro2,1,smues2f);
smues3f=filter(filtro3,1,smues3f);
smues4f=filter(filtro4,1,smues4f);

smues_final=smues1f+smues2f+smues3f+smues4f;
%figure();
%plot(smues_final);
audiowrite('20181121_1339_reconstruido.wav',smues_final,fmuestreo);

