classdef Encoder < handle

    properties
        input=[];
        newesignal=[];
    end
    
    methods
        function this=Encoder(signal)
            this.input=signal;
        end
        function encodedSignal = encode(this)
            preambule = [0 1];
            temp=1;
            org_signal_size = length(this.input);
            while(temp<org_signal_size)
                if(temp+64>org_signal_size)
                    this.newesignal=horzcat(this.newesignal,horzcat(preambule,this.input(temp:org_signal_size)));
                    break;
                end
                this.newesignal=horzcat(this.newesignal,horzcat(preambule,this.input(temp:temp+63))); 
                temp = temp + 64;
                if(temp+64>org_signal_size)
                    this.newesignal=horzcat(this.newesignal,horzcat(preambule,this.input(temp:org_signal_size)));
                    break;
                end
            end
            encodedSignal=this.newesignal;
        end 
        function print(this)
            fprintf('[ ');
            fprintf('%d ',this.newesignal);
            fprintf(']\n');
        end
    end
end
