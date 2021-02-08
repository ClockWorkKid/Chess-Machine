function [delta1,delta2,theta3]=angleCalc(cordPix,wrist)
% arena calibrations
hCam = 56.0; %%%%ALSO CHANGE IN img_process2.m

l = 16;     %distance of arm center from belt

%constants
thX = 50;   %%%%ALSO CHANGE IN img_process2.m
thY = 40;   %%%%ALSO CHANGE IN img_process2.m


%user variables
D2R = pi/180;
R2D = 180/pi;

%arm variable
a1 = 30;
b1 = 10;
c1 = 25;
d1 = 5;

%theta3 variables
x = 2*(hCam-12)*tan(thX/2*D2R); %length of imaginary plane at x axis in cm
y = 2*(hCam-12)*tan(thY/2*D2R); %length of imaginary plane at y axis in cm
d = l+12*tan(D2R*thY/2); % distance of imaginary plane from arm axis

X= (640-cordPix(1))*x/1280.0; %cm
 Y= cordPix(2)*y/960.0+ d; %cm

 
% X= 0.7680;
% Y= 32.3654;
 sqrt(X*X+(Y*Y));
 %delta1 calculation
 rtxy=sqrt((X*X+(Y*Y))+(wrist*wrist));
 temp=(rtxy*rtxy+900-(a1*a1))/(60*rtxy);
 
 P=R2D*atan(wrist/sqrt(X*X+(Y*Y)))+R2D*acos(rtxy/60);
 Q=R2D*atan(2/7);
 q=sqrt(153-(cos(D2R*(90-P-Q))*145.602));
 
 %CHANGED!!!
 %R= R2D*acos((q*q-47)/(q*14.56)));
 
 T=90-Q;
 R= R2D*acos((q*q-47)/(q*14.56));
 if P>T
     R=360-R;
 end;
 
 S=R2D*acos(q/10);
 
 delta1=360-T-R-S;
 
 %delta2 calculation
 C=R2D*acos((900+(a1*a1)-(rtxy*rtxy))/(60*a1));
 D=180-C;
 GK = sqrt(400+(b1*b1)-(cos(D2R*D)*40*b1));
 F= R2D*acos((400-(b1*b1)+(GK*GK))/(40*GK));
 BD = 9.155;
 DL = sqrt(87.41-(79*cos(D2R*delta1)));
 H = 49.874;
 G = R2D*acos((DL*DL+37.41)/(DL*15.8));
 GH=G+H;
 BL = sqrt((DL*DL)+(BD*BD)-2*DL*BD*cos(D2R*GH));
 K = R2D*acos((125-BL*BL)/100);
 II = 180-F-K;
 GL = sqrt((25+(GK*GK)-(10*GK*cos(D2R*II))));
 KLG = R2D*acos((GL*GL+25-(GK*GK))/(10*GL));
 J = R2D*acos((BL*BL-75)/(10*BL));
 AB= 7.280;
 dddd=(25+(BL*BL)-(AB*AB))/(10*BL);
 if dddd>1
     dddd=1;
 end
 M = R2D*acos(dddd);
 N = 180-delta1-G;
 
 %%%%%%%L = 360-KLG-J-M-N; %%%%%%%%%%%%%%%%
 L=360-KLG-(J-M)-N;
 
 GD = sqrt(GL*GL+(DL*DL)-(2*GL*DL*cos(D2R*L)));
 GDL = R2D*acos((GD*GD+(DL*DL)-(GL*GL))/(2*GD*DL));
 GDF = R2D*acos((GD*GD+(d1*d1)-(c1*c1))/(2*d1*GD));
 delta2 = 180-(GDL+GDF+G)
 
 theta3 = 90 - R2D*atan(X/Y)
end

