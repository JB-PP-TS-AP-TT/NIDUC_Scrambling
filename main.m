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

%LSFR musi miec d³ugoœæ conajmniej 39 bitów!!!
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


