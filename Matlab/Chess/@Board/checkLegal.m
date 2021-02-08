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
%         if abs(dx)>0 && abs(dy)>0 && abs(dx)==abs(dy)
%             if dy>0 && dx>0
%                 for i=1:y2-y1-1
%                     if ~isempty(b.boxes(x1+i,y1+i).ghuti.name)
%                         y=0;
%                         return
%                     end
%                 end
%                 y=1;
%             elseif dy<0 && dx>0
%                 for i=1:y1-y2-1
%                     if ~isempty(b.boxes(x1+i,y1-i).ghuti.name)
%                         y=0;
%                         return
%                     end
%                 end
%                 y=1;
%             elseif dy>0 && dx<0
%                 for i=1:y2-y1-1
%                     if ~isempty(b.boxes(x2+i,y2-i).ghuti.name)
%                         y=0;
%                         return
%                     end
%                 end
%                 y=1;
%             elseif dy<0 && dx<0
%                 for i=1:y1-y2-1
%                     if ~isempty(b.boxes(x2+i,y2+i).ghuti.name)
%                         y=0;
%                         return
%                     end
%                 end
%                 y=1;
%             end
%             
%         else
%             y=0;
%             return
%         end
%         
%         
%     case 'n' %KNIGHT CONDITION
%         %y = checkLegalKnight(dx,dy);
%         if (abs(dx) == abs(dy)+1) || (abs(dx)==abs(dy)-1)
%             y=1;
%         else
%             y=0;
%         end
        
        
    case 'k' %KING CONDITION
        if (abs(dx)==1 && (abs(dy)==1 || abs(dy)==0)) || (abs(dx)==0 && abs(dy)==1)
            y=1;
        else
            y=0;
        end
        
        
    case 'q' %QUEEN CONDITION
        %fprintf("%d %d\n%d %d",x1,y1,x2,y2);
        
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
        elseif abs(dx)>0 && abs(dy)>0 && abs(dx)==abs(dy)
            %fprintf("Dhukse");
            if dy>0 && dx>0
                for i=1:y2-y1-1
                    if ~isempty(b.boxes(x1+i,y1+i).ghuti.name)
                        y=0;
                        return
                    end
                end
                y=1;
            elseif dy<0 && dx>0
                for i=1:y1-y2-1
                    if ~isempty(b.boxes(x1+i,y1-i).ghuti.name)
                        y=0;
                        return
                    end
                end
                y=1;
            elseif dy>0 && dx<0
                %fprintf("Dhukse");
                for i=1:y2-y1-1
                    if ~isempty(b.boxes(x2+i,y2-i).ghuti.name)
                        y=0;
                        return
                    end
                end
                y=1;
            elseif dy<0 && dx<0
                for i=1:y1-y2-1
                    if ~isempty(b.boxes(x2+i,y2+i).ghuti.name)
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
        
    case 'p' %PAWN CONDITION
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
end