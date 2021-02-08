function y = checkLegalPawn(b,x1,y1,x2,y2,dx,dy)
%fprintf("DHUKSE\n");
%fprintf("%d\n",dx);
if b.boxes(x1,y1).ghuti.color=='w'
    %fprintf("DHUKSE\n");
    if dx>=0
        %fprintf("DHUKSE\n");
        y=0;
        return;
    end
    %fprintf("DHUKSE\n");
    c1=b.boxes(x1,y1).ghuti.color;
    c2=b.boxes(x2,y2).ghuti.color;
    if x1~=7
        %fprintf("%d %d\n",x1,y1);
        if dx==-1
            if abs(dy)==1 && (c1=='w' && c2=='b')
                y=1;
                return;
            elseif dy==0
                y=1;
                return;
            else
                y=0;
            end
        end
        y=0;
    else
        %fprintf("Abar DHUKSE\n");
        if dx==-1
            if abs(dy)==1 && (c1=='w' && c2=='b')
                y=1;
                return;
            elseif dy==0
                y=1;
                return;
            else
                y=0;
            end
        elseif dx==-2
            if dy==0
                y=1;
                return;
            else
                y=0;
            end
        else
            y=0;
        end
    end
elseif b.boxes(x1,y1).ghuti.color=='b'
    if dx<=0
        %fprintf("DHUKSE\n");
        y=0;
        return;
    end
    c1=b.boxes(x1,y1).ghuti.color;
    c2=b.boxes(x2,y2).ghuti.color;
    if x1~=2
        %fprintf("DHUKSE\n");
        %fprintf("%d %d\n%d %d",x1,y1);
        if dx==1
            %fprintf("DHUKSE\n");
            if abs(dy)==1 &&  (c1=='b' && c2=='w')
                y=1;
                return;
            elseif dy==0
                y=1;
                return;
            else
                y=0;
            end
        end
        y=0;
    else
        
        %fprintf("Abar DHUKSE\n");
        if dx==1
            if abs(dy)==1 && (c1=='b' && c2=='w')
                y=1;
                return;
            elseif dy==0
                y=1;
                return;
            else
                y=0;
            end
        elseif dx==2
            if dy==0
                y=1;
                return;
            else
                y=0;
            end
        else
            y=0;
        end
    end
end
end

