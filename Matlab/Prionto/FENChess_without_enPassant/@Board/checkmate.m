function y = checkmate(b,awx,awy,abx,aby,xk,yk)

%Condn for CHECKMATE: The king is already under check and has nowhere else to move

%function returns 1 if checkmate
%xk,yk denote the position of the king under check

% Variable      Piece      Coordinate     Checks   
     %awx       black           x          white
     %awy       black           y          white
     %abx       white           x          black
     %aby       white           y          black
     
%%awx has the x-coordinates of all the opposition black pieces that are checking
%%the white king, awy has the y-coordinates of all the opposition black pieces that are checking
%%the white king
%%abx has the x-coordinates of all the opposition white pieces that are checking
%%the black king, aby has the y-coordinates of all the opposition white pieces that are checking
%%the black king

%supppose the king under check is white
%%we will first assume that only one black piece is checking the white king
%let us first check whether any white piece can go to awx,awy to capture the
%dustu black piece, otherwise we move the white king to a safe position

if length(awx)==1 
    for i=1:8
        for j=1:8
            if b.boxes(i,j).ghuti.color=='w'
                xi = i;
                yi = j;
                yC=checkLegal(b,xi,yi,awx,awy);
                if yC
                    y=0; %the black piece can be captured by a white piece, so not checkmate, return 0
                    return;
                end
            end
        end
    end
    
    %moving white king
    for i=-1:1
        for j=-1:1
            if isempty(b.boxes(xk+i,yk+j).ghuti.name) || b.boxes(xk+i,yk+j).ghuti.color == 'b' %moves white king to new position
                b.boxes(xk+i,yk+j).ghuti.name = 'k';
                b.boxes(xk+i,yk+j).ghuti.color = 'w';
                b.boxes(xk,yk).ghuti.name = null(1);
                b.boxes(xk,yk).ghuti.color = null(1);
            else
                continue;
            end
            [awx,awy,abx,aby,tw,tb] = check(b); %%%checks if white king is in check in the new position
            if tw==1 %%if yes, restore the white king to initial position
                b.boxes(xk,yk).ghuti.name = 'k';
                b.boxes(xk,yk).ghuti.color = 'w';
                b.boxes(xk+i,yk+j).ghuti.name = null(1);
                b.boxes(xk+i,yk+j).ghuti.color = null(1);
            elseif tw==0 %%if not, the white king can move to a safe place, so not checkmate, return 0 status
                y=0;
                return;
            end
        end
    end
    y=1; %%if the code reaches this line, that means the outer loop has finished
    %%white king cannot move anywhere, so checkmate, return 1 status
    return;
end

%%now let us suppose the white king is checked by more than one black
%%piece, in that case, there is no point in capturing 1 'checking' black
%%piece by a white piece, since there will always be another black piece
%%checking the white king, so we should concentrate on 'moving the king' only

if length(awx)>=2
    for i=-1:1
        for j=-1:1
            if isempty(b.boxes(xk+i,yk+j).ghuti.name) || b.boxes(xk+i,yk+j).ghuti.color == 'b' %moves white king to new position
                b.boxes(xk+i,yk+j).ghuti.name = 'k';
                b.boxes(xk+i,yk+j).ghuti.color = 'w';
                b.boxes(xk,yk).ghuti.name = null(1);
                b.boxes(xk,yk).ghuti.color = null(1);
            else
                continue;
            end
            [awx,awy,abx,aby,tw,tb] = check(b); %%%checks if white king is in check in the new position
            if tw==1 %%if yes, restore the white king to initial position
                b.boxes(xk,yk).ghuti.name = 'k';
                b.boxes(xk,yk).ghuti.color = 'w';
                b.boxes(xk+i,yk+j).ghuti.name = null(1);
                b.boxes(xk+i,yk+j).ghuti.color = null(1);
            elseif tw==0 %%if not, the white king can move to a safe place, so not checkmate, return 0 status
                y=0;
                return;
            end
        end
    end
    y=1; %%if the code reaches this line, that means the outer loop has finished
    %%white king cannot move anywhere, so checkmate, return 1 status
    return;
end


