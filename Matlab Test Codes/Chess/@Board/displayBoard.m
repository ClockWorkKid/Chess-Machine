function displayBoard(b)

for i=1:8
    for j=1:8
        if ~isempty(b.boxes(i,j).ghuti.name)
            fprintf("%c%c ",b.boxes(i,j).ghuti.color,b.boxes(i,j).ghuti.name);
        else 
            fprintf("-- ");
        end
    end
    fprintf("\n");
end

end

