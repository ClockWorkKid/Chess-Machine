function y = black_checkmate(b,abx,aby)

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

%supppose the king under check is black
%find present position of black king
for i=1:8
    for j=1:8
        if b.boxes(i,j).ghuti.name=='k'
            if b.boxes(i,j).ghuti.color=='b'
                xk=i;
                yk=j;
            end
        end
    end
end

% abx
% aby
% xk
% yk
% length(abx)

%%we will first assume that only one white piece is checking the black king
%let us first check whether any black piece can go to awx,awy to capture the
%dustu white piece, otherwise we move the black king to a safe position

if length(abx)==1
    for i=1:8
        for j=1:8
            if b.boxes(i,j).ghuti.color=='b'
                xi = i;
                yi = j;
                yC=checkLegal(b,xi,yi,abx,aby);
                if yC
                    xi;
                    yi;
                    y=0; %the white piece can be captured by a black piece, so not checkmate, return 0
                    return;
                end
            end
        end
    end
    
    %moving black king
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
                b.boxes(xk+i,yk+j).ghuti.color = 'b';
                b.boxes(xk,yk).ghuti.name = null(1);
                b.boxes(xk,yk).ghuti.color = null(1);
                %fprintf('ID 1');
            elseif  b.boxes(xk+i,yk+j).ghuti.color == 'w'
                cw = 'w';
                nw = b.boxes(xk+i,yk+j).ghuti.name;
                capture = 1;
                b.boxes(xk+i,yk+j).ghuti.name = 'k';
                b.boxes(xk+i,yk+j).ghuti.color = 'b';
                b.boxes(xk,yk).ghuti.name = null(1);
                b.boxes(xk,yk).ghuti.color = null(1);
            else
                continue;
            end
            %displayBoard(b);
            %pause();
            [awx,awy,abx,aby,tw,tb] = check(b);
            %             displayBoard(b);
            %             pause();        %%checks if black king is in check in the new position
            if tb==1 %%if yes, restore the black king to initial position
                if capture == 0
                    b.boxes(xk,yk).ghuti.name = 'k';
                    b.boxes(xk,yk).ghuti.color = 'b';
                    b.boxes(xk+i,yk+j).ghuti.name = null(1);
                    b.boxes(xk+i,yk+j).ghuti.color = null(1);
                elseif capture == 1
                    b.boxes(xk,yk).ghuti.name = 'k';
                    b.boxes(xk,yk).ghuti.color = 'b';
                    b.boxes(xk+i,yk+j).ghuti.name = nw;
                    b.boxes(xk+i,yk+j).ghuti.color = cw;
                end
            elseif tb==0 %%if not, the white king can move to a safe place, so not checkmate, return 0 status
                y=0;
                return;
            end
            %             displayBoard(b);
            %             pause();
        end
    end
    y=1; %%if the code reaches this line, that means the outer loop has finished
    %%black king cannot move anywhere, so checkmate, return 1 status
    return;
end

%%now let us suppose the black king is checked by more than one white
%%piece, in that case, there is no point in capturing 1 'checking' white
%%piece by a black piece, since there will always be another white piece
%%checking the black king, so we should concentrate on 'moving the king' only

if length(abx)>=2
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
                b.boxes(xk+i,yk+j).ghuti.color = 'b';
                b.boxes(xk,yk).ghuti.name = null(1);
                b.boxes(xk,yk).ghuti.color = null(1);
            elseif b.boxes(xk+i,yk+j).ghuti.color == 'w'
                cw = 'w';
                nw = b.boxes(xk+i,yk+j).ghuti.name;
                capture = 1;
                b.boxes(xk+i,yk+j).ghuti.name = 'k';
                b.boxes(xk+i,yk+j).ghuti.color = 'b';
                b.boxes(xk,yk).ghuti.name = null(1);
                b.boxes(xk,yk).ghuti.color = null(1);
            else
                continue;
            end
            [awx,awy,abx,aby,tw,tb] = check(b); %%%checks if black king is in check in the new position
            if tb==1 %%if yes, restore the black king to initial position
                if capture == 0
                    b.boxes(xk,yk).ghuti.name = 'k';
                    b.boxes(xk,yk).ghuti.color = 'b';
                    b.boxes(xk+i,yk+j).ghuti.name = null(1);
                    b.boxes(xk+i,yk+j).ghuti.color = null(1);
                elseif capture == 1
                    b.boxes(xk,yk).ghuti.name = 'k';
                    b.boxes(xk,yk).ghuti.color = 'b';
                    b.boxes(xk+i,yk+j).ghuti.name = nw;
                    b.boxes(xk+i,yk+j).ghuti.color = cw;
                end
            elseif tb==0 %%if not, the black king can move to a safe place, so not checkmate, return 0 status
                y=0;
                return;
            end
        end
    end
    y=1; %%if the code reaches this line, that means the outer loop has finished
    %%black king cannot move anywhere, so checkmate, return 1 status
    return;
end

end


