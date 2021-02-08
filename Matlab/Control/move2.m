%% init arduino

clear all
close all
clc
ard = serial('COM5','BaudRate',9600);
fopen(ard);

%% move demo

move(ard,5,0);

%% release arduino

fclose(ard);
delete(ard);
clear ard;
