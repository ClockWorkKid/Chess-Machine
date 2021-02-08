function image=Extraction(I,rMin,rMax,gMin,gMax,bMin,bMax)
R = I(:,:,1);                        
G = I(:,:,2);                       
B = I(:,:,3);

RMin = imbinarize(R,rMin/255);                     
GMin = imbinarize(G,gMin/255);
BMin = imbinarize(B,bMin/255);

% RGBMin = (RMin & GMin & BMin);

RMax= imbinarize(R,rMax/255);
GMax= imbinarize(G,gMax/255);
BMax= imbinarize(B,bMax/255);

% RGBMax= (RMax & GMax & BMax);

Rx = xor(RMin, RMax);
Bx = xor(BMin, BMax);
Gx = xor(GMin, GMax);

image=(Rx & Gx & Bx);

end