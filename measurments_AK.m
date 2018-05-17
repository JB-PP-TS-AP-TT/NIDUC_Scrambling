clear;
addpath(genpath('model'));
addpath(genpath('helper'));
%zestaw obietktów wykorzytsywanych do pomiarów
%d³ugoœci ramek: 10/20/30/45/60/80/100/150/200
ramki=[10,20,30,45,60,80,100,150,200];
p=[0.01, 0.01,0.03,0.03];
j=[0.25, 0.75,0.2,0.7];
%4 typy transmisji: nic/scram/kod/kod&scram
%1)CC (bsc p=0.02) (j=0.5) (desync = 18 albo tyle ile nakazuje norma)
%2)CC (bsc p=0.02) (j=0.8) (desync = 18 albo tyle ile nakazuje norma)
%3)CC (bsc p=0.00) (j=0.7) (desync = 18 albo tyle ile nakazuje norma)

S = Scrambler();                %scrambler
D = Descrambler();              %descrambler
Enc = Encoder();                %koder Ethernet
Dec = Decoder2();               %dekoder Ethernet
  
H = Helper();                   %obliczanie BER

for z=1:4
BSC = BSChannel(p(z));
for k=1:numel(ramki)
BER = 0;
ramka=ramki(k);
G = SignalGenerator(ramka, j(z));  %generator sygna³u 
sig = G.generateSignal();
for i=1 : 500
    cop = sig.copy();
    cop = S.scrambleSignal(cop);
    cop = Enc.encode(cop);
    BSC.sendSig(cop);
    cop = BSC.receiveSig();
    cop = Dec.decode(cop);
    cop = D.descrambleSignal(cop);
    BER = BER + H.calculateBER(sig,cop);
    S.resetLSFR();
    D.resetLSFR();
end
BER = BER / 500;
fprintf('p: %d, j: %d, ilosc ramek: %d, BER: %d \n', p(z),j(z), ramka, BER);
end
end