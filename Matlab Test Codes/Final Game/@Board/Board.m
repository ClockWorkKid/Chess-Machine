classdef Board < handle
    
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
        fenString = convert_to_fen(b);
        b = pawnTransform(b,x1,x2,y1,y2);
        y = checkLegal( b,x1,y1,x2,y2 );
        [awx,awy,abx,aby,tw,tb] = check(b);
        [flag] = initial_check(b,x1,y1)
    end
    
    methods(Static)
        function b = movePiece(b,str)
            
%             str=lower(str);
%             
%             colP = double(str(1))-97+1;
%             rowP = str(2)-48;
%             colN = double(str(3))-97+1;
%             rowN = str(4)-48;
%             
%             %fprintf("%d \n",colP);
%             
%             x1=8-rowP+1;
%             y1=colP;
%             x2=8-rowN+1;
%             y2=colN;
%             
%             %[tw,tb]=check(b);
%             
%             [b,z] = castling(b,str);
%             if z
%                 displayBoard(b);
%                 return;
%             end
%             
%             b.countColor=b.countColor+1;
%             
%             b = pawnTransform(b,x1,x2,y1,y2);
%             
%             displayBoard(b);
%             fenString = convert_to_fen(b)
        end
    end
end
