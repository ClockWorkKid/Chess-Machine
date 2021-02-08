function displayBoard(b)

for i=1:8
    fprintf("%d  ",9-i);
    for j=1:8
        if ~isempty(b.boxes(i,j).ghuti.name)
            fprintf("%c%c ",b.boxes(i,j).ghuti.color,b.boxes(i,j).ghuti.name);
        else 
            fprintf("-- ");
        end
    end
    fprintf("\n");
end

%fprintf("\n");

fprintf("   a  b  c  d  e  f  g  h\n");

end

