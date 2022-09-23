%% init
clear all
close all
clc
ard = serial('COM5','BaudRate',9600);
fopen(ard);
t = 0.020;

%% Release
fprintf(ard,'%i',0);

%% Grab
fprintf(ard,'%i',5);

%% 2
for i=1:39*8
fprintf(ard,'%i',2);
pause(t);
end

%% 8
for i=1:39*8
fprintf(ard,'%i',8);
pause(t);
end

%% 4
for i=1:43*8
fprintf(ard,'%i',4);
pause(t);
end

%% 6
for i=1:42*8
fprintf(ard,'%i',6);
pause(t);
end

%% 9
for i=1:43*8
fprintf(ard,'%i',9);
pause(t);
end

%% 1
for i=1:43*8
fprintf(ard,'%i',1);
pause(t);
end