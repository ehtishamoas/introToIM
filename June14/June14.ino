/* Student Name: Ehtisham Ul Haq
 *  Assignment Due Date: June 14, 2021
 *  Puzzle goal: Figure out how to turn on Red,Green, and Blue LED lights individually using a combination of switches.
*/
const int greenSwitch = 2;
const int yellowSwitch = 3;
const int redSwitch = 4;
const int blueLEDPin = 9;
const int greenLEDPin = 10;
const int redLEDPin = 11;

// the setup routine runs once when you press reset:
void setup() {
  // making switches' pins inputs and LED's pins outputs:
  pinMode(greenSwitch, INPUT);
  pinMode(yellowSwitch, INPUT);
  pinMode(redSwitch, INPUT);
  pinMode(blueLEDPin, OUTPUT);
  pinMode(greenLEDPin, OUTPUT);
  pinMode(redLEDPin, OUTPUT);
}

// the loop routine runs over and over again forever:
void loop() {
  // read the input pins:
  int state1 = digitalRead(greenSwitch);
  int state2 = digitalRead(yellowSwitch);
  int state3 = digitalRead(redSwitch);

  //Set pattern for puzzle:
  
  if (state1 == HIGH && (state2 == LOW && state3  == LOW)) {
    digitalWrite(redLEDPin, HIGH);
    digitalWrite(greenLEDPin, HIGH);
    digitalWrite(blueLEDPin, LOW);
    
  } else if (state2 == HIGH && (state1 == LOW && state3  == LOW)) {
    digitalWrite(redLEDPin, LOW);
    digitalWrite(greenLEDPin, HIGH);
    digitalWrite(blueLEDPin, HIGH);
  } else if (state3 == HIGH && (state1 == LOW && state2  == LOW)) {
    digitalWrite(redLEDPin, HIGH);
    digitalWrite(greenLEDPin, LOW);
    digitalWrite(blueLEDPin, HIGH);

    /*Pattern to notice: Green switch turns on Red and Green LEDs
     *                   Yellow switch turns on Green and Blue LEDs
     *                   Red switch turns on Red and Blue LEDs
    
     *HOW TO TURN ON INDIVIDUAL LEDS??? 
     
     *Solution: Find commons: Switches G and Y -> LED G is common
     *                        Swicthes G and R -> LED R is common
     *                        Switches Y and R -> LED B is common
      */
  } else if ((state1 == HIGH && state2 == HIGH) && state3  == LOW) {
    digitalWrite(redLEDPin, LOW);
    digitalWrite(greenLEDPin, HIGH);
    digitalWrite(blueLEDPin, LOW);
  } else if ((state1 == HIGH && state3 == HIGH) && state2  == LOW) {
    digitalWrite(redLEDPin, HIGH);
    digitalWrite(greenLEDPin, LOW);
    digitalWrite(blueLEDPin, LOW);
  } else if ((state2 == HIGH && state3 == HIGH) && state1  == LOW) {
    digitalWrite(redLEDPin, LOW);
    digitalWrite(greenLEDPin, LOW);
    digitalWrite(blueLEDPin, HIGH);
  } else if ((state1 == LOW && state2 == LOW) && state3  == LOW) {
    digitalWrite(redLEDPin, LOW);
    digitalWrite(greenLEDPin, LOW);
    digitalWrite(blueLEDPin, LOW);
  } else if ((state1 == HIGH && state2 == HIGH) && state3  == HIGH) {
    digitalWrite(redLEDPin, HIGH);
    digitalWrite(greenLEDPin, HIGH);
    digitalWrite(blueLEDPin, HIGH);
  }
}
