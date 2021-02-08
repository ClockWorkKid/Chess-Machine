function fenString = convert_to_fen(b)

%%I have assumed the fen string to be like this
%%rnbqkbnr/pp2pppp/2p5/3P4/3P4/8/PPP2PPP/RNBQKBNR b KQkq
%Lower case denotes black, upper case denotes white
%the 'b' means next move 'black'
%last four letters denote castling availability
%if castling is not available there will be a '-' in that position

fenString = [];
empty_count=0;
for i=1:8
    
    for j=1:8
        
        if ~isempty(b.boxes(i,j).ghuti.name)
            
            if empty_count~=0
                fenString = strcat(fenString, num2str(empty_count));
            end
            
            empty_count = 0;
            
            if b.boxes(i,j).ghuti.color == 'w'
                
                fenString = strcat(fenString, upper(b.boxes(i,j).ghuti.name));
                
            elseif b.boxes(i,j).ghuti.color == 'b'
                
                fenString = strcat(fenString, lower(b.boxes(i,j).ghuti.name));
                
            end
            
        else
            empty_count = empty_count+1;
            if j == 8
                fenString = strcat(fenString, num2str(empty_count));
            end
        end
        
    end
    
    if i~=8 
        fenString = strcat(fenString, '/');
    end
    empty_count = 0;
    
end

if mod(b.countColor,2) == 0
    fenString = strcat(fenString, ' w');
else
    fenString = strcat(fenString, ' b');
end

castle_str = castling_availability(b);
fenString = [fenString ' ' castle_str];

end

