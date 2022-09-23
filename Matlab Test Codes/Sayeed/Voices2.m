clear all;
close all;
clc;

while true
    disp("Receiving voice command...");
    
    cmdPrintout=evalc('system(''activate workshop && python "D:\My Documents\Desktop\Term Project MATLAB\Speech Recognition Python\test.py"'')');
    cmdPrintout=compose(cmdPrintout);
    cmdPrintout=char(cmdPrintout);

    rawData = strsplit(cmdPrintout,'\n');

    voiceToText = char(rawData(1));
    
    disp("Your voice text was ");
    disp(voiceToText);

    rawCommand = '';
    for i = 1:length(voiceToText)
        if voiceToText(i) ~= ' '
            rawCommand = [rawCommand voiceToText(i)];
        end
    end
    
    disp("Your command without spaces is:");
    disp(rawCommand);
    
    if length(rawCommand) == 4
        
        rawCommand = lower(rawCommand); 
        
        if 'a' <= rawCommand(1) && rawCommand(1) <= 'h' &&...
           '1' <= rawCommand(2) && rawCommand(2) <= '8' &&...
            'a' <= rawCommand(3) && rawCommand(3) <= 'h' &&...
            '1' <= rawCommand(4) && rawCommand(4) <= '8'
        disp("Successful voice input. And your command was ");
        disp(rawCommand);
        break;
        end
   
    end
    
    disp("Voice input failed. Please try again.");
    
end


    