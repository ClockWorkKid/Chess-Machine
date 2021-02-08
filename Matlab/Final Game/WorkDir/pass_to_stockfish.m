function str1 = pass_to_stockfish(fenString)

%import all the java class files
import java.lang.ProcessBuilder;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.BufferedReader;

path = "D:\Workspace\Term Project MATLAB\stockfish.exe"; %setting the path to our engine
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

if (in.ready())
    in.readLine();
end

command = 'position fen' ;
command = [command,' ',fenString];

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
        sayeedline = char(sayeedline);
        engineMove= strsplit(sayeedline,' ');
        str1 = char(engineMove(2));
        break;
    end
    
end

end

