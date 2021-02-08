function [flag] = initial_check(b,x1,y1)

%returns 1 if inital check is okay else returns 0
flag=1;
if ~isempty(b.boxes(x1,y1).ghuti.name)
    
    no_piece=0;
    if ~mod(b.countColor,2) && b.boxes(x1,y1).ghuti.color=='w'
        x=1;
    elseif mod(b.countColor,2) && b.boxes(x1,y1).ghuti.color=='b'
        x=1;
    else
        x=0;
    end
    
    if ~x
        flag=0;
        fprintf("MOVE PIECE OF OPPOSITE COLOR!! \n");
        displayBoard(b);
        return
    end
    
else
    flag=0;
    fprintf("NO PIECE IN THIS POSITION!!! TRY AGAIN\n");
    no_piece=1;
end

if no_piece
    displayBoard(b);
    return
end

end

