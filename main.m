clear;
%dziêki temu skrypty z widoki/ s¹ widoczne
addpath(genpath('view'));
addpath(genpath('model'));

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
sig_1= scrambler.scramble_signal(sig_1);    %scramblowanie sig_1

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

sig_2= scrambler.scramble_signal(sig_2);    %scramblowanie sig_2
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

%utworzenie obiektu BER
B = BER();

%test generatora - tworzony sygna³ 16b, jak poprzednio
G = SignalGenerator(16);

sig_3 = G.generateSignal();
B.setOrigin(sig_3);
fprintf('SIGNAL III\n');
sig_3.printSignal();
sig_3= scrambler.scramble_signal(sig_3);    %scramblowanie sig_3
fprintf('sig_3 after scrambling:\n');   
sig_3.printSignal();                        %wydruk po scramblingu
sig_3 = descrambler.descramble(sig_3);      %proces descramblingu
B.setDescrambled(sig_3);
fprintf('sig_3 after descrambling:\n');   
sig_3.printSignal();
%BER wynosi
fprintf('BER: %d\n', B.calculateBER);   

%proba dzia³ania BER na ustawionych wartoœciach
s_o = Signal(5);
s_d = Signal(5);
s_o.setBitTrue(2);
s_d.setBitTrue(3);
B.setOrigin(s_o);
B.setDescrambled(s_d);
fprintf('BER: %f\n', B.calculateBER); % = 0.4 - prawid³ow

%w przypadku nierowónych sygna³ów drukuje  BER = -1
s_o2 = Signal(5);
s_d2 = Signal(6);
s_o2.setBitTrue(2);
s_d2.setBitTrue(3);
B.setOrigin(s_o2);
B.setDescrambled(s_d2);
fprintf('BER: %f\n', B.calculateBER);

%test kana³u BSC
BSC = BSChannel(0.2);
fprintf('\nsig before BSC:\n');
sig = G.generateSignal();
sig.printSignal();
copy_sig = sig.copy();
BSC.sendSig(copy_sig);
copy_sig = BSC.receiveSig();
copy_sig.printSignal();

