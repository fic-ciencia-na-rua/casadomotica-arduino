/*
 * Commificador para Arduino.
 *
 * Parte de Arduino
 *
 * Usage:
 *   Añádase a Arduino una variable global así:
 *   int program_id = 'a';
 */

#ifndef _COMM_H_
#define _COMM_H_

#include <WProgram.h>
#include "constants.h"
#include "ident.h"

class Comm {
public:
	Comm(int prog_id);
	~Comm();
	void on_loop();
	void send(int, int);
	void send(int, char*);

private:
	int prog_id;
};

#endif

