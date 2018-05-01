classdef CustomChannel < Channel
    %CUSTOMCHANNEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        probability; %dla funkcjonalnosci bsc
        desynchNumOfBits; %ilosc bitow po ktorych sie desynchronizuje
        periodNumOfBits; %okresowe przeklamanie bitu
    end
    
    methods (Access = public)
        
        function this = CustomChannel(prob, desynch, period)
            
        end
        
        function sendSig(this, signal)
            if (class(signal) == "Signal")      %tylko jeœli wysy³any obiekt jest instancj¹ Signal
                this.signal = signal.copy;      %wysy³amy kopiê sygna³u do kana³u
                this.passThroughCC;             %przepuszczenie kopii sygna³u przez CC
            else
                return
            end
        end
       
        function received = receiveSig(this)
            if(~isempty(this.signal))    %je¿eli signal jest, to go wyœlij
                received = this.signal;
            else                        % je¿eli go nie ma to wyslij pusty wektor
                received = [];
            end
            this.signal = [];
        end 
        
    end
    
    methods (Access = private)
        
        function passThroughCC(this)
            this.BSC();
            this.periodicDistortion();
            this.desynchronization();
        end
        
        function BSC(this)
            temp_sig = zeroes(this.signal.getSize());
            for i=1 : this.signal.getSize()
                temp_sig(i) = this.signal.getBitAt(i);
            end
            temp_sig = bsc(temp_sig, this.probability);
            for i=1 : this.signal.getSize()
                this.signal.setBitAt(i, temp_sig(i));
            end
        end
        
        function periodicDistortion(this)
            k = floor(this.signal.getSize()/this.periodNumOfBits);
            i = this.periodNumOfBits;
            while(k>0)
                if(this.signal.getBitAt(i) == 1)
                    this.signal.setBitFalse(i);
                else
                    this.signal.setBitTrue(i);
                end
                i = i + this.periodNumOfBits;
                k = k - 1;
            end
        end
        
        function desynchronization(this)
            counter = 0;
            currentDesynchBit = this.signal.getBitAt(1);
            
            for i=1 : this.signal.getSize();
                
                if(this.signal.getBitAt(i) == currentDesynchBit)
                    counter = counter + 1;
                else
                    currentDesynchBit = this.signal.getBitAt(i);
                    counter = 1;
                end
                
                if(counter == this.desynchNumOfBits)
                    %w przypadku desynchronizacji
                    %kolejne x bity sa przeklamywane
                    %aktualnie dwa 
                    %trzeba ustalic jednoznacznie na ile sie decydujemy
                    this.signal.negBitAt(i);
                    this.signal.negBitAt(i+1);
                end
                
            end
        end
    end
    
end

