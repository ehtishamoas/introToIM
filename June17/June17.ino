//Student Name: Ehtisham Ul Haq
//Assignment Due Date: June 17, 2021
const int redLED = 6;
const int greenLED = 7;
const int switch1 = A1;

// the setup routine runs once when you press reset:
void setup() {
  pinMode(redLED, OUTPUT);
  pinMode(greenLED, OUTPUT);
  pinMode(switch1, INPUT);
}

// the loop routine runs over and over again forever:
void loop() {
  int sensorValue = analogRead(A2);

  int brightness = map (sensorValue, 0, 1023, 255, 0);
  if (brightness < 100) {
    brightness *= 0.05; //If brightness value is less than 100, make it much lower to see the difference
  }
  Serial.println(brightness);
  //If the switch is on, keep red LED off, and turn on green led if light sensor value is below certain value.
  if (digitalRead(switch1) == HIGH) {
    digitalWrite(redLED, LOW);
    if (sensorValue < 400) {
      digitalWrite(greenLED, HIGH);
    }
    else {
      digitalWrite(greenLED, LOW);
    }
  //If the switch is off, keep green LED off, and vary the brightness of red LED based on light senor value (the lower the value the greater the red LED brightness.  
  } else {
    digitalWrite(greenLED, LOW);
    analogWrite(redLED, brightness);
  }
}
