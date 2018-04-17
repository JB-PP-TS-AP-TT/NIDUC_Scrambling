clear;
%dodanie œcie¿ek do folderów, klasy w nich widoczne s¹ osi¹galne
addpath(genpath('view'));
addpath(genpath('model'));
addpath(genpath('helper'));

%odpalenie gï¿½ï¿½wnego widoku aplikacji - czyli wywolanie funkcji
%zdefiniowanej w glownyWidok.m, ktï¿½ra z kolei odpala figure
%glownyWidok.fig, stworzonï¿½ przy pomocy GUIDE (lewym na glownyWidok.fig i
%edytuj w GUIDE)
mainView();

%LSFR musi miec d³ugoœæ conajmniej 39 bitów!!!
%LSFR = [0, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0, 0, 1];
G = SignalGenerator(1, 0);
S = Scrambler();
D = Descrambler();
Enc = Encoder();
Dec = Decoder2();
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

%fprintf("DECODED:\n");
cop = Dec.decode(cop);
%cop.printSignal();

fprintf("AFTER ALL:\n");
cop = D.descrambleSignal(cop);
cop.printSignal();

fprintf("BER: %d\n", H.calculateBER(sig,cop));
 
