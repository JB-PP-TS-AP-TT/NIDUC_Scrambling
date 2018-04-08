addpath(genpath('model'));
addpath(genpath('helper'));

% demo Ethernet
decoderEthernet = DecoderEthernet();

% parameters
signalSize = 113;
desyncAt = 12; % less than signalSize!!

% create a random signal
signal = Signal(signalSize);
for i = 1 : signalSize 
    if round(rand())
       signal.setBitTrue(i);
    end
end

% append zeroes to match ethernet 64-bit framing
signal = Helper.appendToAlign64(signal);

% decoding demo

signal = decoderEthernet.decode(signal);

disp("Signal after decoding:");
signal.disp();
fprintf("Size: %d \n", signal.getSize());
fprintf("Was good: %d \n", decoderEthernet.wasGood());

% SYNC-LOSS SIMULATION

disp(" ");
disp("Sync loss simulation: ");
disp(" ");

% doubling bit at desyncAt index
newSignal = Signal(signal.getSize() + 1);
for i = 1 : desyncAt
    newSignal.setBitAt(i, signal.getBitAt(i));
end
newSignal.setBitAt(desyncAt + 1, newSignal.getBitAt(desyncAt));
for i = desyncAt + 2 : newSignal.getSize()
    newSignal.setBitAt(i, signal.getBitAt(i-1));
end
signal = newSignal;

disp("Signal after desync:");
signal.disp();
fprintf("Size: %d \n", signal.getSize());


signal = decoderEthernet.decode(signal);

disp("Signal after decoding:");
signal.disp();
fprintf("Size: %d \n", signal.getSize());
fprintf("Was good: %d\n", decoderEthernet.wasGood());