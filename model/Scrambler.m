classdef Scrambler < handle
    
    properties (Access = private)
        defaultSeed
        lfsRegister
    end
    
    methods
        function this = Scrambler(seed) %konstruktor
            if(nargin == 0)             %number of function input arguments = 0 -> konstruktor bezparametryczny
                this.defaultSeed = [0, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1];
                this.lfsRegister = this.defaultSeed;
            else                        %seed z parametru
                this.defaultSeed = seed;
                this.lfsRegister = seed;
            end
        end
        
        function resetRegister(this)   %reset rejestru do stanu pocz¹tkowego
            this.lfsRegister = this.defaultSeed;
        end
        
        function scr = scrambleSignal(this, signal)    %funkcja scrambluj¹ca
            for i = 1:signal.getSize()  
                x = xor(this.lfsRegister(1), xor(this.lfsRegister(21), this.lfsRegister(37))); %xor 1,21 i 37 indeksu lfsr
                x = xor(signal.getBitAt(i), x);     %xor danego bitu sygna³u oraz wartoœci z poprzedniego xora
                signal.setBitAt(i, x);              %ustawienie bitu sygna³u wyjœciowego
                
                this.lfsRegister = [signal.getBitAt(i), this.lfsRegister(1:end-1)];  %przesuniêcie rejestru
            end
            %zwroc sygnal
            scr = signal;        
            %this.resetRegister;
            %podczas przesy³u ramka nie bêdzie musia³a byæ resetowana, bo w
            %scramblerze i descramblerze bêd¹ mia³y identyczn¹ zawartoœæ
            %i bêd¹ przesuwaæ siê zawsze o tyle samo
        end
        
        function print_register(this)   %wydruk stanu rejestru lfs
            fprintf('Rejestr generatora:\n[');
            for i = 1 : size(this.lfsRegister,2)
                fprintf('%d, ', this.lfsRegister(i));
            end
            fprintf(' ]\n');
        end
        
    end
end