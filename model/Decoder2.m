classdef Decoder2 < handle

    properties
    end
    
    methods
        
        function this=Decoder2()
        end
        
        function decodedSignal = decode(this,signal)
            decodedSignal = signal; %funkcja musi miec co zwrocic
            
            if class(signal) == "Signal"
                %w petli co 64 bity wstawimy preambule
                p = floor( signal.getSize() / 66);
                i = 1;
                while(p>0)
                    signal.removeBitAt(i);
                    signal.removeBitAt(i);
                    i = i + 64;
                    p = p - 1; %zmniejszamy ilosc preambul do wpisania
                end
            else
                return 
            end
            
            decodedSignal = signal; %nowy zmieniony, zakodowany sygna³
            
        end 
       
    end
    
end
