clear;
addpath(genpath('model'));
addpath(genpath('helper'));
%zestaw obietktów wykorzytsywanych do pomiarów
%d³ugoœci ramek: 10/20/30/45/60/80/100/150/200
%4 typy transmisji: nic/scram/kod/kod&scram
%1)CC (bsc p=0.02) (j=0.5) (desync = 18 albo tyle ile nakazuje norma)
%2)CC (bsc p=0.02) (j=0.8) (desync = 18 albo tyle ile nakazuje norma)
%3)CC (bsc p=0.00) (j=0.7) (desync = 18 albo tyle ile nakazuje norma)
G = SignalGenerator(50, 0.5);  %generator sygna³u 
S = Scrambler();                %scrambler
D = Descrambler();              %descrambler
Enc = Encoder();                %koder Ethernet
Dec = Decoder2();               %dekoder Ethernet
CC = CustomChannel(0.02,18,0);  %bsc = 0, desynch = 18, period=0
H = Helper();                   %obliczanie BER
%zmienne sygna³ oraz BER
sig = G.generateSignal();
BER = 0;
for i=1 : 500
    cop = sig.copy();
    %cop = S.scrambleSignal(cop);
    cop = Enc.encode(cop);
    CC.sendSig(cop);
    cop = CC.receiveSig();
    cop = Dec.decode(cop);
    %cop = D.descrambleSignal(cop);
    BER = BER + H.calculateBER(sig,cop);
    %S.resetLSFR();
    %D.resetLSFR();
end
BER = BER / 500;