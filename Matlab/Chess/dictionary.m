word = 'a1 b2';
temporary = '';
for i = 1:length(word)
    if word(i) ~= ' '
        temporary = [temporary , word(i)];
    end
end


        