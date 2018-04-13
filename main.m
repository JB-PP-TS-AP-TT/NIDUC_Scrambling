clear;
%dziêki temu skrypty z widoki/ s¹ widoczne
addpath(genpath('view'));
addpath(genpath('model'));
addpath(genpath('helper'));

%odpalenie g³ównego widoku aplikacji - czyli wywolanie funkcji
%zdefiniowanej w glownyWidok.m, która z kolei odpala figure
%glownyWidok.fig, stworzon¹ przy pomocy GUIDE (lewym na glownyWidok.fig i
%edytuj w GUIDE)
%mainView();


LSFR = [0, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0, 0, 1];

sig_1 = Signal(16);                         %sygna³ nr 1 - 16b
sig_1.setBitTrue(1);
sig_1.setBitTrue(3);
sig_1.setBitTrue(16);
fprintf('SIGNAL I\n');
sig_1.printSignal();                        %powinno wypisaæ 1010000000010000 i tak te¿ siê dzieje

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

sig_2 = Signal(16);                         %sygna³ nr 2 - 16b
sig_2.setBitTrue(1);
sig_2.setBitTrue(16);
fprintf('SIGNAL II\n');
sig_2.printSignal();                        %powinno wypisaæ 1000000000000001 i tak te¿ siê dzieje

%obiekty scrambler/descrambler powinny mieæ swoje ramki(lokalne LSFR) przesuniête o tê
%sam¹ iloœæ bitów oraz ich zawartoœæ powinna byc taka sama
%wobec tego puszczenie procesu scramblingu i descramblingu raz jeszcze
%bez wywo³ywañ w.w. obiektach funkcji resetowania ramki
%powinno skutkowaæ otrzymaniem poprawnego SIG_2

sig_2= scrambler.scrambleSignal(sig_2);    %scramblowanie sig_2
fprintf('sig_2 after scrambling:\n');   
sig_2.printSignal();                        %wydruk po scramblingu
sig_2 = descrambler.descramble(sig_2);      %proces descramblingu
fprintf('sig_2 after descrambling:\n');   
sig_2.printSignal(); 

%to o czym napisa³em wy¿ej jest dowodem, ¿e w klasie Scram/Descram 
%funkcje reset s¹ niepotrzebne
%dodatkowo niepotrzebne jest przechowywanie dwóch kopii ramek
%gdy¿ raz przes³ane do poszczególnych obiektów
%bêd¹ generowaæ siê automatycznie i synchronicznie

%polecam zakomentowaæ sobie wiersz 16 aby zobaczyæ ¿e maj¹c dwa identyczne
%sygna³y otrzymujemy dwa ró¿ne zescramblowane sygna³y wynikowe
%a o to w tym wszystkim chodzi, by sygna³y jednak nie mia³y swych sta³ych
%"scramblowych" odpowiedników


%test generatora - tworzony sygna³ 64b
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

%przak³amanie w wyjœciowym sygnale
sig_4.negBitAt(21);
sig_4.negBitAt(37);
sig_4.negBitAt(14);
sig_4.negBitAt(5);
fprintf('BER after negations at 21/37/14/5 positions in output signal:\n');
fprintf('BER: %f\n', Helper.calculateBER(sig_3, sig_4));

%test kana³u BSC
BSC = BSChannel(0.2);
fprintf('\nsig before BSC:\n');
sig = Signal.generate(64);
sig.printSignal();
copy_sig = sig.copy();
BSC.sendSig(copy_sig);
copy_sig = BSC.receiveSig();
copy_sig.printSignal();