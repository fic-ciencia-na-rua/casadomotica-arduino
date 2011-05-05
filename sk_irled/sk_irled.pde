/*
   Casa Domótica 2011
     Sketch para o control dun sistema de intrusión por emisor + receptor IrLED.

Based in work from:
 David A Mellis
 Modified 4 Sep 2010
 By Tom Igoe
 
 http://arduino.cc/en/Tutorial/Calibration
 */
#include <constants.h>
#include <ident.h>

Ident identifier = Ident(PROGRAM_IRLED);

// These constants won't change:
const int sensorPin = A0;    // pin that the sensor is attached to
const int ledPin = 13;        // pin that the LED is attached to

// variables:
int sensorValue = 0;         // the sensor value
int sensorMin = 1023;        // minimum sensor value
int sensorMax = 0;           // maximum sensor value




void setup() {
  bool calibration = true;
  int lastTime = 0;
  const int interval = 250;
  
  
  Serial.begin(9600);
  
  // IrLED Output:
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  digitalWrite(5, HIGH);
  digitalWrite(6, HIGH);
  
  //IrLED Sensor:
  pinMode(A1, OUTPUT);
  digitalWrite(A1, LOW);
  pinMode(A0, INPUT);
  digitalWrite(A0, HIGH); // Turn on pull-up resistor
  
  // turn on LED to signal the start of the calibration period:
  pinMode(13, OUTPUT);
  digitalWrite(13, HIGH);

  // calibrate during the first five seconds 
  while (millis() < 5000) {
    sensorValue = analogRead(sensorPin);
    Serial.println(sensorValue);
    
    if(millis() > (lastTime + interval)) {
      digitalWrite(6, calibration ? true : false);
      calibration = !calibration;
      lastTime = millis();
    }

    // record the maximum sensor value
    if (sensorValue > sensorMax) {
      sensorMax = sensorValue;
    }

    // record the minimum sensor value
    if (sensorValue < sensorMin) {
      sensorMin = sensorValue;
    }
  }

  // signal the end of the calibration period
  digitalWrite(13, LOW);
  digitalWrite(6, LOW);
}

bool triggered = false;

void loop() {
  int rawSensorValue;

  // Get readings for ident
  identifier.on_loop();
  
  // read the sensor:
  rawSensorValue = analogRead(sensorPin);

  // apply the calibration to the sensor reading
  sensorValue = map(rawSensorValue, sensorMin, sensorMax, 0, 255);

  // in case the sensor value is outside the range seen during calibration
  sensorValue = constrain(sensorValue, 0, 255);
  
  triggered = false;
  if(sensorValue > 120)
    triggered = true;
    
  digitalWrite(ledPin, triggered);
  
  Serial.print(rawSensorValue);
  Serial.print(" (");
  Serial.print(sensorValue);
  Serial.println(")");

}

/* -- vim: set sw=2 ts=2 et sts=2 filetype=c: -- */

