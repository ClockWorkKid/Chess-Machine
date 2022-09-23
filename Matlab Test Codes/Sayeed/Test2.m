clear all;
close all;
clc;

command = 'system(''activate workshop && python D:\test.py'');';

a = evalc(command) 