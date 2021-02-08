function [b,y] = castling(b,str)

y=0;

switch str
    
    case {'e1g1','g1e1'}
        
        %fprintf('Identifier %d\n',2);

        
        short_castle_white = b.boxes(8,5).ghuti.name=='k' && b.boxes(8,5).ghuti.color == 'w' && isempty([b.boxes(8,6).ghuti.name b.boxes(8,7).ghuti.name]) && b.boxes(8,8).ghuti.name=='r' && b.boxes(8,8).ghuti.color == 'w';
        
        if short_castle_white
            
            [awx,awy,abx,aby,tw,tb] = check(b);
            
            if tw==0
                b.boxes(8,7).ghuti.name = 'k';
                b.boxes(8,7).ghuti.color = 'w';
                b.boxes(8,5).ghuti.name = null(1);
                b.boxes(8,5).ghuti.color = null(1);
                
                b.boxes(8,6).ghuti.name = 'r';
                b.boxes(8,6).ghuti.color = 'w';
                b.boxes(8,8).ghuti.name = null(1);
                b.boxes(8,8).ghuti.color = null(1);
            end
            
            [awx,awy,abx,aby,wc,bc] = check(b);
            
            if wc == 1
                fprintf('White king in check!!\n');
                b.boxes(8,5).ghuti.name = 'k';
                b.boxes(8,5).ghuti.color = 'w';
                b.boxes(8,7).ghuti.name = null(1);
                b.boxes(8,7).ghuti.color = null(1);
                
                b.boxes(8,8).ghuti.name = 'r';
                b.boxes(8,8).ghuti.color = 'w';
                b.boxes(8,6).ghuti.name = null(1);
                b.boxes(8,6).ghuti.color = null(1);
            else
                y=1;
                
            end
        end
        
    case {'e1b1','b1e1'}
        
        %fprintf('Identifier %d\n',3);

        
        long_castle_white = b.boxes(8,5).ghuti.name=='k' && b.boxes(8,5).ghuti.color == 'w' && isempty([b.boxes(8,2).ghuti.name b.boxes(8,3).ghuti.name b.boxes(8,4).ghuti.name]) && b.boxes(8,1).ghuti.name=='r' && b.boxes(8,1).ghuti.color == 'w';
        if long_castle_white
            
            fprintf('Dhukse jaygamoton\n');
            
            [awx,awy,abx,aby,tw,tb] = check(b);
            
            if tw==0
                
                b.boxes(8,5).ghuti.name
                b.boxes(8,5).ghuti.color
                
                b.boxes(8,1).ghuti.name
                b.boxes(8,1).ghuti.color
                
                b.boxes(8,2).ghuti.name = 'k';
                b.boxes(8,2).ghuti.color = 'w';
                b.boxes(8,5).ghuti.name = null(1);
                b.boxes(8,5).ghuti.color = null(1);
                
                b.boxes(8,3).ghuti.name = 'r';
                b.boxes(8,3).ghuti.color = 'w';
                b.boxes(8,1).ghuti.name = null(1);
                b.boxes(8,1).ghuti.color = null(1);
            end
            
            [awx,awy,abx,aby,wc,bc] = check(b);
            
            if wc == 1
                fprintf('White king in check!!\n');
                b.boxes(8,5).ghuti.name = 'k';
                b.boxes(8,5).ghuti.color = 'w';
                b.boxes(8,2).ghuti.name = null(1);
                b.boxes(8,2).ghuti.color = null(1);
                
                b.boxes(8,1).ghuti.name = 'r';
                b.boxes(8,1).ghuti.color = 'w';
                b.boxes(8,3).ghuti.name = null(1);
                b.boxes(8,3).ghuti.color = null(1);
            else
                y=1;
                
            end
        end
        
    case {'e8g8','g8e8'}
        
        %fprintf('Identifier %d\n',4);

        
        short_castle_black = b.boxes(1,5).ghuti.name=='k' && b.boxes(1,5).ghuti.color == 'b' && isempty([b.boxes(1,6).ghuti.name b.boxes(1,7).ghuti.name]) && b.boxes(1,8).ghuti.name=='r' && b.boxes(1,8).ghuti.color == 'b';
        if short_castle_black
            
            [awx,awy,abx,aby,tw,tb] = check(b);
            
            if tb==0
                
                b.boxes(1,7).ghuti.name = 'k';
                b.boxes(1,7).ghuti.color = 'b';
                b.boxes(1,5).ghuti.name = null(1);
                b.boxes(1,5).ghuti.color = null(1);
                
                b.boxes(1,6).ghuti.name = 'r';
                b.boxes(1,6).ghuti.color = 'b';
                b.boxes(1,8).ghuti.name = null(1);
                b.boxes(1,8).ghuti.color = null(1);
            end
            
            [awx,awy,abx,aby,wc,bc] = check(b);
            
            if bc == 1
                fprintf('Black king in check!!\n');
                b.boxes(1,5).ghuti.name = 'k';
                b.boxes(1,5).ghuti.color = 'b';
                b.boxes(1,7).ghuti.name = null(1);
                b.boxes(1,7).ghuti.color = null(1);
                
                b.boxes(1,8).ghuti.name = 'r';
                b.boxes(1,8).ghuti.color = 'b';
                b.boxes(1,6).ghuti.name = null(1);
                b.boxes(1,6).ghuti.color = null(1);
            else
                y=1;
                
            end
        end
        
    case {'e8b8','b8e8'}
        
        %fprintf('Identifier %d\n',5);
        
        long_castle_black =  b.boxes(1,5).ghuti.name=='k' && b.boxes(1,5).ghuti.color == 'b' && isempty([b.boxes(1,2).ghuti.name b.boxes(1,3).ghuti.name b.boxes(1,4).ghuti.name]) && b.boxes(1,1).ghuti.name=='r' && b.boxes(1,1).ghuti.color == 'b';
        if long_castle_black
            
           [awx,awy,abx,aby,tw,tb] = check(b);
            
            if tb==0
                
                b.boxes(1,2).ghuti.name = 'k';
                b.boxes(1,2).ghuti.color = 'b';
                b.boxes(1,5).ghuti.name = null(1);
                b.boxes(1,5).ghuti.color = null(1);
                
                b.boxes(1,3).ghuti.name = 'r';
                b.boxes(1,3).ghuti.color = 'b';
                b.boxes(1,1).ghuti.name = null(1);
                b.boxes(1,1).ghuti.color = null(1);
            end
            
            [awx,awy,abx,aby,wc,bc] = check(b);
            
            if bc == 1
                fprintf('Black king in check!!\n');
                b.boxes(1,5).ghuti.name = 'k';
                b.boxes(1,5).ghuti.color = 'b';
                b.boxes(1,2).ghuti.name = null(1);
                b.boxes(1,2).ghuti.color = null(1);
                
                b.boxes(1,1).ghuti.name = 'r';
                b.boxes(1,1).ghuti.color = 'b';
                b.boxes(1,3).ghuti.name = null(1);
                b.boxes(1,3).ghuti.color = null(1);
            else
                y=1;
                
            end
        end
        
    otherwise
       % fprintf('Identifier %d\n',6);
        y=0;
end
end


