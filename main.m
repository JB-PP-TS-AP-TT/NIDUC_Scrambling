clear;
%dodanie œcie¿ek do folderów, klasy w nich widoczne s¹ osi¹galne
addpath(genpath('view'));
addpath(genpath('model'));
addpath(genpath('helper'));

%odpalenie gï¿½ï¿½wnego widoku aplikacji - czyli wywolanie funkcji
%zdefiniowanej w glownyWidok.m, ktï¿½ra z kolei odpala figure
%glownyWidok.fig, stworzonï¿½ przy pomocy GUIDE (lewym na glownyWidok.fig i
%edytuj w GUIDE)
%mainView();

%UWAGA: zakomentowa³em wyœwietlanie sygna³y, gdy¿ chcia³em skupiæ siê tylko
%na BER i rozmiarze sygna³y cop po procesie resynchronizacji

%LSFR musi miec d³ugoœæ conajmniej 39 bitów!!!
%LSFR = [0, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0, 0, 1];
G = SignalGenerator(4, 0);
S = Scrambler();
D = Descrambler();
Enc = Encoder();
Dec = Decoder2();
CC = CustomChannel(0.02,0,0);%bsc = 0.02, desynch = 21, period=0
H = Helper();

fprintf("BEFORE ALL:\n");
sig = G.generateSignal();
sig.printSignal();

%fprintf("COPIED:\n");
cop = sig.copy();
%cop.printSignal();

%fprintf("SCRAMBLED:\n");
cop = S.scrambleSignal(cop);
%cop.printSignal();

%fprintf("ENCODED:\n");
cop = Enc.encode(cop);
%cop.printSignal();

%cop.setBitTrue(67); %preambula 11

%CUSTOM CHANNEL
CC.sendSig(cop);
cop = CC.receiveSig();

%fprintf("DECODED:\n");
cop = Dec.decode(cop);
%cop.printSignal();

fprintf("AFTER ALL:\n");
cop = D.descrambleSignal(cop);
cop.printSignal();

fprintf("BER: %f\n", H.calculateBER(sig,cop));

%mo¿na zaobserwowaæ stratê bitów
sizeOrigin = sig.getSize();
sizeCopy = cop.getSize();