function y = checkLegalKnight(dx,dy)
%fprintf("Dhukse");
if (abs(dx) == abs(dy)+1) || (abs(dx)==abs(dy)-1)
    y=1;
else
    y=0;
end
end

