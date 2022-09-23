function y = white_stalemate(b,awx,awy)

%STALEMATE CONDITIONS
%Condn 1: The king, at the moment, is not under check
%Condn 2: But where-ever the king moves to next, it will be under check
%Black/White has no legal move

%function returns 1 if stalemate
%xk,yk denote the position of the said king
%this is the stalemate condition, in which case the match is a draw

%find present position of white king
for i=1:8
    for j=1:8
        if b.boxes(i,j).ghuti.name=='k'
            if b.boxes(i,j).ghuti.color=='w'
                xk=i;
                yk=j;
            end
        end
    end
end

%we begin by finding each of the king's possible moves, let's work with the
%white king first

for i=-1:1
    
    if xk==8 && i==1
        continue;
    elseif xk==1 && i==-1
        continue;
    end
    
    for j=-1:1
        
        if yk==1 && j==-1
            continue;
        elseif yk==8 && j==1
            continue;
        end
        
        if isempty(b.boxes(xk+i,yk+j).ghuti.name) %moves white king to new position
            capture = 0;
            b.boxes(xk+i,yk+j).ghuti.name = 'k';
            b.boxes(xk+i,yk+j).ghuti.color = 'w';
            b.boxes(xk,yk).ghuti.name = null(1);
            b.boxes(xk,yk).ghuti.color = null(1);
            
        elseif b.boxes(xk+i,yk+j).ghuti.color == 'b'
            cb = 'b';
            nb = b.boxes(xk+i,yk+j).ghuti.color;
            capture = 1;
            b.boxes(xk+i,yk+j).ghuti.name = 'k';
            b.boxes(xk+i,yk+j).ghuti.color = 'w';
            b.boxes(xk,yk).ghuti.name = null(1);
            b.boxes(xk,yk).ghuti.color = null(1);
        else
            continue;
        end
        
        [awx,awy,abx,aby,tw,tb] = check(b); %%checks if white king is in check in the new position
                
        if tw==1 %%if yes, restore the white king to initial position
            
            if capture == 0
                b.boxes(xk,yk).ghuti.name = 'k';
                b.boxes(xk,yk).ghuti.color = 'w';
                b.boxes(xk+i,yk+j).ghuti.name = null(1);
                b.boxes(xk+i,yk+j).ghuti.color = null(1);
            elseif capture == 1
                b.boxes(xk,yk).ghuti.name = 'k';
                b.boxes(xk,yk).ghuti.color = 'w';
                b.boxes(xk+i,yk+j).ghuti.name = nb;
                b.boxes(xk+i,yk+j).ghuti.color = cb;
            end
            
        elseif tw==0 %%if not, the white king can move to a safe place, so not checkmate, return 0 status
            y=0;
            return;
        end 
    end %%reenters loop with white king in the initial position
end

y=1;
return;

end