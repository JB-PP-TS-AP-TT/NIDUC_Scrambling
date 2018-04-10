classdef Scrambler < handle
    
    properties (Access = private)
        default_seed
        lfs_register
    end
    
    methods
        function this = Scrambler(seed) %konstruktor
            if(nargin == 0)             %number of function input arguments = 0 -> konstruktor bezparametryczny
                this.default_seed = [0, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1];
                this.lfs_register = this.default_seed;
            else                        %seed z parametru
                this.default_seed = seed;
                this.lfs_register = seed;
            end
        end
        
        function reset_register(this)   %reset rejestru do stanu pocz�tkowego
            this.lfs_register = this.default_seed;
        end
        
        function scr = scramble_signal(this, signal)    %funkcja scrambluj�ca
            for i = 1:signal.getSize()  
                x = xor(this.lfs_register(1), xor(this.lfs_register(21), this.lfs_register(37))); %xor 1,21 i 37 indeksu lfsr
                x = xor(signal.getBitAt(i), x);     %xor danego bitu sygna�u oraz warto�ci z poprzedniego xora
                signal.setBitAt(i, x);              %ustawienie bitu sygna�u wyj�ciowego
                
                this.lfs_register = [signal.getBitAt(i), this.lfs_register(1:end-1)];  %przesuni�cie rejestru
            end
            %zwroc sygnal
            scr = signal;        
            %this.reset_register;
            %podczas przesy�u ramka nie b�dzie musia�a by� resetowana, bo w
            %scramblerze i descramblerze b�d� mia�y identyczn� zawarto��
            %i b�d� przesuwa� si� zawsze o tyle samo
        end
        
        function print_register(this)   %wydruk stanu rejestru lfs
            fprintf('Rejestr generatora:\n[');
            for i = 1 : size(this.lfs_register,2)
                fprintf('%d, ', this.lfs_register(i));
            end
            fprintf(' ]\n');
        end
        
    end
end