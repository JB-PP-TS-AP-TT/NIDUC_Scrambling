classdef Channel < handle

    properties (SetAccess = protected, GetAccess = protected) %klasa abstrakcyjna, zatem pola z modyfikatorem protected
        signal
    end
    
    methods (Abstract)
        sendSig(this, signal)       %tylko metody wspólne dla ka¿dego kana³u
        receive(this)
    end
end