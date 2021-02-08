clear all;
close all;
clc;

inputType = input ('For text input, enter 1, For voice input (setup required), enter 2 : ');
%import all the java class files
import java.lang.ProcessBuilder;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.BufferedReader;

path = "D:\My Documents\Desktop\Term Project MATLAB\stockfish.exe"; %setting the path to our engine
%process started
processBuilderObject = ProcessBuilder(path);
process = processBuilderObject.start();
%output stream connected(the commands that we will send)
oStream = process.getOutputStream();
out = PrintWriter(oStream,true);
%input stream connected(the results that engine generates)
iStream = process.getInputStream();
iStreamReader = InputStreamReader(iStream);
in = BufferedReader(iStreamReader);


game = Board ;
game.displayBoard();

if (in.ready())
    in.readLine();
end;

command = 'position startpos moves' ;



while true
    

    while true
        if inputType == 1
            str = input('Your move : ');
        else
            str = voiceInput();
        end
        
        str=lower(str);
            
        colP = double(str(1))-97+1;
        rowP = str(2)-48;
        colN = double(str(3))-97+1;
        rowN = str(4)-48;
            
        x1=8-rowP+1;
        y1=colP;
        x2=8-rowN+1;
        y2=colN;
        
        y=checkLegal(game,x1,y1,x2,y2);
        if y
            game = Board.movePiece(game,str);
            command = [command,' ',str];
            break;
        end
        
    end
    
    out.println(command);
    out.println('go depth 5');
    
    sayeedline = ' ';
    
%     while true
%         if in.ready() == 1
%             break;
%         end;
%     end;
    
    while true
        
        pause(0.2);
        confirmLine = in.ready();
      
    
        if confirmLine
            sayeedline = in.readLine();
        
        else
            disp(sayeedline);
            sayeedline = char(sayeedline);
            engineMove= strsplit(sayeedline,' ');
            
            str = char(engineMove(2));
   
            game = Board.movePiece(game,str);
            command = [command,' ',str];
            break;
        end
    
    end
    
clc;
game.displayBoard();


end;













