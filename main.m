clear;
%dodanie �cie�ek do folder�w, klasy w nich widoczne s� osi�galne
addpath(genpath('view'));
addpath(genpath('model'));
addpath(genpath('helper'));

%odpalenie g��wnego widoku aplikacji - czyli wywolanie funkcji
%zdefiniowanej w glownyWidok.m, kt�ra z kolei odpala figure
%glownyWidok.fig, stworzon� przy pomocy GUIDE (lewym na glownyWidok.fig i
%edytuj w GUIDE)
%mainView();

%LSFR musi miec d�ugo�� conajmniej 39 bit�w!!!
%LSFR = [0, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0, 0, 1];
G = SignalGenerator(1, 0);
S = Scrambler();
D = Descrambler();

sig = G.generateSignal();

sig.printSignal();
cop = sig.copy();
cop.printSignal();
cop = S.scrambleSignal(cop);
cop.printSignal();
cop = D.descrambleSignal(cop);
cop.printSignal();

copstr = cop.toString();
fprintf("%s", copstr);


