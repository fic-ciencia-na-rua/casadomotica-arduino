/*
 * Identificador para Arduino.
 *
 * Parte de Arduino
 *
 * Usage:
 *   Añádase a Arduino una variable global así:
 *   int program_id = 'a';
 */

#include "constants.h"

extern int program_id;

static inline void ident_loop()
{
  int peek;
  if(Serial.avaliable())
  {
    /* Check Query-ID */
    if(Serial.peek() == QUERY_IDENT)
    {
      Serial.read(); /* consumimos ese byte */
      Serial.write(program_id); /* enviamos un byte: program_id */
    }
}

/* -- vim: set sw=2 ts=2 et sts=2: -- */

