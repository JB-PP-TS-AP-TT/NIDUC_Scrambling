classdef PerfectChannel < Channel
    %ten kana³ nie bêdzie generowa³ przek³amañ w sygnale
    methods
        function this = PerfectChannel()
            this.signal = [];                   %dziedziczone z klasy abstrakcyjnej Channel
        end
        
        function sendSig(this, signal)
            if class(signal) == "Signal"        %tylko jeœli wysy³any obiekt jest instancj¹ Signal
                this.signal = signal.copy;      %wysy³amy kopiê sygna³u
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