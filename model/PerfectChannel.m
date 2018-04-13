classdef PerfectChannel < Channel
    %ten kana� nie b�dzie generowa� przek�ama� w sygnale
    methods
        function this = PerfectChannel()
            this.signal = [];                   %dziedziczone z klasy abstrakcyjnej Channel
        end
        
        function sendSig(this, signal)
            if class(signal) == "Signal"        %tylko je�li wysy�any obiekt jest instancj� Signal
                this.signal = signal.copy;      %wysy�amy kopi� sygna�u
            else
                return
            end
        end
        
        function received = receiveSig(this)
            received = (isempty(this.signal)).*Signal(0) + ~(isempty(this.signal)).*this.signal; % received = (isempty(signal)) ? Signal(0) : []
            if(~isempty(this.signal))
                this.signal = [];
            end
        end
    end
end