classdef SignalGenerator < handle
    %GENERATOR - klasa genruj�ca sygna� o d�ugo�ci 'length'
    %   je�eli d�ugo�� nie zostanie okre�lona
    %   zostanie domy�lnie przyj�ta d�ugo�� 64b
    
    properties (Access = private)
        length = 0
    end
    
    methods
        function obj = SignalGenerator(N)
            if (nargin == 0)
                obj.length = 64; % jezeli N nie bedzie podane ustaw domysln�
            else
                obj.length = N;
            end
        end
        
        function generated = generateSignal(obj)
            generated = Signal(obj.length);
            for i = 1 : obj.length
                if(rand >= 0.85) %warto�ci rozk�ady jednostajnego z przedzia�u liczb (0,1)
                    generated.setBitTrue(i);
                end
            end
        end
        
    end
    
end

