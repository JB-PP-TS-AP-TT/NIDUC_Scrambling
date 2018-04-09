addpath(genpath('model'));
addpath(genpath('helper'));

% demo Ethernet
decoderEthernet = DecoderEthernet();

% parametry
signalSize = 113;
desyncAt = 12; % mniejszy ni� signalSize!!

% tworzenie losowego sygna�u
signal = Signal(signalSize);
for i = 1 : signalSize 
    if round(rand())
       signal.setBitTrue(i);
    end
end

% dope�nia zera, aby dopasowa� ramk� ethernet 64-bitow�
signal = Helper.appendToAlign64(signal);

% dekodowanie demo

signal = decoderEthernet.decode(signal);

disp("Sygna� przed dekodowaniem:");
signal.disp();
fprintf("Rozmiar: %d \n", signal.getSize());
fprintf("By� poprawny: %d \n", decoderEthernet.wasGood());

% SYNC-LOSS SYMULACJA

disp(" ");
disp("Sync loss symulacja: ");
disp(" ");

% podwojenie bitu przy desyncAt indeks
newSignal = Signal(signal.getSize() + 1);
for i = 1 : desyncAt
    newSignal.setBitAt(i, signal.getBitAt(i));
end
newSignal.setBitAt(desyncAt + 1, newSignal.getBitAt(desyncAt));
for i = desyncAt + 2 : newSignal.getSize()
    newSignal.setBitAt(i, signal.getBitAt(i-1));
end
signal = newSignal;

disp("Sygna� po desynchronizacji:");
signal.disp();
fprintf("Rozmiar: %d \n", signal.getSize());


signal = decoderEthernet.decode(signal);

disp("Signal po dekodowaniu:");
signal.disp();
fprintf("Rozmiar: %d \n", signal.getSize());
fprintf("By� poprawny: %d\n", decoderEthernet.wasGood());