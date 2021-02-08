function I6=cropNPad(I)
    I2=imcrop(I,[480 590 100 100]);
I3=padarray(I2(:,:,1),[5 5]);
I4=padarray(I2(:,:,2),[5 5]);
I5=padarray(I2(:,:,3),[5 5]);
I6=cat(3,I3,I4,I5);
end