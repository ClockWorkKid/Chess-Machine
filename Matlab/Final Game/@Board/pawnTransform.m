function b = pawnTransform (b,x1,x2,y1,y2)

%White Pawn
if x2==1 && b.boxes(x2,y2).ghuti.color=='w' && b.boxes(x2,y2).ghuti.name=='p'
    %fprintf("kaku");
    f=0;
    while(1)
        c=input('Enter transformed white piece ','s');
        switch c
            case {'q','n','b','r'}
                b.boxes(x2,y2).ghuti.name = c;
                f=1;
            otherwise
                fprintf("Invalid Piece, Try again!\n");
        end
        if(f==1) break;
        end
    end
end

%Black Pawn
if x2==8 && b.boxes(x2,y2).ghuti.color=='b' && b.boxes(x2,y2).ghuti.name=='p'
    f=0;
    while(1)
        c=input('Enter transformed black piece ','s');
        switch c
            case {'q','n','b','r'}
                b.boxes(x2,y2).ghuti.name = c;
                f=1;
            otherwise
                fprintf("Invalid Piece, Try again!\n");
        end
        if(f==1) break;
        end
    end
end

end

