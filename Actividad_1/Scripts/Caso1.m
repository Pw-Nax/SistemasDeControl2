% Sistemas de Control II -FCEFyN-UNC 
% Profesor: Dr. Ing. Pucheta, Julian
% Alumno: Cabero , Mauro Ezequiel
% Actividad Práctica N1 - Caso de estudio 1 
%   ITEM 1  
%   Asignar valores a R=220ohm, L=500mHy, y C=2,2 uF. Obtener simulaciones que permitan 
%   estudiar la dinámica del sistema, con una entrada de tensión escalón de 12V, que cada 
%   10ms cambia de signo.
%   
%%

clear all; clc; close all;

%Sistema de dos variables de estado
R = 220 ; L = 500e-3; C = 2.2e-6 ;                 %Parametros del circuito RLC
e_i = 12;                                          %Tension aplicada a la entrada


%*[xp] = A*[x] + B*[u]
% [y] = C*[x] + D*[u]
% *%

A  = [0 1/C ; -1/L -R/L];                           %Matriz de Estados
B  = [0 1/L]';                                      %Matriz de entrada a Estado 
C1 = [0 R] ;                                        %Matriz de estado a Salida (VR)
C2 = [1 0] ;                                        %Matriz de estado a Salida (VC)
C3 = [0 1] ;                                        %Matriz de estado a Salida (I)
D  = 0     ;                                        %Matriz de transmisión directa



%---------------------------------Condiciones iniciales---------------------------------%

%Uso de la función "ss" para definir el sistema en espacio de estados
%[A,B,C,D] = ssdata(Sys)                            %Extraer datos del sistema

x0 = [0 0]';                                        %Condiciónes iniciales
Sys_1 = ss(A,B,C1,D);                                %Sistema (Salida VR)
Sys_2 = ss(A,B,C2,D);                                %Sistema (Salida VC)
Sys_3 = ss(A,B,C3,D);                                %Sistema (Salida I)

%Simulación Del Sistema
% Se define la entrada como un escalón de 12V que cambia de signo cada 10ms
% Se define el tiempo de simulación y la señal de entrada


Ti = 10e-3;                                         %Período de la señal de entrada
N = 5;                                              %Número de períodos a graficar
t = 0:Ti/3000:Ti*N;                                 %Vector tiempo
u = e_i*square(2*pi/Ti*(t));                        %Señal Cuadrada con período 10mS


%--------------------------------Simulación del sistema----------------------------------%
% Se simula el sistema con la función lsim, que permite simular sistemas
% continuos y discretos, en este caso se simula el sistema en espacio de estados
% con la entrada u(t) y el tiempo t.
% Se grafican las salidas del sistema y la entrada u(t)

subplot(4,1,1)
lsim(Sys_1, u, t);
title('Resistencia')
xlabel('Tiempo [s]');
ylabel('Tensión [V]');
ylim([-30 30])

subplot(4,1,2)
lsim(Sys_2, u, t);
title('Capacitor')
xlabel('Tiempo');
ylim([-20 20])
ylabel('Tensión [V]');

subplot(4,1,3)
lsim(Sys_3, u, t);
title('Corriente')
xlabel('Tiempo');
ylim([-0.8 0.8])
ylabel('Corriente [A]');

subplot(4,1,4)
plot(t, u);
title('Entrada u(t)')
xlabel('Tiempo');
ylim([-13 13])
ylabel('Tensión [V]');
