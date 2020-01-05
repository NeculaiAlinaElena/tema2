close all
clear all
clc

D=18;% durata semnalului
P=4*18;%perioada semnalului
f=1/P;%frecventa semnalului
w=2*pi*f;%pulsatia semnalului
rez=0.1; %rezolutia temporara de 0.1 s este suficienta pentru a reprezenta forma semnalului dorit. 
t=0:rez:2*P;% voi folosi 2 perioade din semnal

x=(sawtooth(w*t,0.5)+abs(sawtooth(w*t,0.5)))/2;
%semnal triunghiular redresat monoalternanta

N=50;%numarul de coeficienti
C = zeros(1,2*N+1);
%initializare a vectorului de coeficienti cu 0.

for n = -N:N
    C(n+N+1) = 1/P * integral(@(t)(1/2*sawtooth(w*t,0.5)+1/2*abs(sawtooth(w*t,0.5))).*exp(-1j*n*w*t),0,P);
    %Determinarea coeficientilor dezvoltarii, semnalului x(t), în serie Fourier Complexa 
end

%reconstruirea semnalului folosind N coeficienti ai seriei Fourier 
x_rec = 0;
for n = -N:N
    x_rec = x_rec +C(n+N+1)*exp(1j*n*w*t) ;
end

figure(1);
hold on
plot(t,x,'.k');%reprezentarea semnalului initial cu puncte negre  
plot(t,real(x_rec),'r');%reprezentarea semnalului reconstruit cu culoarea rosie cu linie continua
axis([-1 150 -0.2 1.2])
xlabel('Timpul [s]');
ylabel('Amplitudine');
title('Suprapunerea semnalelor x(t) si x rec(t)')
hold off

figure(2);
hold on
stem((-N:N)*w,2*abs(C));
%stem-functie pentru reprezentarea valorilor discrete
plot((-N:N)*w,2*abs(C),':r')
xlabel('Pulsatia [rad/s]');
ylabel('Ak');
axis([-5 5 -0.05 0.55])
title('Spectrul de Amplitudini');
hold off

%Transformata Fourier este o opera?ie care se aplica unei functii complexe si produce o alta functie complexa care contine aceeasi informatie ca functia 
%originala, dar reorganizata dupa frecventele componente. 
%In cazul nostru functia initiala este un semnal dependent de timp, iar transformata sa Fourier descompune semnalul dupa frecventa si produce un spectru 
%al acestuia. Acest lucru este posibil daca semnalul periodic satisface conditiile lui Dirichlet.

%In spectrul de amplitudini al semnalului putem observa reprezentarea grafica a amplitudinilor armonicilor in functie de pulsatie. 
%Asa  cum  se  poate  observa  si  în  figura  2,  spectrul  de  amplitudine  al  unui  semnal  periodic  este  un  spectru discret,  ce  contine: 
%-componenta continua, situata în origine;
%-armonica    fundamentala,    situata    la    frecventa fundamentala, f0; 
%-armonicile   de   rang   superior,   situate   la   frecvente reprezentând multipli ai frecventei fundamentale, nf0.

%Deoarece am avut un numar suficient de mare de puncte pentru care sa calculam coeficientii seriei Fourier complexa, semnalul reconstruit pastreaza forma 
%semnalului initial,acest aspect se poate observa in figura 1.

