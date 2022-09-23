void mX(int dir)
{
  static int pin = 0;
  static int state = 0;
  static int prevdir = 0;
  if (dir > 0)
  {
    if (!state)
    {
      if (prevdir < 0)
      {
        digitalWrite(X[pin], state);
        pin = (pin + 1) % 4;
      }
      else digitalWrite(X[(pin + 3) % 4], state);
    }
    else
    {
      pin = (pin + 1) % 4;
      digitalWrite(X[pin], state);
    }
    state = !state;
    prevdir = dir;
  }
  else if (dir < 0)
  {
    if (!state)
    {
      if (prevdir > 0)
      {
        digitalWrite(X[pin], state);
        pin = (pin + 3) % 4;
      }
      else digitalWrite(X[(pin + 1) % 4], state);
    }
    else
    {
      pin = (pin + 3) % 4;
      digitalWrite(X[pin], state);
    }
    state = !state;
    prevdir = dir;
  }
}


void mY(int dir)
{
  static int pin = 0;
  static int state = 0;
  static int prevdir = 0;
  if (dir > 0)
  {
    if (!state)
    {
      if (prevdir < 0)
      {
        digitalWrite(Y[pin], state);
        pin = (pin + 1) % 4;
      }
      else digitalWrite(Y[(pin + 3) % 4], state);
    }
    else
    {
      pin = (pin + 1) % 4;
      digitalWrite(Y[pin], state);
    }
    state = !state;
    prevdir = dir;
  }
  else if (dir < 0)
  {
    if (!state)
    {
      if (prevdir > 0)
      {
        digitalWrite(Y[pin], state);
        pin = (pin + 3) % 4;
      }
      else digitalWrite(Y[(pin + 1) % 4], state);
    }
    else
    {
      pin = (pin + 3) % 4;
      digitalWrite(Y[pin], state);
    }
    state = !state;
    prevdir = dir;
  }
}


void moveXY(int X, int Y)
{
  for (int i = 0; i < 8; i++)
  {
    mX(X);
    mY(Y);
    delay(t);
  }
}
