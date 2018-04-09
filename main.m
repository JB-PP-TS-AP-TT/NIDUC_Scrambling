%dzi�ki temu skrypty z widoki/ s� widoczne
addpath(genpath('view'));
addpath(genpath('model'));

%odpalenie g��wnego widoku aplikacji - czyli wywolanie funkcji
%zdefiniowanej w glownyWidok.m, kt�ra z kolei odpala figure
%glownyWidok.fig, stworzon� przy pomocy GUIDE (lewym na glownyWidok.fig i
%edytuj w GUIDE)
%mainView();

test_sig = Signal(16);
test_sig.setBitTrue(1);
test_sig.setBitTrue(3);
test_sig.setBitTrue(12);
test_sig.printSignal();     %powinno wypisa� 1010000000010000 i tak te� si� dzieje

scrambler = Scrambler();    %obiekt scramblera

copy_sig = test_sig.copy(); %kopia sygna�u zostanie zescramblowana

scrambler.scramble_signal(copy_sig);    %scramblowanie copy_sig

fprintf('\ntest_sig after scrambling:\n');   
copy_sig.printSignal();     %wydruk po scramblingu