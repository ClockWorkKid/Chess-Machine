function [str1] = castling_availability(b)
%str1 is for storing the castling string 'KQkq'
%uppercase denotes white, k denotes kingside(short castle)
str1 = [];
y=0;

if ~isempty([b.boxes(8,5).ghuti.name]) &&  ~isempty([b.boxes(8,8).ghuti.name])
    short_castle_white = b.boxes(8,5).ghuti.name=='k' && b.boxes(8,5).ghuti.color == 'w' && isempty([b.boxes(8,6).ghuti.name b.boxes(8,7).ghuti.name]) && b.boxes(8,8).ghuti.name=='r' && b.boxes(8,8).ghuti.color == 'w';
else
    short_castle_white = 0;
end

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
            str1 = strcat(str1, '-');
        else
            b.boxes(8,5).ghuti.name = 'k';
            b.boxes(8,5).ghuti.color = 'w';
            b.boxes(8,7).ghuti.name = null(1);
            b.boxes(8,7).ghuti.color = null(1);
            
            b.boxes(8,8).ghuti.name = 'r';
            b.boxes(8,8).ghuti.color = 'w';
            b.boxes(8,6).ghuti.name = null(1);
            b.boxes(8,6).ghuti.color = null(1);       
            str1 = strcat(str1, 'K');
            y=1;
        end
        
    else
        str1 = strcat(str1, '-');
    end
    
else
    str1 = strcat(str1, '-');
end


if ~isempty([b.boxes(8,5).ghuti.name]) &&  ~isempty([b.boxes(8,1).ghuti.name])
    long_castle_white = b.boxes(8,5).ghuti.name =='k' && b.boxes(8,5).ghuti.color == 'w' && isempty([b.boxes(8,2).ghuti.name b.boxes(8,3).ghuti.name b.boxes(8,4).ghuti.name]) && b.boxes(8,1).ghuti.name=='r' && b.boxes(8,1).ghuti.color == 'w';
else
    long_castle_white = 0;
end

if long_castle_white
    
    %fprintf('Dhukse jaygamoton\n');
    
    [awx,awy,abx,aby,tw,tb] = check(b);
    
    if tw==0
        b.boxes(8,2).ghuti.name = 'k';
        b.boxes(8,2).ghuti.color = 'w';
        b.boxes(8,5).ghuti.name = null(1);
        b.boxes(8,5).ghuti.color = null(1);
        
        b.boxes(8,3).ghuti.name = 'r';
        b.boxes(8,3).ghuti.color = 'w';
        b.boxes(8,1).ghuti.name = null(1);
        b.boxes(8,1).ghuti.color = null(1);
        
        
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
            str1 = strcat(str1, '-');
        else
            b.boxes(8,5).ghuti.name = 'k';
            b.boxes(8,5).ghuti.color = 'w';
            b.boxes(8,2).ghuti.name = null(1);
            b.boxes(8,2).ghuti.color = null(1);
            
            b.boxes(8,1).ghuti.name = 'r';
            b.boxes(8,1).ghuti.color = 'w';
            b.boxes(8,3).ghuti.name = null(1);
            b.boxes(8,3).ghuti.color = null(1);
            str1 = strcat(str1, 'Q');
            y=1;
        end
        
    else
        str1 = strcat(str1, '-');
    end
else
    str1 = strcat(str1, '-');
end





if ~isempty([b.boxes(1,5).ghuti.name]) &&  ~isempty([b.boxes(1,8).ghuti.name])
    short_castle_black = b.boxes(1,5).ghuti.name=='k' && b.boxes(1,5).ghuti.color == 'b' && isempty([b.boxes(1,6).ghuti.name b.boxes(1,7).ghuti.name]) && b.boxes(1,8).ghuti.name=='r' && b.boxes(1,8).ghuti.color == 'b';
else
    short_castle_black = 0;
end

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
            str1 = strcat(str1, '-');
        else
            b.boxes(1,5).ghuti.name = 'k';
            b.boxes(1,5).ghuti.color = 'b';
            b.boxes(1,7).ghuti.name = null(1);
            b.boxes(1,7).ghuti.color = null(1);
            
            b.boxes(1,8).ghuti.name = 'r';
            b.boxes(1,8).ghuti.color = 'b';
            b.boxes(1,6).ghuti.name = null(1);
            b.boxes(1,6).ghuti.color = null(1);
            str1 = strcat(str1, 'k');
            y=1;
        end
        
    else
        str1 = strcat(str1, '-');
    end
else
    str1 = strcat(str1, '-');
end




if ~isempty([b.boxes(1,5).ghuti.name]) &&  ~isempty([b.boxes(1,1).ghuti.name])
    
    long_castle_black =  b.boxes(1,5).ghuti.name=='k' && b.boxes(1,5).ghuti.color == 'b' && isempty([b.boxes(1,2).ghuti.name b.boxes(1,3).ghuti.name b.boxes(1,4).ghuti.name]) && b.boxes(1,1).ghuti.name=='r' && b.boxes(1,1).ghuti.color == 'b';
else
    long_castle_black = 0;
end

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
        str1 = strcat(str1, '-');
        
        
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
            str1 = strcat(str1, '-');
        else
            b.boxes(1,5).ghuti.name = 'k';
            b.boxes(1,5).ghuti.color = 'b';
            b.boxes(1,2).ghuti.name = null(1);
            b.boxes(1,2).ghuti.color = null(1);
            
            b.boxes(1,1).ghuti.name = 'r';
            b.boxes(1,1).ghuti.color = 'b';
            b.boxes(1,3).ghuti.name = null(1);
            b.boxes(1,3).ghuti.color = null(1);
            str1 = strcat(str1, 'q');
            y=1;
        end
        
    else
        str1 = strcat(str1, '-');
    end
else
    str1 = strcat(str1, '-');
end


end
