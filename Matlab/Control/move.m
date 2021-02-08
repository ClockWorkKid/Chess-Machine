function []=move(ard,dir,step)

if dir == 0
    text = "rq";
    fprintf(ard,"%s",text);
    response = fscanf(ard);
elseif dir == 5
    text = "gq";
    fprintf(ard,"%s",text);
    response = fscanf(ard);
    
elseif dir == 8
    text = convertCharsToStrings(['x-' num2str(step) 'q']);
    fprintf(ard,"%s",text);
    response = fscanf(ard);
elseif dir == 2
    text = convertCharsToStrings(['x+' num2str(step) 'q']);
    fprintf(ard,"%s",text);
    response = fscanf(ard);
elseif dir == 6
    text = convertCharsToStrings(['y-' num2str(step) 'q']);
    fprintf(ard,"%s",text);
    response = fscanf(ard);
elseif dir == 4
    text = convertCharsToStrings(['y+' num2str(step) 'q']);
    fprintf(ard,"%s",text);
    response = fscanf(ard);
    
elseif dir == 1
    text = convertCharsToStrings(['x+y+' num2str(step) 'q']);
    fprintf(ard,"%s",text);
    response = fscanf(ard); 
elseif dir == 3
    text = convertCharsToStrings(['x+y-' num2str(step) 'q']);
    fprintf(ard,"%s",text);
    response = fscanf(ard); 
elseif dir == 7
    text = convertCharsToStrings(['x-y+' num2str(step) 'q']);
    fprintf(ard,"%s",text);
    response = fscanf(ard); 
elseif dir == 9
    text = convertCharsToStrings(['x-y-' num2str(step) 'q']);
    fprintf(ard,"%s",text);
    response = fscanf(ard); 
    

end
