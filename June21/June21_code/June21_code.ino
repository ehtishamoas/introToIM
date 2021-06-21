//Student Name: Ehtisham Ul Haq
//Assignment Due Date: 21 June, 2021

#include "pitches.h"
const int trigPin = 11;           //connects to the trigger pin on the distance sensor
const int echoPin = 12;           //connects to the echo pin on the distance sensor

const int switchRed = 4;
const int switchGreen = 5;

const int speakerPin = 10;

float distance = 0;               //stores the distance measured by the distance sensor

//Pitch increase alphabetical sequence: c,d,e,f,g,a,b
//So opposite sequence: b,a,g,f,e,d,c
//We are using opposite so that when object is closer, pitch would he higher and when object is far, the pitch would be lowe
int notes1[] = {
  0, NOTE_B5, NOTE_A5, NOTE_G5, NOTE_F5, NOTE_E5, NOTE_D5, NOTE_C5  
};

int notes2[] = {
  0, NOTE_B6, NOTE_A6, NOTE_G6, NOTE_F6, NOTE_E6, NOTE_D6, NOTE_C6  
};

int currentFreq; //stores a particular note value to be used with the tone function
int note; //used as an index to the notes1[] and notes2[] arrays

void setup()
{
  Serial.begin (9600);        //set up a serial connection with the computer

  pinMode(trigPin, OUTPUT);   //the trigger pin will output pulses of electricity
  pinMode(echoPin, INPUT);    //the echo pin will measure the duration of pulses coming back from the distance sensor

  pinMode(switchRed, INPUT); // Red switch will be used to play lower frequency notes (notes1) 

  pinMode(switchGreen, INPUT); // Green switch will be used to play higher frequency notes (notes2) 

  pinMode(speakerPin, OUTPUT); // Speaker will be used along with the tone function and the potentiometer (that will act as variable resistor to control the volume).
}

void loop() {
  distance = getDistance();   //variable to store the distance measured by the sensor

   // Music will only come out if the sensor is within 15 inches of any object:
   
   if (distance > 0 && distance <=15) {
    note = int(map(distance, 0, 15, 1, 8)); //7 notes are played based on the distance of the sensor from the object in front of it.
    
    if (digitalRead(switchRed) == HIGH) { //red switch is used to play notes in notes1[] array
      currentFreq = notes1[note];
      Serial.println(note);
      tone(speakerPin, currentFreq, 1000);
    
    } else if (digitalRead(switchGreen) == HIGH) { //green switch is used to play notes in notes2[] array
      currentFreq = notes2[note];
      Serial.println(note);
      tone(speakerPin, currentFreq, 1000);
    }
   }
}

//RETURNS THE DISTANCE MEASURED BY THE DISTANCE SENSOR
float getDistance()
{
  float echoTime;                   //variable to store the time it takes for a ping to bounce off an object
  float calculatedDistance;         //variable to store the distance calculated from the echo time

  //send out an ultrasonic pulse that's 10ms long
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  echoTime = pulseIn(echoPin, HIGH);      //use the pulsein command to see how long it takes for the
                                          //pulse to bounce back to the sensor

  calculatedDistance = echoTime / 148.0;  //calculate the distance of the object that reflected the pulse (half the bounce time multiplied by the speed of sound)

  return calculatedDistance;              //send back the distance that was calculated
}
