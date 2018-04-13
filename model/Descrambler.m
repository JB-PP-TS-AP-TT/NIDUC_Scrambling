classdef Descrambler < handle

    properties (Access = private)
        LSFR
        tempLSFR
    end
    
    methods 
        function this = Descrambler(seed)
            if(nargin == 0)
                %domyslna ramka musi by ta sama co w Scrambler.m
                this.LSFR = [0, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1];
                this.tempLSFR = this.LSFR;
            else
                this.LSFR = seed;
                this.tempLSFR = this.LSFR;
            end
        end
        
        function s = descramble(this, signal)
            for i=1 : signal.getSize()
               x = xor(this.tempLSFR(1),xor(this.tempLSFR(21),this.tempLSFR(37)));
               x = xor(x,signal.getBitAt(i));
              
               this.tempLSFR(2:end) = this.tempLSFR(1:(end-1)); %przesuniêcie ramki
               this.tempLSFR(1) = signal.getBitAt(i);                    %wprowadzenie bitu sygna³u na pozycje pierwsz¹
               
               signal.setBitAt(i,x);
            end
            %zwroc sygnal         
            s = signal;
            %obj.resetLSFR; metoda reset w przypadku scram i descram jest niepotrzebna
                            %co wiecej nie bêd¹ potrzebne zmienne takie jak
                            %deafult_seed i lfs_reg oraz LSFR i temp_LSFR
                            %do prawid³owego dzia³a wystarczy inicjalizacja
                            %scramblera i descramblera na starcie
                            %odpowiedni¹ ramk¹ LSFR
        end
    end
    
    methods (Access = private)
        function resetLSFR(this)
            this.tempLSFR = this.LSFR;
        end
    end
    
end

