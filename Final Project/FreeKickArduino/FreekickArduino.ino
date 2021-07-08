#include <Servo.h>

Servo myservo;  // create servo object to control a servo

const int AIN1 = 2;           //control pin 1 on the motor driver for the right motor
const int AIN2 = 4;            //control pin 2 on the motor driver for the right motor
const int PWMA = 3;            //speed control pin on the motor driver for the right motor

const int LDRPin = A1;

int pos = 0;                      // stores the servo position

int kick = 0;
int setUP = 0;
int setDOWN = 0;
int setLEFT = 0;
int setRIGHT = 0;

void setup() {
  Serial.begin(9600);
  Serial.println("0");
  myservo.attach(9);
  pinMode(AIN1, OUTPUT);
  pinMode(AIN2, OUTPUT);
  pinMode(PWMA, OUTPUT);
}

void loop() {
  
  while (Serial.available()) {
    
    kick = Serial.parseInt();
    setUP = Serial.parseInt();
    setDOWN = Serial.parseInt();
    setLEFT = Serial.parseInt();
    setRIGHT = Serial.parseInt();
    
    if (Serial.read() == '\n') {
      if (kick == 1 || setUP == 1) {
        digitalWrite(AIN1, LOW);                          //set pin 1 to low
        digitalWrite(AIN2, HIGH);                         //set pin 2 to high
      } else if (setDOWN == 1) {
        digitalWrite(AIN1, HIGH);                          //set pin 1 to low
        digitalWrite(AIN2, LOW); 
      } else {
        digitalWrite(AIN1, LOW);                          //set pin 1 to low
        digitalWrite(AIN2, LOW);                         //set pin 2 to high
      }
      
      if (setUP == 1 || setDOWN == 1) {
         analogWrite(PWMA, 50);
      } else if (kick == 1) {
         analogWrite(PWMA, 255);
      }

      if (setRIGHT == 1) {
        if (pos < 110) {
          pos+=1;
        }
      } else if (setLEFT == 1) {
        if (pos > 0) {
          pos-=1;
        }
      }
      myservo.write(pos);
      Serial.println(analogRead(LDRPin));
    }
  }
}
