classdef BER < handle
    %BER
    %   basing on original signal and descrambled signal
    %   funkcja calculateBER zwraca BER
    
    properties (Access = private)
        origin
        o_length
        descrambled
        d_length
        error_bits %przetrzymuje liczb� niezgodnych bit�w
    end
    
    methods
        function obj = BER()
            obj.origin = [];
            obj.descrambled = [];
            obj.o_length = 0;
            obj.d_length = 0;
            obj.error_bits = 0;
        end
        
        function setOrigin(obj,signal)
            obj.origin = signal;
            obj.o_length = signal.getSize();
        end
        
        function setDescrambled(obj,signal)
            obj.descrambled = signal;
            obj.d_length = signal.getSize();
        end
        
        function ber = calculateBER(obj)
            ber = -1; %obliczaj�c BER bez podania wcze�niej sygna��w nale�y zwr�ci� warto�� b��du (error val = -1)
                      %je�eli d�ugo�ci podanych sygna��w s� r�ne, r�wniez
                      %nalezy zwr�ci� warto�� b��du (error val = -1)
            
            if(obj.o_length == obj.d_length)% je�eli nie zgadza si� d�ugo�� to przerwij
                
                 if( ~isempty(obj.origin) & ~isempty(obj.descrambled))% je�eli sygna�y s� puste to przerwij
                     for i=1:obj.o_length
                         if(obj.origin.getBitAt(i) ~= obj.descrambled.getBitAt(i))
                             obj.error_bits = obj.error_bits + 1;
                         end
                     end
                 else
                    return
                 end
                 
            else
                return
            end
            
            format long
            ber = obj.error_bits/obj.o_length;
            obj.reset;%reset wszystkich warto�ci
            
        end
        
        function reset(obj)
            obj.origin = [];
            obj.descrambled = [];
            obj.o_length = 0;
            obj.d_length = 0;
            obj.error_bits = 0;
        end
        
    end
    
end

