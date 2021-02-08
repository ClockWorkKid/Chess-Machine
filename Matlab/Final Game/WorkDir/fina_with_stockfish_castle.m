clear all
close all
clc

%%
cam = init_webcam();
I= snapshot(cam);
imshow(I);

%% 
calibrate_samples3(I);

%% init arduino
ard = serial('COM5','BaudRate',9600);
fopen(ard);

%%
servo_x=4;
servo_y=4;
b_board = Board;
board_prev = zeros(8);
board_prev(1:2,:)=2;
board_prev(7:8,:)=1;
while true
    
    while true
        input('Take pix after your move: ');
        board_new = get_board3(snapshot(cam));
        satisfaction_2 = input('Are you satisfied? ');
        if satisfaction_2
           break;
        end
    end
    
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
        flag = initial_check(b_board,rP,cP);
        if ~flag
            %move guti to previous position by robot
            continue;
        end
        y = checkLegal(b_board,rP,cP,rN,cN);
        
        x1=rP;
        y1=cP;
        x2=rN;
        y2=cN;
        
        if y
            b_board.boxes(x2,y2).ghuti.name = b_board.boxes(x1,y1).ghuti.name;
            b_board.boxes(x2,y2).ghuti.color = b_board.boxes(x1,y1).ghuti.color;
            b_board.boxes(x1,y1).ghuti.name = null(1);
            b_board.boxes(x1,y1).ghuti.color = null(1);
            [awx,awy,abx,aby,wc,bc] = check(b_board);
            
            if mod(b_board.countColor,2) == 0
                if wc == 1
                    %move guti to prev position by robot
                    fprintf('This move will leave your king in check!!\n');
                    b_board.boxes(x1,y1).ghuti.name = b_board.boxes(x2,y2).ghuti.name;
                    b_board.boxes(x1,y1).ghuti.color = b_board.boxes(x2,y2).ghuti.color;
                    b_board.boxes(x2,y2).ghuti.name = null(1);
                    b_board.boxes(x2,y2).ghuti.color = null(1);
                    displayBoard(b_board);
                    continue;
                elseif bc==1
                    %checkmate condn
                    flag = black_checkmate(b_board,abx,aby);
                    if flag
                        fprintf('White has won the game.\n');
                        pause();
                    end
                end
                
            elseif mod(b_board.countColor,2) == 1
                if bc==1
                    %move guti to prev position by robot
                    fprintf('This move will leave your king in check!!\n');
                    b_board.boxes(x1,y1).ghuti.name = b_board.boxes(x2,y2).ghuti.name;
                    b_board.boxes(x1,y1).ghuti.color = b_board.boxes(x2,y2).ghuti.color;
                    b_board.boxes(x2,y2).ghuti.name = null(1);
                    b_board.boxes(x2,y2).ghuti.color = null(1);
                    displayBoard(b_board);
                    continue;
                elseif wc == 1
                    %checkmate condn
                    flag = white_checkmate(b_board,awx,awy);
                    if flag
                        fprintf('Black has won the game.\n');
                        pause();
                    end
                end
            end
        else
            fprintf('Invalid Move!!! TRY AGAIN.')
            displayBoard(b_board);
            continue;
        end
        
        b_board.countColor=b_board.countColor+1;
        
        b_board = pawnTransform(b_board,x1,x2,y1,y2);
        
        displayBoard(b_board);
        fenString = convert_to_fen(b_board)
        
        %%passing fen to stockfish
        str2 = pass_to_stockfish(fenString)
        str2=lower(str2);
        
        colP = double(str2(1))-97+1;
        rowP = str2(2)-48;
        colN = double(str2(3))-97+1;
        rowN = str2(4)-48;
        xi=8-rowP+1;
        yi=8-colP+1;
        xf=8-rowN+1;
        yf=8-colN+1;
        
        x_1=8-rowP+1;
        y_1=colP;
        x_2=8-rowN+1;
        y_2=colN;
        
        if str2=='e8g8'
            move_release(ard,servo_x,xi,servo_y,yi);
            move_grab(ard,xi,xf,yi,yf+1);
            move_grab(ard,xf,xi,yf,yi);
            move_grab(ard,xf,xf,yf+1,yf);
            servo_x=xf;
            servo_y=yf;
            b_board.boxes(x_2,y_2).ghuti.name = 'k';
            b_board.boxes(x_1,y_1).ghuti.name = 'r';
            continue;
        elseif str2=='e8a8'
            move_release(ard,servo_x,xi,servo_y,yi);
            move_grab(ard,xi,xf,yi,yf-1);
            move_grab(ard,xf,xi,yf,yi);
            move_grab(ard,xf,xf,yf-1,yf);
            servo_x=xf;
            servo_y=yf;
            b_board.boxes(x_2,y_2).ghuti.name = 'k';
            b_board.boxes(x_1,y_1).ghuti.name = 'r';
            continue;
        end
        
        capture=0;
        if ~isempty(b_board.boxes(x_2,y_2).ghuti.color)
            if b_board.boxes(x_1,y_1).ghuti.color == b_board.boxes(x_2,y_2).ghuti.color
                capture=0;
            else
                capture=1;
            end
        end
        
        %[capture,x_array,y_array] = iscapture(difference_array);
        if ~capture
            move_release(ard,servo_x,xi,servo_y,yi);
            move_grab(ard,xi,xf,yi,yf);
            servo_x=xf;
            servo_y=yf;
        else
            move_release(ard,servo_x,xf,servo_y,yf);
            move_out(ard,xf,yf);
            move_release(ard,1,xi,8,yi);
            move_grab(ard,xi,xf,yi,yf);
            servo_x=xf;
            servo_y=yf;
        end
             
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
        flag = initial_check(b_board,rP,cP);
        if ~flag
            continue;
        end
        y = checkLegal(b_board,rP,cP,rN,cN);
        
        x1=rP;
        y1=cP;
        x2=rN;
        y2=cN;
        
        if y
            b_board.boxes(x2,y2).ghuti.name = b_board.boxes(x1,y1).ghuti.name;
            b_board.boxes(x2,y2).ghuti.color = b_board.boxes(x1,y1).ghuti.color;
            b_board.boxes(x1,y1).ghuti.name = null(1);
            b_board.boxes(x1,y1).ghuti.color = null(1);
            [awx,awy,abx,aby,wc,bc] = check(b_board);
            
            if mod(b_board.countColor,2) == 0
                if wc == 1
                    fprintf('This move will leave your king in check!!\n');
                    b_board.boxes(x1,y1).ghuti.name = b_board.boxes(x2,y2).ghuti.name;
                    b_board.boxes(x1,y1).ghuti.color = b_board.boxes(x2,y2).ghuti.color;
                    b_board.boxes(x2,y2).ghuti.name = null(1);
                    b_board.boxes(x2,y2).ghuti.color = null(1);
                    displayBoard(b_board);
                    continue;
                elseif bc==1
                    %checkmate condn
                    flag = black_checkmate(b_board,abx,aby);
                    if flag
                        fprintf('White has won the game.\n');
                        pause();
                    end
                end
                
            elseif mod(b_board.countColor,2) == 1
                if bc==1
                    fprintf('This move will leave your king in check!!\n');
                    b_board.boxes(x1,y1).ghuti.name = b_board.boxes(x2,y2).ghuti.name;
                    b_board.boxes(x1,y1).ghuti.color = b_board.boxes(x2,y2).ghuti.color;
                    b_board.boxes(x2,y2).ghuti.name = null(1);
                    b_board.boxes(x2,y2).ghuti.color = null(1);
                    displayBoard(b_board);
                    continue;
                elseif wc == 1
                    %checkmate condn
                    flag = white_checkmate(b_board,awx,awy);
                    if flag
                        fprintf('Black has won the game.\n');
                        pause();
                    end
                end
            end
        end
        
        b_board.countColor=b_board.countColor+1;
        
        b_board = pawnTransform(b_board,x1,x2,y1,y2);
        
        displayBoard(b_board);
        fenString = convert_to_fen(b_board)
        
        %%passing fen to stockfish
        str2 = pass_to_stockfish(fenString)
        str2=lower(str2);
        
        colP = double(str2(1))-97+1;
        rowP = str2(2)-48;
        colN = double(str2(3))-97+1;
        rowN = str2(4)-48;
        xi=8-rowP+1;
        yi=8-colP+1;
        xf=8-rowN+1;
        yf=8-colN+1;
        
        x_1=8-rowP+1;
        y_1=colP;
        x_2=8-rowN+1;
        y_2=colN;
        
        capture=0;
        if ~isempty(b_board.boxes(x_2,y_2).ghuti.color)
            if b_board.boxes(x_1,y_1).ghuti.color == b_board.boxes(x_2,y_2).ghuti.color
                capture=0;
            else
                capture=1;
            end
        end
        
       % [capture,x_array,y_array] = iscapture(difference_array);
        if ~capture
            move_release(ard,servo_x,xi,servo_y,yi);
            move_grab(ard,xi,xf,yi,yf);
            servo_x=xf;
            servo_y=yf;
        else
            move_release(ard,servo_x,xf,servo_y,yf);
            move_out(ard,xf,yf);
            move_release(ard,1,xi,8,yi);
            move_grab(ard,xi,xf,yi,yf);
            servo_x=xf;
            servo_y=yf;
        end
                
        %castling
        %elseif non_zero_count==4
        
    end
    
    board_prev=board_new
   
    while true
        input('Take pix after stockfish move: ');
        board_new = get_board3(snapshot(cam));
        satisfaction_2 = input('Are you satisfied? ');
        if satisfaction_2
           break;
        end
    end
    
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
        
        
        x_1=rP;
        y_1=cP;
        x_2=rN;
        y_2=cN;
        
        b_board.boxes(x_2,y_2).ghuti.name = b_board.boxes(x_1,y_1).ghuti.name;
        b_board.boxes(x_2,y_2).ghuti.color = b_board.boxes(x_1,y_1).ghuti.color;
        b_board.boxes(x_1,y_1).ghuti.name = null(1);
        b_board.boxes(x_1,y_1).ghuti.color = null(1);
            
        
        b_board.countColor=b_board.countColor+1;
        
        %b_board = pawnTransform(b_board,x1,x2,y1,y2);
        
        displayBoard(b_board);
        pause();
        fenString = convert_to_fen(b_board)
        
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
        
        
        x_1=rP;
        y_1=cP;
        x_2=rN;
        y_2=cN;
        
        b_board.boxes(x_2,y_2).ghuti.name = b_board.boxes(x_1,y_1).ghuti.name;
        b_board.boxes(x_2,y_2).ghuti.color = b_board.boxes(x_1,y_1).ghuti.color;
        b_board.boxes(x_1,y_1).ghuti.name = null(1);
        b_board.boxes(x_1,y_1).ghuti.color = null(1);
          
        
        b_board.countColor=b_board.countColor+1;
        
        %b_board = pawnTransform(b_board,x1,x2,y1,y2);
        
        displayBoard(b_board);
        pause();
        fenString = convert_to_fen(b_board)
                
        %castling
        %elseif non_zero_count==4
        
    end
    
    board_prev=board_new
    pause();
    
end

%% release arduino

fclose(ard);
delete(ard);
clear ard;