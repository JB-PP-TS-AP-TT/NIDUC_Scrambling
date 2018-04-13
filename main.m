clear;
%dzi�ki temu skrypty z widoki/ s� widoczne
addpath(genpath('view'));
addpath(genpath('model'));
addpath(genpath('helper'));

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

enc1 = Encoder(sig_1.bits(1:16));
enc1.encode();
fprintf('Encoder\n');
enc1.print();

scrambler = Scrambler(LSFR);                %obiekt scramblera
sig_1= scrambler.scrambleSignal(sig_1);    %scramblowanie sig_1

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

sig_2= scrambler.scrambleSignal(sig_2);    %scramblowanie sig_2
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


%test generatora - tworzony sygna� 64b
sig_3 = Signal.generate(64);
sig_4 = sig_3.copy();       %kopia robocza

fprintf('SIGNAL III\n');
sig_3.printSignal();

scrambler.scrambleSignal(sig_4);
fprintf('sig_3 after scrambling:\n');   
sig_4.printSignal();

sig_4 = descrambler.descramble(sig_4);
fprintf('sig_3 after descrambling:\n');   
sig_3.printSignal();

fprintf('BER: %d\n', Helper.calculateBER(sig_3, sig_4));

%przak�amanie w wyj�ciowym sygnale
sig_4.negBitAt(21);
sig_4.negBitAt(37);
sig_4.negBitAt(14);
sig_4.negBitAt(5);
fprintf('BER after negations at 21/37/14/5 positions in output signal:\n');
fprintf('BER: %f\n', Helper.calculateBER(sig_3, sig_4));

%test kana�u BSC
BSC = BSChannel(0.2);
fprintf('\nsig before BSC:\n');
sig = Signal.generate(64);
sig.printSignal();
copy_sig = sig.copy();
BSC.sendSig(copy_sig);
copy_sig = BSC.receiveSig();
copy_sig.printSignal();