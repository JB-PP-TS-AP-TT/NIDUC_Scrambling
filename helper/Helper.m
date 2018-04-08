classdef Helper
    %HELPER class containg some helper methods
    
    methods (Static)
        function o = appendToAlign64(signal)
            currentSize = signal.getSize();
            newSize = 64 * (floor((currentSize-1)/64) + 1);
            o = Signal(newSize);
            
            for i = 1 : currentSize
                o.setBitAt(i, signal.getBitAt(i));
            end
        end
    end
end