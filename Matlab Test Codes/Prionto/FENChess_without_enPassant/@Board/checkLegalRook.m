function y = checkLegalRook(b,x1,y1,x2,y2,dx,dy)

if dx==0 && abs(dy)>0
    if dy>0
        for i=y1+1:y2-1
            if ~isempty(b.boxes(x1,i).ghuti.name)
                y=0;
                return
            end
        end
        y=1;
    else
        for i=y2+1:y1-1
            if ~isempty(b.boxes(x1,i).ghuti.name)
                y=0;
                return
            end
        end
        y=1;
    end
    
elseif dy==0 && abs(dx)>0
    if dx>0
        for i=x1+1:x2-1
            if ~isempty(b.boxes(i,y1).ghuti.name)
                y=0;
                return
            end
        end
        y=1;

    else
        for i=x2+1:x1-1
            if ~isempty(b.boxes(i,y1).ghuti.name)
                y=0;
                return
            end
        end
        y=1;
    end
    
else
    y=0;
    return
end

end

