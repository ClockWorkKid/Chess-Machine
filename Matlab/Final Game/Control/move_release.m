function move_release(ard,x1,x2,y1,y2)

move(ard,0,0);
pause(0.1);

move(ard,9,21);

delta_x = abs(x2-x1)
delta_y = abs(y2-y1)

if x1>x2
    move(ard,8,42*delta_x);
else
    move(ard,2,39*delta_x);

%     for k=1:delta_x
%         move(ard,2,39);
%         move(ard,6,3);
%     end
end

if y1>y2
    move(ard,6,45*delta_y);
else
    move(ard,4,43*delta_y);
end

move(ard,1,18);

move(ard,5,0); %%grab hoise kina dekhar jonno
pause(0.1);

%niche giya ghuraghuri
move(ard,7,10);
move(ard,6,20);
move(ard,2,20);
move(ard,4,20);
move(ard,9,10);

satisfaction=0;
while satisfaction~=1
    
direction = input('Which direction? ');
loopcount = input('How many steps? ');

move(ard,direction,loopcount);
satisfaction = input('Are you satisfied? Press 1 for yes, 0 for no');

end
end

