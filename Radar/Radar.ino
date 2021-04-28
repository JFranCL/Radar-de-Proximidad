// Incluimos las librerías Servo y SR04
#include "Servo.h"
#include "SR04.h"

Servo myServo; // Objeto servo para controlar el Servo Motor

const int TRIG_PIN = 10; // Pin trigger del sensor de ultrasonido
const int ECHO_PIN = 11; // Pin echo del sensor de ultrasonido
SR04 mySr04 = SR04(ECHO_PIN,TRIG_PIN); // Objeto sensor de ultrasonido

int distancia; // Variable para almacenar la distancia
long duration;

void setup() {
   pinMode(TRIG_PIN,OUTPUT);
   pinMode(ECHO_PIN,INPUT);
   Serial.begin(9600); // Iniciamos la comunicación Serie
   myServo.attach(12); // Indicamos en que pin está conectado el servo motor

}

void loop() {

  // Rotamos el servo motor desde 15º a 165º
  for (int i=15; i<165; i++){
    myServo.write(i);
    delay(30);

    distancia = mySr04.Distance(); // Calculamos la distancia

    Serial.print(i); // Enviamos el ángulo al puerto serie
    Serial.print(","); // Caracter de separación, se utilizará para separar la información recibida por el puerto serie
    Serial.print(distancia); // Enviamos la distancia al puerto serie, con un salto de línea
    Serial.print("."); // Caracter de separación, se utilizará para separar la información recibida por el puerto serie
  }

    // Rotamos el servo motor desde 165º a 15º
    for (int i=165; i>15; i--){
    myServo.write(i);
    delay(30);

    distancia = mySr04.Distance(); // Calculamos la distancia

    Serial.print(i); // Enviamos el ángulo al puerto serie
    Serial.print(","); // Caracter de separación, se utilizará para separar la información recibida por el puerto serie
    Serial.print(distancia); // Enviamos la distancia al puerto serie
    Serial.print("."); // Caracter de separación, se utilizará para separar la información recibida por el puerto 
  }

}
