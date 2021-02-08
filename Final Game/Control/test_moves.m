%% Khela shuru
X1 = [7 2 5 1];
Y1 = [6 7 6 7];
X2 = [5 4 4 3];
Y2 = [6 7 7 6];

%%initial servo position
servo_x=4;
servo_y=4;

for i = 1:length(X1)
    if i==3 %%capture move
        move_release(ard,servo_x, X2(i), servo_y, Y2(i));
        pause();
        move_out(ard, X2(i), Y2(i));
        pause();
        move_release(ard, 1, X1(i), 8, Y1(i));
        pause();
        move_grab(ard, X1(i),X2(i),Y1(i),Y2(i));
        pause();
        servo_x=X2(i);
        servo_y=Y2(i);
    else %%non capture
        move_release(ard,servo_x, X1(i), servo_y, Y1(i));
        pause();
        move_grab(ard,X1(i),X2(i),Y1(i),Y2(i));
        %pause(5)
        pause();
        servo_x=X2(i);
        servo_y=Y2(i);
    end
end