function [tw,tb] = check(b)
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
count=0;
for i=1:8          %searches for black piece in board and determines if it checks white king
    for j=1:8
        %fprintf("i=%d,j=%d\n",i,j);
        if b.boxes(i,j).ghuti.color=='b'
            xt=i;
            yt=j;
            count=count+1;
            yC=checkLegal(b,xt,yt,xw,yw);
            if yC
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
for i=1:8          %searches for white piece in board and determines if it checks black king
    for j=1:8
        if b.boxes(i,j).ghuti.color=='w'
            xt=i;
            yt=j;
            yC=checkLegal(b,xt,yt,xb,yb);
            if yC
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