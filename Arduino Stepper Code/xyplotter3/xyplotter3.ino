#include <Servo.h>
#define t 3
int X[] = {2, 3, 4, 5};
int Y[] = {6, 7, 8, 9};
Servo Cursor;
void mX(int dir);
void mY(int dir);
void moveXY(int X, int Y);
void textHandle(int X,int Y, int grab);

void setup() {
  Serial.begin(9600);
  pinMode(2, OUTPUT);
  pinMode(3, OUTPUT);
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  pinMode(7, OUTPUT);
  pinMode(8, OUTPUT);
  pinMode(9, OUTPUT);
  Cursor.attach(12);
  Cursor.write(30);
}

void loop() {
  char c = 0, xdir, ydir,string[12]={0};
  int n = 0, X = 0, Y = 0, grab = 0;
  while (!Serial.available());
  {
    while (1)
    {
      c = Serial.read();
      if (c == 'q')
        break;
      string[n] = c;
      n++;
      while (!Serial.available());
    }
  }

  if (string[0] == 'x' && string[2] == 'y')
  {
    xdir = string[1];
    ydir = string[3];
    for (int i = 4; i < n; i++)
    {
      X = X*10 + string[i] - '0';
      Y = Y*10 + string[i] - '0';
    }
    if (xdir == '-')
      X = -X;
    if (ydir == '-')
      Y = -Y;
  }
  else if (string[0] == 'x')
  {
    xdir = string[1];
    for (int i = 2; i < n; i++)
    {
      X = X*10 + string[i] - '0';
    }
    if (xdir == '-')
      X = -X;
  }
  else if (string[0] == 'y')
  {
    ydir = string[1];
    for (int i = 2; i < n; i++)
    {
      Y = Y*10 + string[i] - '0';
    }
    if (ydir == '-')
      Y = -Y;
  }
  else if (string[0] == 'g')
    grab = 1;
  else if (string[0] == 'r')
    grab = -1;
  else
    return;

  textHandle(X,Y,grab);
}

