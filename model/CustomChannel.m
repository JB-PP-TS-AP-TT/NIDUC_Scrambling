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
            
            if(prob<=1 && prob>=0)
                this.probability = prob;
            else
                this.probability = 0;
            end
            
            if(desynch>1)
                this.desynchNumOfBits = desynch;
            else
                this.desynchNumOfBits = 13;
            end
            
            if(period>0)
                this.periodNumOfBits = period;
            else
                this.periodNumOfBits = 0;
            end
            
        end
        
        function sendSig(this, signal)
            if (class(signal) == "Signal")      %tylko je�li wysy�any obiekt jest instancj� Signal
                this.signal = signal.copy;      %wysy�amy kopi� sygna�u do kana�u
                this.passThroughCC();             %przepuszczenie kopii sygna�u przez CC
            else
                return
            end
        end
       
        function received = receiveSig(this)
            if(~isempty(this.signal))    %je�eli signal jest, to go wy�lij
                received = this.signal;
            else                        % je�eli go nie ma to wyslij pusty wektor
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
            if(this.probability ~= 0)
                temp_sig = zeros(this.signal.getSize());
                for i=1 : this.signal.getSize()
                    temp_sig(i) = this.signal.getBitAt(i);
                end
                temp_sig = bsc(temp_sig, this.probability);
                for i=1 : this.signal.getSize()
                    this.signal.setBitAt(i, temp_sig(i));
                end
            end
        end
        
        function periodicDistortion(this)
            if(this.periodNumOfBits ~= 0)
                k = floor(this.signal.getSize()/this.periodNumOfBits);
                i = this.periodNumOfBits;
                while(k>0)
                    this.signal.negBitAt(i);
                    i = i + this.periodNumOfBits;
                    k = k - 1;
                end
            end
        end
        
        function desynchronization(this)
            counter = 0;
            currentDesynchBit = this.signal.getBitAt(1);
            i=1;
            while(i <= this.signal.getSize())
                
                if(this.signal.getBitAt(i) == currentDesynchBit)
                    counter = counter + 1;
                else
                    currentDesynchBit = this.signal.getBitAt(i);
                    counter = 1;
                end
                
                if(counter >= this.desynchNumOfBits)
                    %w przypadku desynchronizacji
                    %kolejne x bitow bedzie przeklamywanych
                    %aktualnie dwa, mo�na zwi�kszy� na 4,8...
                    %trzeba ustalic jednoznacznie na ile sie decydujemy
                    this.signal.negBitAt(i);
                    this.signal.negBitAt(i+1);
                    i = i + 2;
                else
                    i = i + 1;
                end
                
            end
        end
        
    end
    
end

