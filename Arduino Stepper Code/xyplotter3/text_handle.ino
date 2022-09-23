void textHandle(int X, int Y, int grab)
{
  if(grab==1)
  Cursor.write(90);
  else if(grab==-1)
  Cursor.write(30);
  else
  {
    if(X!=0 && Y!=0)
    {
      for(int i=0;i<abs(X);i++)
        moveXY(X/abs(X),Y/abs(Y));
    }
    else if(X!=0)
    {
      for(int i=0;i<abs(X);i++)
        moveXY(X/abs(X),0);
    }
    else if(Y!=0)
    {
      for(int i=0;i<abs(Y);i++)
        moveXY(0,Y/abs(Y));
    }    
  }
  Serial.println();
}
