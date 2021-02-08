clear all
close all
clc

b_board = Board;

for k=1:6
    
    board_prev = get_board2(k);
    board_new = get_board2(k+1);
    difference_array = xor(board_prev,board_new);
    non_zero_count=0;
    
    %counting non zero elements after xor operation
    for i = 1:8
        for j=1:8
            if difference_array(i,j)~=0
                non_zero_count = non_zero_count+1;
                x_array(non_zero_count) = i;
                y_array(non_zero_count) = j;
            end
        end
    end
    x_array
    y_array
    
    %%to determine whether the move is a 'capture' or not
    
    %%not capture
    if non_zero_count==2
        
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
        
        str1 = RC_to_str(rP,cP,rN,cN); %%converts to move
        
    %capture    
    elseif non_zero_count == 1
        
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
        
        str1 = RC_to_str(rP,cP,rN,cN);
        
    %%enPassant    
    %%elseif non_zero_count = 0
        
        
    end
    
    b_board.movePiece(b_board,str1)
    pause();
    
end
