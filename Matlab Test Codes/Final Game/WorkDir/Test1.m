clear all; %just my habit
clc;
%import all the java class files
import java.lang.ProcessBuilder;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.BufferedReader;
 
command = 'position startpos'; %dummy command
path = "C:\Users\shafi\OneDrive\Documents\MATLAB\FENChessCheckmate_without_enPassant\WorkDir\stockfish_9.exe"; %setting the path to our engine
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

%functions we will use to send and receive data
%in.ready();
%in.readLine();
%out.println(command);