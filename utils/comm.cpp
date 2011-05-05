/*
 * Commificador para Arduino.
 *
 * Parte de Arduino
 *
 * Usage:
 *   Añádase a Arduino una variable global así:
 *   int program_id = 'a';
 */

#include <WProgram.h>
#include "constants.h"
#include "comm.h"

extern int program_id;

Comm::Comm(int prog_id)
{
  this->prog_id = prog_id;
}
Comm::~Comm() {}

void Comm::on_loop()
{
  int peek;
  if(Serial.available())
  {
    /* Check Query-ID */
    if(Serial.peek() == QUERY_IDENT)
    {
      Serial.read(); /* consumimos ese byte */
      Serial.write(this->prog_id); /* enviamos un byte: program_id */
    }
  }
}

void Comm::send(int key, int value)
{
  const char STX = 0x02;
  const char ETX = 0x03;
  
  Serial.write(STX);
  Serial.write(key);
  Serial.write(value);
  Serial.write(ETX);
}

void Comm::send(int key, char *value)
{
  const char STX = 0x02;
  const char ETX = 0x03;

  Serial.write(STX);
  Serial.write(key);
  Serial.write(value);
  Serial.write(ETX);
}

/* -- vim: set sw=2 ts=2 et sts=2: -- */

