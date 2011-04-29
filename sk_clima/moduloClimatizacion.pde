
int keepAlive=13;                              // led pra ver que esta funcionando o sistema (keep alive)

// o da ID:
int idArduino = 'c';                       // identificador do arduino
int inByte = 0;         // incoming serial byte



//CLIMA
boolean clima_encendido;                       // flag que indica se esta o sistema encendido ou non
float clima_gradosReais;                       // grados reais, a temperatura que temos
float clima_gradosDesexados;                   // grados desexados, os grados que queremos
int clima_sensTemperatura = 0;                 // numero pin do sensor temperatura
int clima_calor = 3;                           // led vermelho, calor activada
int clima_frio = 4;                            // led azul, frio activado
boolean clima_emularTemperatura = false;       // flag que indica se emulamos ou non temperatura
float clima_histerese = 0;                     // histerese desexada
int clima_estado = 0;                          // estado da climatizacion:
                                                  // -1 -> frio encendido
                                                  //  0 -> todo apagado
                                                  //  1 -> calor encendido



void setup(){
  Serial.begin(9600);                    // configuramos o porto serie para 9600
  pinMode(clima_calor, OUTPUT);          // configuracion do led de calor como saida
  pinMode(clima_frio, OUTPUT);           // configuracion do led de frio como saida
  pinMode(keepAlive, OUTPUT);            // configuracion do led de keep alive
}



  // esta funcion obten os graos do sensor de temperatura
  // que hai no pin que se lle pasa como parametro
float getGraosSensor(int pinSensor){
          return (5.0 * analogRead(pinSensor) * 100.0)/1024.0;
          
          
          
}



void loop(){
  
  
  // prova do asunto da ID:
  Serial.print("ID: ");
  Serial.println(idArduino);
  
  if (Serial.available() > 0){
    // get incoming byte:

      inByte = Serial.read();
      Serial.print("Recibido: ");
      Serial.println(inByte);
      delay(2000);
    
    delay(20000);
  }
  
  
  
// aqui temos que obter a histeres do PC
        clima_histerese = 2;
// aqui temos que obter os grados desexados do PC
        clima_gradosDesexados = 20;
// aqui temos que obter o dato do PC se queremos climatizacion encendida ou non
        clima_encendido = true;
  
  
  
  
// lemos a temperatura
        if (!clima_emularTemperatura){
          // obtemos os graos
          clima_gradosReais = getGraosSensor(clima_sensTemperatura);
        }
        else{
          // aqui realmente temos que traer os datos do PC
          clima_gradosReais = 20;
        }
        
        
        
  
// comparamos e actuamos en consecuencia
      if (clima_encendido){
          if (clima_gradosReais > (clima_gradosDesexados+clima_histerese)){
            // ponher FRIO
            digitalWrite(clima_frio, HIGH);
            // quitar calor
            digitalWrite(clima_calor, LOW);
            // ponher estado correcto
            clima_estado = -1;
          } else{
            if (clima_gradosReais < (clima_gradosDesexados-clima_histerese) ){
              // ponher CALOR
              digitalWrite(clima_calor, HIGH);
              // quitar frio
              digitalWrite(clima_frio, LOW);
              clima_estado = 1;
            }
            else{
              // desactivar frio e calor
              digitalWrite(clima_frio, LOW);
              digitalWrite(clima_calor, LOW);
              // ponher estado correcto
              clima_estado = 0;
            }
          }
      }
  
// mandar morralla polo porto serie
      Serial.print("Graos: ");
      Serial.println( (byte) clima_gradosReais, DEC);
      Serial.print("Estado: ");
      Serial.println(clima_estado, DEC);

      
// sinal de keep alive e delay de 3 seg en total
  digitalWrite(keepAlive, HIGH);
  delay(1500);
  digitalWrite(keepAlive, LOW);
  delay(1500);
}
