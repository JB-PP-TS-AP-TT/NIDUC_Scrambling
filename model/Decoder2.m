classdef Decoder2 < handle

    properties
        input=[];
        newesignal=[];
    end
    
    methods
        function this=Decoder2(signal)
            this.input=signal;
        end
        function decodedSignal = decode(this)
            this.newesignal=[]; %bedzie zbierala 64 bitowe ramki

        while(~isempty(this.input))
            if(length(this.input)<64)
                this.input=this.input(3:length(this.input));%odciêcie pocz¹tkowych 2 bitów ostatniej ramki
                this.newesignal=horzcat(this.newesignal,this.input(1:length(this.input))); %do³¹czenie ostatniej ramki
                break;
            end
            this.input=this.input(3:length(this.input));%odciêcie pocz¹tkowych 2 bitów
            this.newesignal=horzcat(this.newesignal,this.input(1:64));
            this.input=this.input(65:length(this.input)); %odciêcie pocz¹tkowych 64 bitów
        end
            decodedSignal=this.newesignal;
        end 
        function print(this)
            fprintf('[ ');
            fprintf('%d ',this.newesignal);
            fprintf(']\n');
        end
    end
end
