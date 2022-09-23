clear all;
close all;
clc;

a=evalc('system(''activate workshop && python D:\test.py'')');
a=compose(a);
a=char(a);

C = strsplit(a,'\n');
disp(C(1));



