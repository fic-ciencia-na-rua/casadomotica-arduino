/**
	Casa Domotica 2011

	Código de test para https://github.com/ssaavedra/casadomotica-daemon/tree/python
**/

#include <constants.h>
#include <comm.h>

Comm comm = Comm(69);

void setup()
{
  Serial.begin(9600);
  pinMode(13, OUTPUT);
  digitalWrite(13, LOW);
  pinMode(8, INPUT);
  pinMode(9, OUTPUT);
  digitalWrite(9, HIGH);
}

void loop()
{
  comm.on_loop();

  digitalWrite(13, digitalRead(8));
  if(digitalRead(8) == HIGH)
  {
    comm.send('Z', 912);
  }
}


/* vim: set filetype=cpp fileencoding=utf-8 et ts=2 sw=2 sts=2 tw=0 : */

