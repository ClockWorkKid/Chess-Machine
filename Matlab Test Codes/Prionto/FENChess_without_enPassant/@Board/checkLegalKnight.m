function y = checkLegalKnight(b,dx,dy)
if (abs(dx) == 2 &&  abs(dy) == 1) || (abs(dx)==1 && abs(dy)==2)
    y=1;
    return
else
    y=0;
    return
end
end

