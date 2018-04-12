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

%test generatora - tworzony sygna³ 16b, jak poprzednio
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