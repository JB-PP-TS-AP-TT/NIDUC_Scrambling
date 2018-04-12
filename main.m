clear;
%dzi�ki temu skrypty z widoki/ s� widoczne
addpath(genpath('view'));
addpath(genpath('model'));

%odpalenie g��wnego widoku aplikacji - czyli wywolanie funkcji
%zdefiniowanej w glownyWidok.m, kt�ra z kolei odpala figure
%glownyWidok.fig, stworzon� przy pomocy GUIDE (lewym na glownyWidok.fig i
%edytuj w GUIDE)
%mainView();

LSFR = [0, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0, 0, 1];

sig_1 = Signal(16);                         %sygna� nr 1 - 16b
sig_1.setBitTrue(1);
sig_1.setBitTrue(3);
sig_1.setBitTrue(16);
fprintf('SIGNAL I\n');
sig_1.printSignal();                        %powinno wypisa� 1010000000010000 i tak te� si� dzieje

scrambler = Scrambler(LSFR);                %obiekt scramblera
sig_1= scrambler.scramble_signal(sig_1);    %scramblowanie sig_1

fprintf('sig_1 after scrambling:\n');   
sig_1.printSignal();                        %wydruk po scramblingu

descrambler = Descrambler(LSFR);            %obiekt descramblera
sig_1 = descrambler.descramble(sig_1);      %proces descramblingu

fprintf('sig_1 after descrambling:\n');   
sig_1.printSignal();                        %wydruk po scramblingu

sig_2 = Signal(16);                         %sygna� nr 2 - 16b
sig_2.setBitTrue(1);
sig_2.setBitTrue(16);
fprintf('SIGNAL II\n');
sig_2.printSignal();                        %powinno wypisa� 1000000000000001 i tak te� si� dzieje

%obiekty scrambler/descrambler powinny mie� swoje ramki(lokalne LSFR) przesuni�te o t�
%sam� ilo�� bit�w oraz ich zawarto�� powinna byc taka sama
%wobec tego puszczenie procesu scramblingu i descramblingu raz jeszcze
%bez wywo�ywa� w.w. obiektach funkcji resetowania ramki
%powinno skutkowa� otrzymaniem poprawnego SIG_2

sig_2= scrambler.scramble_signal(sig_2);    %scramblowanie sig_2
fprintf('sig_2 after scrambling:\n');   
sig_2.printSignal();                        %wydruk po scramblingu
sig_2 = descrambler.descramble(sig_2);      %proces descramblingu
fprintf('sig_2 after descrambling:\n');   
sig_2.printSignal(); 

%to o czym napisa�em wy�ej jest dowodem, �e w klasie Scram/Descram 
%funkcje reset s� niepotrzebne
%dodatkowo niepotrzebne jest przechowywanie dw�ch kopii ramek
%gdy� raz przes�ane do poszczeg�lnych obiekt�w
%b�d� generowa� si� automatycznie i synchronicznie

%polecam zakomentowa� sobie wiersz 16 aby zobaczy� �e maj�c dwa identyczne
%sygna�y otrzymujemy dwa r�ne zescramblowane sygna�y wynikowe
%a o to w tym wszystkim chodzi, by sygna�y jednak nie mia�y swych sta�ych
%"scramblowych" odpowiednik�w

%test generatora - tworzony sygna� 16b, jak poprzednio
G = SignalGenerator(16);

sig_3 = G.generateSignal();
fprintf('SIGNAL III\n');
sig_3.printSignal();
sig_3= scrambler.scramble_signal(sig_3);    %scramblowanie sig_3
fprintf('sig_3 after scrambling:\n');   
sig_3.printSignal();                        %wydruk po scramblingu
sig_3 = descrambler.descramble(sig_3);      %proces descramblingu
fprintf('sig_3 after descrambling:\n');   
sig_3.printSignal(); 