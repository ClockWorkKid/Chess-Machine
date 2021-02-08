function [flag,x_array,y_array] = iscapture(d_array)

%%returns 1 if the move is a 'capture' else returns 0

non_zero_count=0;

%counting non zero elements after xor operation
for i = 1:8
    for j=1:8
        if d_array(i,j)~=0
            non_zero_count = non_zero_count+1;
            x_array(non_zero_count) = i;
            y_array(non_zero_count) = j;
        end
    end
end

if non_zero_count==2 
    flag=0;
elseif non_zero_count==1
    flag=1;
end

end

