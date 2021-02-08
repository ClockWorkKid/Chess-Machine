function [awx,awy,abx,aby,tw,tb] = check(b)

%%Outputs: tw is 1 if white king is in check,
%%tb is 1 if black king is in check
%%awx has the x-coordinates of all the opposition black pieces that are checking
%%the white king, awy has the y-coordinates of all the opposition black pieces that are checking
%%the white king
%%abx has the x-coordinates of all the opposition white pieces that are checking
%%the black king, aby has the y-coordinates of all the opposition white pieces that are checking
%%the black king

%%awx(i),awy(i) is the (x,y) co-ordinate of one black piece checking the white king 

%%initialization
awx = 0;
awy = 0;
abx = 0;
aby = 0;

%finds present position of king

for i=1:8
    for j=1:8
        if b.boxes(i,j).ghuti.name=='k'
            if b.boxes(i,j).ghuti.color=='w'
                xw=i;
                yw=j;
            elseif b.boxes(i,j).ghuti.color=='b'
                xb=i;
                yb=j;
            end
        end
    end
end

%fprintf("Position of white king xw=%d,yw=%d\n",xw,yw);

%finds if white king is in check

t=0;
whitecount=0;
for i=1:8          %searches for black piece in board and determines if it checks white king
    for j=1:8
        %fprintf("i=%d,j=%d\n",i,j);
        if b.boxes(i,j).ghuti.color=='b'
            xt=i;
            yt=j;
            yC=checkLegal(b,xt,yt,xw,yw);
            if yC
                whitecount= whitecount+1;
                awx(whitecount) = xt;
                awy(whitecount) = yt;
                t=1;
                break;
            end
        end
    end
end
if t
    tw=1;
else
    tw=0;
end

%%finds if black king is in check

t=0;
blackcount=0;
for i=1:8          %searches for white piece in board and determines if it checks black king
    for j=1:8
        if b.boxes(i,j).ghuti.color=='w'
            xt=i;
            yt=j;
            yC=checkLegal(b,xt,yt,xb,yb);
            if yC
                blackcount = blackcount + 1;
                abx(blackcount) = xt;
                aby(blackcount) = yt;
                t=1;
                break;
            end
        end
    end
end
if t
    tb=1;
else
    tb=0;
end
end