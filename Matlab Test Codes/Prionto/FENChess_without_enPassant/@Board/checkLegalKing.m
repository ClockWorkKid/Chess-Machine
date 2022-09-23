function y = checkLegalKing(b,dx,dy)

if (abs(dx)==1 && (abs(dy)==1 || abs(dy)==0)) || (abs(dx)==0 && abs(dy)==1)
    y=1;
else
    y=0;
end

end

