/*
 * Identificador para Arduino.
 *
 * Parte de Arduino
 *
 * Usage:
 *   Añádase a Arduino una variable global así:
 *   int program_id = 'a';
 */

#ifndef _IDENT_H_
#define _IDENT_H_

#include <WProgram.h>
#include "constants.h"
#include "ident.h"

class Ident {
public:
	Ident(int prog_id);
	~Ident();
	void on_loop();

private:
	int prog_id;
};

#endif

