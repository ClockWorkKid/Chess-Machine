clear all
close all
clc

b_board = Board;

for k=1:6
    
    board_prev = get_board2(k)
    board_new = get_board2(k+1)
    difference_array = xor(board_prev,board_new)
    non_zero_count=0;
    
    %%to determine whether the move is a 'capture' or not
    [capture,x_array,y_array] = iscapture(difference_array);
    
    %%not capture
    if ~capture
        
        %%to determine whether the move will be 'd2d4' or 'd4d2'
        if board_prev(x_array(1),y_array(1))~=0
            rP = x_array(1);
            cP = y_array(1);
            rN = x_array(2);
            cN = y_array(2);
        elseif board_prev(x_array(2),y_array(2))~=0
            rP = x_array(2);
            cP = y_array(2);
            rN = x_array(1);
            cN = y_array(1);
        end
        
        %checks for legal move
        y = checkLegal(b_board,rP,cP,rN,cN);
        
        %conversion to control system coordinates
        x1 = rP;
        y1 = 8-cP+1;
        x2 = rN;
        y2 = 8-cN+1;
        
        
        
        str1 = RC_to_str(rP,cP,rN,cN); %%converts to move
        
        %capture
    else
        
        rP = x_array(1);
        cP = y_array(1);
        
        for i =1:8
            for j=1:8
                if (board_prev(i,j) == 2 && board_new(i,j) == 1) || (board_prev(i,j) == 1 && board_new(i,j) == 2)
                    rN = i;
                    cN = j;
                end
            end
        end
        
        %checks for legal move
        y = checkLegal(b_board,rP,cP,rN,cN);
        
        %conversion to control system coordinates
        x1 = rP;
        y1 = 8-cP+1;
        x2 = rN;
        y2 = 8-cN+1;
        
        str1 = RC_to_str(rP,cP,rN,cN);
        
        %castling
        %elseif non_zero_count==4
        
    end
    
    b_board.movePiece(b_board,str1)
    pause();
    
end
