function y = stalemate(xk,yk)

%STALEMATE CONDITIONS
%Condn 1: The king, at the moment, is not under check
%Condn 2: But where-ever the king moves to next, it will be under check

%function returns 1 if stalemate
%xk,yk denote the position of the said king
%this is the stalemate condition, in which case the match is a draw, sucks
%doesn't it?

%we begin by finding each of the king's possible moves, let's work with the
%white king first

big_array_x = [];
big_array_y = [];

for i=-1:1
    for j=-1:1
        
        if isempty(b.boxes(xk+i,yk+j).ghuti.name) || b.boxes(xk+i,yk+j).ghuti.color == 'b' %moves white king to new position
            b.boxes(xk+i,yk+j).ghuti.name = 'k';
            b.boxes(xk+i,yk+j).ghuti.color = 'w';
            b.boxes(xk,yk).ghuti.name = null(1);
            b.boxes(xk,yk).ghuti.color = null(1);
        end
       
        [awx,awy,abx,aby,tw,tb] = check(b); %%checks if white king is in check in the new position
        
        
        if tw==1
            big_array_x = horzcat (big_array_x,awx);
            big_array_y = horzcat (big_array_x,awy);
            
            %%restores white king to previous position
            b.boxes(xk,yk).ghuti.name = 'k';
            b.boxes(xk,yk).ghuti.color = 'w';
            b.boxes(xk+i,yk+j).ghuti.name = null(1);
            b.boxes(xk+i,yk+j).ghuti.color = null(1);
            
        elseif tw==0 %%means white king is not checked by a black piece in its new position,so not stalemate, return 0 status
            y=0;
            return
        end
        
        
    end %%reenters loop with white king in the initial position
end

if range(big_array_x) == 0 && range(big_array_y) == 0
    for i=1:8
        for j=1:8
            if b.boxes(i,j).ghuti.color=='w'
                xi = i;
                yi = j;
                yC=checkLegal(b,xi,yi,big_array_x(1),big_array_y(1));
                if yC
                    y=0; %the black piece can be captured by a white piece, so not checkmate, return 0
                    return;
                end
            end
        end
    end
    y=1;
    return;
else
    y=0;
    return;
end
