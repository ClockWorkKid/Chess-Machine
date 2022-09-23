classdef Board
    
    properties
        boxes(8,8)=Box;
        countColor;
    end
    
    methods
        function b = Board()
            b.countColor=0;
            for i=1:8
                for j=1:8
                    b.boxes(i,j).row=i;
                    b.boxes(i,j).column=j;
                    if(i==1||i==2)
                        %boxes(2,j).ghuti.name = 'p';
                        b.boxes(i,j).ghuti.color = 'b';
                        if i==2
                            b.boxes(i,j).ghuti.name = 'p';
                        else
                            switch j
                                case {1,8}
                                    b.boxes(i,j).ghuti.name = 'r';
                                case {2,7}
                                    b.boxes(i,j).ghuti.name = 'n';
                                case {3,6}
                                    b.boxes(i,j).ghuti.name = 'b';
                                case 4
                                    b.boxes(i,4).ghuti.name = 'q';
                                otherwise
                                    b.boxes(i,5).ghuti.name = 'k';
                            end
                        end
                    elseif(i==7 || i==8)
                        b.boxes(i,j).ghuti.color = 'w';
                        if i==7
                            b.boxes(i,j).ghuti.name = 'p';
                        else
                            switch j
                                case {1,8}
                                    b.boxes(i,j).ghuti.name = 'r';
                                case {2,7}
                                    b.boxes(i,j).ghuti.name = 'n';
                                case {3,6}
                                    b.boxes(i,j).ghuti.name = 'b';
                                case 4
                                    b.boxes(i,4).ghuti.name = 'q';
                                otherwise
                                    b.boxes(i,5).ghuti.name = 'k';
                            end
                        end
                    end
                end
            end
        end
        displayBoard(b);
        y = checkLegal( b,x1,y1,x2,y2 );
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
                        %fprintf("Asche %d bar, %c guti check kortese,xt=%d,yt=%d\n",count,b.boxes(i,j).ghuti.name,xt,yt);
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
    end
    
    methods(Static)
        function b = movePiece(b,str)
            
            str=lower(str);
            
            colP = double(str(1))-97+1;
            rowP = str(2)-48;
            colN = double(str(3))-97+1;
            rowN = str(4)-48;
            
            %fprintf("%d \n",colP);
            
            x1=8-rowP+1;
            y1=colP;
            x2=8-rowN+1;
            y2=colN;
            
            %[tw,tb]=check(b);
            
            if ~mod(b.countColor,2) && b.boxes(x1,y1).ghuti.color=='w'
                x=1;
            elseif mod(b.countColor,2) && b.boxes(x1,y1).ghuti.color=='b'
                x=1;
            else
                x=0;
            end
            
            if ~x
                fprintf("MOVE PIECE OF OPPOSITE COLOR!! \n");
                displayBoard(b);
                return
            end
            
            
            
%             if mod(b.countcolor,2)==0 && tb  
%                 checkKing='b';
%             elseif mod(b.countcolor,2)==1 && tw
%                 checkKing='w';
%             else 
%                 checkKing='s'
%             end
            
            y=checkLegal(b,x1,y1,x2,y2);
            
            if y
                b.countColor=b.countColor+1;
                b.boxes(x2,y2).ghuti.name = b.boxes(x1,y1).ghuti.name;
                b.boxes(x2,y2).ghuti.color = b.boxes(x1,y1).ghuti.color;
                b.boxes(x1,y1).ghuti.name = null(1);
                b.boxes(x1,y1).ghuti.color = null(1);
                if x2==1 && b.boxes(x2,y2).ghuti.color=='w' && b.boxes(x2,y2).ghuti.name=='p'
                    %fprintf("kaku");
                    f=0;
                    while(1)
                        c=input('Enter transformed white piece ','s');
                        switch c
                            case {'q','n','b','r'}
                                b.boxes(x2,y2).ghuti.name = c;
                                f=1;
                            otherwise
                                fprintf("Invalid Piece, Try again!\n");
                        end
                        if(f==1) break;
                        end
                    end
                end
                if x2==8 && b.boxes(x2,y2).ghuti.color=='b' && b.boxes(x2,y2).ghuti.name=='p'
                    f=0;
                    while(1)
                        c=input('Enter transformed black piece ','s');
                        switch c
                            case {'q','n','b','r'}
                                b.boxes(x2,y2).ghuti.name = c;
                                f=1;
                            otherwise
                                fprintf("Invalid Piece, Try again!\n");
                        end
                        if(f==1) break;
                        end
                    end
                end
                
            else
                fprintf("INVALID MOVE!! TRY AGAIN\n");
            end
            displayBoard(b);
        end
    end
end
