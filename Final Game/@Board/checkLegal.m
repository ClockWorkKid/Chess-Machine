function y = checkLegal( b,x1,y1,x2,y2 )

%fprintf("%d %d\n%d %d\n",x2, y2, x1, y1);

%fprintf("%c %c\n",b.boxes(x2,y2).ghuti.color, b.boxes(x1,y1).ghuti.color);

%L=b.boxes(x2,y2).ghuti.color == b.boxes(x1,y1).ghuti.color;

%disp(L)
%fprintf("\n");

%fprintf("%c %c\n",b.boxes(x1,y1).ghuti.name,b.boxes(x1,y1).ghuti.color);


if isempty(b.boxes(x1,y1).ghuti.name)
    %fprintf("Dhukse");
    y=0
    return;
end

if (b.boxes(x2,y2).ghuti.color == b.boxes(x1,y1).ghuti.color)
    %fprintf("Dhukse");
    y=0
    return
end

dx = x2-x1;
dy = y2-y1;

%fprintf("%d %d\n",x1,x2);

%fprintf("%c %c\n",b.boxes(x1,y1).ghuti.name,b.boxes(x1,y1).ghuti.color);

switch b.boxes(x1,y1).ghuti.name
    
    case 'r' %ROOK CONDITION
        y=checkLegalRook(b,x1,y1,x2,y2,dx,dy);
        
    case 'b'  %BISHOP CONDITION
        y = checkLegalBishop(b,x1,y1,x2,y2,dx,dy);
        
    case 'n' %KNIGHT CONDITION
        y = checkLegalKnight(b,dx,dy);
        
        
    case 'k' %KING CONDITION
        y = checkLegalKing(b,dx,dy);
        
        
    case 'q' %QUEEN CONDITION
        yi = checkLegalRook(b,x1,y1,x2,y2,dx,dy);
        yj = checkLegalBishop(b,x1,y1,x2,y2,dx,dy);
        y = yi || yj;
        
    case 'p' %PAWN CONDITION
        y = checkLegalPawn(b,x1,y1,x2,y2,dx,dy);
        
end
end