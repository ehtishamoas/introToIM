int green = 0;
int red = 0;
const int greenLED = 4;
const int redLED = 3;
const int yellowSwitch = A0; //Right 
const int blueSwitch = A1; //Left
const int LDRPIN = A2;

void setup() {
  Serial.begin(9600);
  Serial.println("0");
  pinMode(greenLED, OUTPUT);
  pinMode(redLED, OUTPUT);
  pinMode(yellowSwitch, INPUT);
  pinMode(blueSwitch, INPUT);
}

void loop() {
  while (Serial.available()) {
    green = Serial.parseInt();
    red = Serial.parseInt();
    if (Serial.read() == '\n') {
      digitalWrite(greenLED, green);
      digitalWrite(redLED, red);
      int stateRight = digitalRead(yellowSwitch);
      delay(1);
      int stateLeft = digitalRead(blueSwitch);
      delay(1);
      int readingLDR = analogRead(LDRPIN);
      delay(1);
      Serial.print(stateRight);
      Serial.print(',');
      Serial.print(stateLeft);
      Serial.print(',');
      Serial.println(readingLDR);
    }
  }
}
