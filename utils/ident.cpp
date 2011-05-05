/*
 * Identificador para Arduino.
 *
 * Parte de Arduino
 *
 * Usage:
 *   Añádase a Arduino una variable global así:
 *   int program_id = 'a';
 */

#include <WProgram.h>
#include "constants.h"
#include "ident.h"

extern int program_id;

Ident::Ident(int prog_id)
{
  this->prog_id = prog_id;
}
Ident::~Ident() {}

void Ident::on_loop()
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

/* -- vim: set sw=2 ts=2 et sts=2: -- */

