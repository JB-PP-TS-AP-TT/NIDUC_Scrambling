%dziêki temu skrypty z widoki/ s¹ widoczne
addpath(genpath('view'));
addpath(genpath('model'));

%odpalenie g³ównego widoku aplikacji - czyli wywolanie funkcji
%zdefiniowanej w glownyWidok.m, która z kolei odpala figure
%glownyWidok.fig, stworzon¹ przy pomocy GUIDE (lewym na glownyWidok.fig i
%edytuj w GUIDE)
%mainView();

test_sig = Signal(16);
test_sig.setBitTrue(1);
test_sig.setBitTrue(3);
test_sig.setBitTrue(12);
test_sig.printSignal();     %powinno wypisaæ 1010000000010000 i tak te¿ siê dzieje

scrambler = Scrambler();    %obiekt scramblera

copy_sig = test_sig.copy(); %kopia sygna³u zostanie zescramblowana

scrambler.scramble_signal(copy_sig);    %scramblowanie copy_sig

fprintf('\ntest_sig after scrambling:\n');   
copy_sig.printSignal();     %wydruk po scramblingu