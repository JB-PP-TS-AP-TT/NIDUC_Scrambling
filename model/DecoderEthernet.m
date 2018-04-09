classdef DecoderEthernet < handle
    
    properties (Access = private)
        errorFlag,
        resyncPreamblesToCheck = 2, % liczba preambu³ do sprawdzenia, zarówno po lewej, jak i po prawej stronie
        resyncPreambleCheckRange = 2
    end
    
    methods (Access = private)
        function bestPreambleScore = checkForPreambleInRange(obj, signal, i)
           bestPreambleScore = -1; % negatywny wynik jeœli preambu³a nie zosta³a znaleziona
          
           leftRange = i - obj.resyncPreambleCheckRange;
           rightRange = obj.resyncPreambleCheckRange*2 + leftRange;
           if leftRange < 1
              leftRange = 1;
           end
           
           while leftRange < signal.getSize() && leftRange <= rightRange
               if signal.getBitAt(leftRange) == 0 && signal.getBitAt(leftRange + 1) == 1
                    
                   foundPreambleScore = obj.resyncPreambleCheckRange - abs(i - leftRange);   % based on distance
                   if foundPreambleScore > bestPreambleScore 
                      bestPreambleScore = foundPreambleScore; 
                   end
                   
               end
               leftRange = leftRange + 1;
           end
        end
        
        function dataIndex = resync(obj, signal, badFrameIndex)
            % wyniki dla preambu³y wynosz¹ 0, i nie zosta³y jeszcze znalezione, wiêc indekx = -1
            potentialPreamblesScores = zeros(1,2*obj.resyncPreamblesToCheck);
            potentialPreamblesIndexes = zeros(1,2*obj.resyncPreamblesToCheck);
            
            for i = 1 : 2*obj.resyncPreamblesToCheck
                potentialPreamblesIndexes(i) = -1;
            end
            
            % go left
            iterator = badFrameIndex - 1;
            foundPreamblesLeft = 0;
            
            while iterator >= 1 && foundPreamblesLeft ~= obj.resyncPreamblesToCheck
                while iterator >= 1 && ~(signal.getBitAt(iterator) == 0 && signal.getBitAt(iterator+1) == 1)
                    iterator = iterator - 1;
                end
                
                if iterator >= 1
                    % found '01' preamble
                    foundPreamblesLeft = foundPreamblesLeft + 1;
                    potentialPreamblesIndexes(foundPreamblesLeft) = iterator;
                    
                    % score logic
                    score = 0;
                    % score to the left
                    currentPreambleIndex = iterator - 66;
                    while currentPreambleIndex >= 1
                       score = score + obj.checkForPreambleInRange(signal, currentPreambleIndex);
                       currentPreambleIndex = currentPreambleIndex - 66;
                    end
                    % score to the right
                    currentPreambleIndex = iterator + 66;
                    while currentPreambleIndex < signal.getSize()
                       score = score + obj.checkForPreambleInRange(signal, currentPreambleIndex);
                       currentPreambleIndex = currentPreambleIndex + 66;
                    end
                    
                    % zapanie wyniku
                    potentialPreamblesScores(foundPreamblesLeft) = score;
                    
                    iterator = iterator - 1;
                end
            end
            
            % go right
            iterator = badFrameIndex + 1;
            foundPreamblesRight = 0;
            
            while iterator < signal.getSize() && foundPreamblesRight ~= obj.resyncPreamblesToCheck
                while iterator < signal.getSize() && ~(signal.getBitAt(iterator) == 0 && signal.getBitAt(iterator+1) == 1) 
                    iterator = iterator + 1;
                end
                
                if iterator < signal.getSize()
                    % found '01' preamble
                    foundPreamblesRight = foundPreamblesRight + 1;
                    potentialPreamblesIndexes(foundPreamblesRight + foundPreamblesLeft) = iterator;
                    
                     % score logic
                    score = 0;
                    % score to the left
                    currentPreambleIndex = iterator - 66;
                    while currentPreambleIndex >= 1
                       score = score + obj.checkForPreambleInRange(signal, currentPreambleIndex);
                       currentPreambleIndex = currentPreambleIndex - 66;
                    end
                    % score to the right
                    currentPreambleIndex = iterator + 66;
                    while currentPreambleIndex <= signal.getSize()
                       score = score + obj.checkForPreambleInRange(signal, currentPreambleIndex);
                       currentPreambleIndex = currentPreambleIndex + 66;
                    end
                    
                    % zapisanie wyniku
                    potentialPreamblesScores(foundPreamblesRight + foundPreamblesLeft) = score;
                    
                    iterator = iterator + 1;
                end
            end
            
            % znalezienie najlepszego dopasowania
            bestMatchScore = -55555;
            bestMatchIndex = -1;
            for i = 1 : 2*obj.resyncPreamblesToCheck
                if potentialPreamblesScores(i) > bestMatchScore
                    bestMatchScore = potentialPreamblesScores(i);
                    bestMatchIndex = i;
                end
            end
            
            dataIndex = potentialPreamblesIndexes(bestMatchIndex) + 2;
            
        end
    end
    
    methods
        function decodedSignal = decode(obj, signal)
            % czyszczenie poprzednich flag z b³êdami
            obj.errorFlag = false;
            
            signalSize = signal.getSize();
            numberOfFrames = floor(signalSize/66);
            decodedSignal = Signal(numberOfFrames*64);
            
            k = 1; % przechowuje decodedSignal indeks iteratorau
            i = 1;
            while i < signalSize
                % sprawdzenie dla preambu³y
                if signal.getBitAt(i) ~= 0 || signal.getBitAt(i+1) ~= 1
                    obj.errorFlag = true;
                    i = obj.resync(signal, i);
                else
                    i = i + 2;
                end
                    
                limit = i + 64;
                %kopiowanie wszystkich bityów ramki o d³ugoœci 64 bitów
                while  i <= signalSize && i < limit
                    decodedSignal.setBitAt(k, signal.getBitAt(i));
                    k = k + 1;
                    i = i + 1;
                end
            end
        end
        
        function o = wasGood(obj)
            o = not(obj.errorFlag);
        end
        
    end
    
end
        