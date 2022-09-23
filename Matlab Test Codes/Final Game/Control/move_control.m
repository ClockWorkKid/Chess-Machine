function move_control(ard,x1,x2,y1,y2)

t=0.02;
fprintf(ard,'%i',5);

for i=1:42*0.5
    fprintf(ard,'%i',9);
    pause(t);
end

delta_x = abs(x2-x1)
delta_y = abs(y2-y1)

if x1>x2
    for i=1:42*delta_x
        fprintf(ard,'%i',8);
        pause(t);
    end
else
    for k=1:delta_x
        for i=1:39
            fprintf(ard,'%i',2);
            pause(t);
        end
        for j=1:3
            fprintf(ard,'%i',6);
            pause(t);
        end
    end
end

if y1>y2
    for i=1:45*delta_y
        fprintf(ard,'%i',6);
        pause(t);
    end
else
    for i=1:43*delta_y
        fprintf(ard,'%i',4);
        pause(t);
    end
end

for i=1:56*0.5
    fprintf(ard,'%i',1);
    pause(t);
end

direction = input('Which direction? ');
loopcount = input('How many steps? ');

for i=1:loopcount*0.5
    fprintf(ard,'%i',direction);
    pause(t);
end

fprintf(ard,'%i',0);

end

