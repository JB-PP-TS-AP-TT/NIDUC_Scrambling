clear;
%dodanie �cie�ek do folder�w, klasy w nich widoczne s� osi�galne
addpath(genpath('view'));
addpath(genpath('model'));
addpath(genpath('helper'));

%odpalenie g��wnego widoku aplikacji - czyli wywolanie funkcji
%zdefiniowanej w glownyWidok.m, kt�ra z kolei odpala figure
%glownyWidok.fig, stworzon� przy pomocy GUIDE (lewym na glownyWidok.fig i
%edytuj w GUIDE)
mainView();

%LSFR musi miec d�ugo�� conajmniej 39 bit�w!!!
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
 
