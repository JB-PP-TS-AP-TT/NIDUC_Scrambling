clear;

signal = [0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,];
frame  = [0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1];
output = zeros(32);

fprintf('Przed: [');
for i = 1 : length(signal)
    fprintf('%d ', signal(i));
end
fprintf('\b]\n');

for i = 1 : length(signal)
    x = xor(frame(1), xor(frame(40), frame(59)));   %xor bitu 1, 40, 59
    x = xor(signal(i), x);                          %xor bitu wej�cia i warto�ci pseudolosowej
    output(i) = x;                                  %dla czytelno�ci w osobny sygna�
    frame = [output(i), frame(1:end-1)];            %nowa warto�� do ramki, przesuni�cie reszty
end

fprintf('Po:    [');
for i = 1 : length(output)
    fprintf('%d ', output(i));
end
fprintf('\b]\n');
