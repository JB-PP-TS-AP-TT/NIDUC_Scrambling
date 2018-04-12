classdef SignalGenerator < handle
    %GENERATOR - klasa genruj¹ca sygna³ o d³ugoœci 'length'
    %   je¿eli d³ugoœæ nie zostanie okreœlona
    %   zostanie domyœlnie przyjêta d³ugoœæ 64b
    
    properties (Access = private)
        length = 0
    end
    
    methods
        function obj = SignalGenerator(N)
            if (nargin == 0)
                obj.length = 64; % jezeli N nie bedzie podane ustaw domysln¹
            else
                obj.length = N;
            end
        end
        
        function generated = generateSignal(obj)
            generated = Signal(obj.length);
            for i = 1 : obj.length
                if(rand >= 0.85) %wartoœci rozk³ady jednostajnego z przedzia³u liczb (0,1)
                    generated.setBitTrue(i);
                end
            end
        end
        
    end
    
end

