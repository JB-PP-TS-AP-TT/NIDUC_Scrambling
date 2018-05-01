classdef Decoder2 < handle

    properties
        preamble = [0,1];
    end
    
    methods
        
        function this=Decoder2()
        end
        
        function decodedSignal = decode(this,signal)
            decodedSignal = signal; %funkcja musi miec co zwrocic
            
            if class(signal) == "Signal"
                %w petli co 64 bity usuwamy preambule
                p = floor( signal.getSize() / 66); %ilosc potencjalnych preambul
                temp_preamble = [0,0]; %odczytana preambula na pozycji xx
                i = 1;
                while(p>0)
                    temp_preamble(1) = signal.getBitAt(i);
                    temp_preamble(2) = signal.getBitAt(i+1);
                    if(this.preamble == temp_preamble)
                        %jezeli preambula jest ok
                        signal.removeBitAt(i);
                        signal.removeBitAt(i);
                        i = i + 64;
                    else
                        %PODEJSCIE I
                        %jezeli preambula jest bledna
                        %konieczna resynchronizacja
                        %polega ona na pominieciu (usunieciu) blednej
                        %preambuly oraz nastepnych 64 bitow
                        
                        %for k = 1 : 66
                        %    signal.removeBitAt(i);
                        %end
                        
                        %PODEJSCIE II - moim zdaniem lepsze ze wzgledu BER
                        %resynchronizacja usuwa bledne bity preambuly jak
                        %normalna preambule
                        %a nastepnie wstawia naprzemiennie sekwencje 0/1
                        %zmniejsza to BER (o ile nie sa uzywane scramblery i descramblery)
                        %mozna nazwac to ~ zaszumieniem sygna³u
                        
                        signal.removeBitAt(i);
                        signal.removeBitAt(i);
                        for k = 1 : 64
                            if(mod(k,2)==0)
                                signal.setBitTrue(i + k - 1);
                            else
                                signal.setBitFalse(i + k - 1);
                            end
                        end
                        i = i + 64;
                    end
                    
                    p = p - 1;
                    
                end
            else
                return 
            end
            
            decodedSignal = signal; %odkodowany i zresynchronizowany sygna³
            
        end 
       
    end
    
end
