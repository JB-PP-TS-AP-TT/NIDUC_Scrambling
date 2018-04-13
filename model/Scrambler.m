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
        
        function resetRegister(this)   %reset rejestru do stanu pocz�tkowego
            this.lfsRegister = this.defaultSeed;
        end
        
        function scr = scrambleSignal(this, signal)    %funkcja scrambluj�ca
            for i = 1:signal.getSize()  
                x = xor(this.lfsRegister(1), xor(this.lfsRegister(21), this.lfsRegister(37))); %xor 1,21 i 37 indeksu lfsr
                x = xor(signal.getBitAt(i), x);     %xor danego bitu sygna�u oraz warto�ci z poprzedniego xora
                signal.setBitAt(i, x);              %ustawienie bitu sygna�u wyj�ciowego
                
                this.lfsRegister = [signal.getBitAt(i), this.lfsRegister(1:end-1)];  %przesuni�cie rejestru
            end
            %zwroc sygnal
            scr = signal;        
            %this.resetRegister;
            %podczas przesy�u ramka nie b�dzie musia�a by� resetowana, bo w
            %scramblerze i descramblerze b�d� mia�y identyczn� zawarto��
            %i b�d� przesuwa� si� zawsze o tyle samo
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