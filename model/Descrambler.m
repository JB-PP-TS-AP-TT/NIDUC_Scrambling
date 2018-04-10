classdef Descrambler < handle

    properties (Access = private)
        LSFR
        temp_LSFR
    end
    
    methods 
        function obj = Descrambler(seed)
            if(nargin == 0)
                %domyslna ramka musi by ta sama co w Scrambler.m
                obj.LSFR = [0, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1];
                obj.temp_LSFR = obj.LSFR;
            else
                obj.LSFR = seed;
                obj.temp_LSFR = obj.LSFR;
            end
        end
        
        function s = descramble(obj, signal)
            for i=1 : signal.getSize()
               x = xor(obj.temp_LSFR(1),xor(obj.temp_LSFR(21),obj.temp_LSFR(37)));
               x = xor(x,signal.getBitAt(i));
              
               obj.temp_LSFR(2:end) = obj.temp_LSFR(1:(end-1)); %przesuni�cie ramki
               obj.temp_LSFR(1) = signal.getBitAt(i);                    %wprowadzenie bitu sygna�u na pozycje pierwsz�
               
               signal.setBitAt(i,x);
            end
            %zwroc sygnal         
            s = signal;
            %obj.reset_LSFR; metoda reset w przypadku scram i descram jest niepotrzebna
                            %co wiecej nie b�d� potrzebne zmienne takie jak
                            %deafult_seed i lfs_reg oraz LSFR i temp_LSFR
                            %do prawid�owego dzia�a wystarczy inicjalizacja
                            %scramblera i descramblera na starcie
                            %odpowiedni� ramk� LSFR
        end
    end
    
    methods (Access = private)
        function reset_LSFR(obj)
            obj.temp_LSFR = obj.LSFR;
        end
    end
    
end

