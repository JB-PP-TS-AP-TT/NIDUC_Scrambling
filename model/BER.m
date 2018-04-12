classdef BER < handle
    %BER
    %   basing on original signal and descrambled signal
    %   funkcja calculateBER zwraca BER
    
    properties (Access = private)
        origin
        o_length
        descrambled
        d_length
        error_bits %przetrzymuje liczbê niezgodnych bitów
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
            ber = -1; %obliczaj¹c BER bez podania wczeœniej sygna³ów nale¿y zwróciæ wartoœæ b³êdu (error val = -1)
                      %je¿eli d³ugoœci podanych sygna³ów s¹ ró¿ne, równiez
                      %nalezy zwróciæ wartoœæ b³êdu (error val = -1)
            
            if(obj.o_length == obj.d_length)% je¿eli nie zgadza siê d³ugoœæ to przerwij
                
                 if( ~isempty(obj.origin) & ~isempty(obj.descrambled))% je¿eli sygna³y s¹ puste to przerwij
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
            obj.reset;%reset wszystkich wartoœci
            
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

