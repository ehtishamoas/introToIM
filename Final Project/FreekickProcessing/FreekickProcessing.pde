import processing.serial.*;
import processing.sound.*;

Serial myPort;  // The serial port

boolean isKicking = false;
boolean settingUP = false;
boolean settingDOWN = false;
boolean settingLEFT = false;
boolean settingRIGHT = false;
boolean isSetting = false;
boolean isReady = false;
boolean timeReading = false;
boolean readingTaken = false;
boolean shotTaken = false;
boolean goalScored = false;
boolean goalScreen = false;
boolean goalSfx = false;
boolean gameEndSfx = false;

long startTime;
long movingTime;

int state = 0;
/*
 state = 0: display startscreen;
 state = 1: display instructionsScreen;
 state = 2: display tossScreen;
 state = 3: start the game;
 state = 4: display gameOverScreen;
 */

int turn = int(random(0, 2));
// turn = 0: RED;
// turn = 1: BLUE;

int shots0 = 5;
int shots1 = 5;

int score0 = 0;
int score1 = 0;

ArrayList<Integer> shotsRed = new ArrayList<Integer>();
ArrayList<Integer> shotsBlue = new ArrayList<Integer>();

float LDRreading;

PImage startScreen, instructionsScreen, tossScreen, fieldScreen, statsScreen;
SoundFile backgroundSound, enterSound, gameOverSound, goalSound, goalMissedSound, whistleSound;

void setup() {
  size(1366, 768);

  String portname=Serial.list()[0];
  myPort = new Serial(this, portname, 9600);
  myPort.clear();
  myPort.bufferUntil('\n');

  startScreen = loadImage("/images/startScreen.jpg");
  instructionsScreen = loadImage("/images/instructionsScreen.png");
  tossScreen = loadImage("/images/toss.jpg");
  fieldScreen = loadImage("/images/field1.png");
  statsScreen = loadImage("/images/statsScreen.png");

  backgroundSound = new SoundFile(this, "/sounds/bg.mp3");
  enterSound = new SoundFile(this, "/sounds/enter.mp3");
  gameOverSound = new SoundFile(this, "/sounds/gameEnd.mp3");
  goalSound = new SoundFile(this, "/sounds/goal.mp3");
  goalMissedSound = new SoundFile(this, "/sounds/goalMiss.mp3");
  whistleSound = new SoundFile(this, "/sounds/whistle.mp3");

  backgroundSound.play();
  backgroundSound.loop();
}

void draw() {
  if (state == 0) {
    startScreen();
  } else if (state == 1) {
    instructions();
  } else if (state == 2) {
    toss();
  } else if (state == 3) {
    game();
  } else if (state == 4) {
    gameOver();
  }
} 

void startScreen() {
  image(startScreen, 0, 0, width, height+100);
  PFont algerian = createFont("algerian", 70);
  textFont(algerian);
  fill (255);
  text("Free-kick Football", width/3.8, height/5);
  algerian = createFont("algerian", 40);
  textFont(algerian);
  text("Press Enter to continue...", width/3, height/3);
}

void instructions() {
  image(instructionsScreen, 0, 0, width, height);
}

void toss() {
  image(tossScreen, 0, 0, width, height);
  PFont algerian = createFont("algerian", 35);
  textFont(algerian);
  if (turn == 0) {

    fill(0);
    text("Player", width/2.1, height/1.4);
    fill (255, 0, 40);
    text("RED", width/1.72, height/1.4);
    fill (0);
    text("will take the first shot!", width/1.57, height/1.4);
  } else {
    fill(0);
    text("Player", width/2.1, height/1.4);
    fill (40, 0, 255);
    text("Blue", width/1.72, height/1.4);
    fill (0);
    text("will take the first shot!", width/1.53, height/1.4);
  }
  text("Press Enter to continue...", width/1.8, height/1.25);
}

void game() {
  println("LDR: " + LDRreading);
  if (shots0 == 0 && shots1 == 0) {
    state = 4;
    gameEndSfx = true;
  } else {
    if (!shotTaken) {

      isSetting = true;
      displayField();

      if (isReady) {
        if (timeReading) {
          startTime = millis()/1000;
          movingTime = millis()/1000;
          readingTaken = true;
        } 
        timeReading = false;
        if (movingTime-startTime <= 12 && !goalScored) {
          if (movingTime-startTime <= 10) { //Player will be shown 10 seconds time but 2 seconds will be extra since ball takes time to reach LDR;
            PFont algerian = createFont("algerian", 30);
            textFont(algerian);
            fill (0);
            text("Remaining Time: " + (10-(movingTime-startTime)), width/2.5, height/10);
          }

          if (LDRreading <= 140) {
            goalScored = true;
          }
          movingTime = millis()/1000;
          goalScreen = true;
          goalSfx = true;
          return;
        }

        if (turn == 0) {
          if (goalScored) {
            if (goalSfx) {
              goalSound.play();
              goalSfx = false;
            }  
            if (goalScreen) {
              PImage goalScreen = loadImage("/images/goal.png");
              image(goalScreen, 0, 0, width, height);
              return;
            }
            score0++;
            shots0--;
            shotsRed.add(1);
          } else {
            if (goalSfx) {
              goalMissedSound.play();
              goalSfx = false;
            }  
            if (goalScreen) {
              PImage goalScreen = loadImage("/images/goalMissed.png");
              image(goalScreen, 0, 0, width, height);
              return;
            }
            shots0--;
            shotsRed.add(0);
          }
        } else {
          if (goalScored) {
            if (goalSfx) {
              goalSound.play();
              goalSfx = false;
            }
            if (goalScreen) {
              PImage goalScreen = loadImage("/images/goal.png");
              image(goalScreen, 0, 0, width, height);
              return;
            }
            score1++;
            shots1--;
            shotsBlue.add(1);
          } else {
            if (goalScreen) {
              if (goalSfx) {
                goalMissedSound.play();
                goalSfx = false;
              }  
              PImage goalScreen = loadImage("/images/goalMissed.png");
              image(goalScreen, 0, 0, width, height);
              return;
            }
            shots1--;
            shotsBlue.add(0);
          }
        }

        displayStats();
        PFont algerian = createFont("algerian", 50);
        textFont(algerian);
        text ("Press Enter to continue...", width/3.8, height/1.2);

        turn = (turn + 1) % 2;
        goalScored = false;
        isSetting = false;
        readingTaken = false;
        shotTaken = true;
        isReady = false;
      }
    }
  }
}

void displayField() {
  image(fieldScreen, 0, 0, width, height);


  if (turn == 0) { //RED's turn to take shot

    fill(0);
    PFont algerian = createFont("algerian", 30);
    textFont(algerian);
    text("Player", width/25, height/3);
    fill (255, 0, 40);
    text("Red", width/7, height/3);
    algerian = createFont("algerian", 14);
    textFont(algerian);
    fill (0);
    text("Adjust the ball position using arrow keys", width/300, height/2.5);
    text("Press R when you are ready to shoot", width/60, height/2.2);

    fill(0);
    algerian = createFont("algerian", 30);
    textFont(algerian);
    text("Player", width/1.24, height/3);
    fill (40, 0, 255);
    text("Blue", width/1.10, height/3);
    algerian = createFont("algerian", 15);
    textFont(algerian);
    fill (0);
    text("Set your fielders on the table", width/1.27, height/2.5);
    text("Follow all the given rules", width/1.25, height/2.2);
  } else if (turn == 1) {

    fill(0);
    PFont algerian = createFont("algerian", 30);
    textFont(algerian);
    text("Player", width/25, height/3);
    fill (40, 0, 255);
    text("Blue", width/7, height/3);
    algerian = createFont("algerian", 14);
    textFont(algerian);
    fill (0);
    text("Adjust the ball position using arrow keys", width/300, height/2.5);
    text("Press R when you are ready to shoot", width/60, height/2.2);

    fill(0);
    algerian = createFont("algerian", 30);
    textFont(algerian);
    text("Player", width/1.24, height/3);
    fill (255, 0, 40);
    text("Red", width/1.10, height/3);
    algerian = createFont("algerian", 15);
    textFont(algerian);
    fill (0);
    text("Set your fielders on the table", width/1.27, height/2.5);
    text("Follow all the given rules", width/1.25, height/2.2);
  }
}

void displayStats() {

  if (shots0 == 0 && shots1 == 0) {
    if (score0 == score1) {
      shots0++;
      shots1++;
    }
  }
  image(statsScreen, 0, 0, width, height);

  if (shotsRed.size() <= 5) {
    for (int i = 0; i<shotsRed.size(); i++) {
      if (shotsRed.get(i) == 0) {
        fill(255, 0, 40);
      } else {
        fill(0, 255, 40);
      }
      ellipse((width/3.45 + (i*20)), height/3.08, 10, 10);
    }
  } else {
    for (int i = shotsRed.size() - 5; i<shotsRed.size(); i++) {
      if (shotsRed.get(i) == 0) {
        fill(255, 0, 40);
      } else {
        fill(0, 255, 40);
      }
      ellipse((width/3.45 + ((i-(shotsRed.size() - 5))*20)), height/3.08, 10, 10);
    }
  }  

  if (shotsBlue.size() <= 5) {
    for (int i = 0; i<shotsBlue.size(); i++) {
      if (shotsBlue.get(i) == 0) {
        fill(255, 0, 40);
      } else {
        fill(0, 255, 40);
      }
      ellipse((width/1.47 + (i*20)), height/3.08, 10, 10);
    }
  } else {
    for (int i = shotsBlue.size() - 5; i<shotsBlue.size(); i++) {
      if (shotsBlue.get(i) == 0) {
        fill(255, 0, 40);
      } else {
        fill(0, 255, 40);
      }
      ellipse((width/1.47 + ((i-(shotsBlue.size() - 5))*20)), height/3.08, 10, 10);
    }
  }  

  fill(0);
  PFont algerian = createFont("algerian", 30);
  textFont(algerian);
  text("Player", width/4.5, height/5);
  fill (255, 0, 40);
  text("Red", width/3.05, height/5);
  algerian = createFont("algerian", 20);
  textFont(algerian);
  fill (0);
  
  text("Shots: ", width/4.4, height/3);
  text("Remaining Shots: " + shots0, width/4.4, height/2.5);

  fill(0);
  algerian = createFont("algerian", 30);
  textFont(algerian);
  text("Player", width/1.65, height/5);
  fill (40, 0, 255);
  text("Blue", width/1.4, height/5);
  algerian = createFont("algerian", 20);
  textFont(algerian);
  fill (0);
  
  text("Shots: ", width/1.62, height/3);
  text("Remaining Shots: " + shots1, width/1.62, height/2.5);
}

void gameOver() {
  
  displayStats();
  
  text("Score: " + score1, width/1.53, height/2.2);
  text("Score: " + score0, width/3.8, height/2.2);
  
  PFont algerian = createFont("algerian", 40);
  textFont(algerian);
  if (score0 > score1) {
    text ("Player", width/2.95, height/1.3);
    fill(255, 0, 40);
    text ("RED", width/2.13, height/1.3);
    fill(0);
    text ("wins!!!", width/1.83, height/1.3);
  } else {
    text ("Player", width/2.95, height/1.3);
    fill(40, 0, 255);
    text ("BLUE", width/2.15, height/1.3);
    fill(0);
    text ("wins!!!", width/1.83, height/1.3);
  }
  algerian = createFont("algerian", 30);
  textFont(algerian);
  text ("click on the screen to restart!", width/3.2, height/1.1);
  if (gameEndSfx) {
    gameOverSound.play();
    gameOverSound.loop();
    gameEndSfx = false;
  }
}

void restart() {
  gameOverSound.stop();
  backgroundSound.play();
  backgroundSound.loop();

  isKicking = false;
  settingUP = false;
  settingDOWN = false;
  settingLEFT = false;
  settingRIGHT = false;
  isSetting = false;
  isReady = false;
  timeReading = false;
  readingTaken = false;
  shotTaken = false;
  goalScored = false;
  goalScreen = false;
  state = 0;
  turn = int(random(0, 2));
  shots0 = 5;
  shots1 = 5;
  score0 = 0;
  score1 = 0;
  shotsRed = new ArrayList<Integer>();
  shotsBlue = new ArrayList<Integer>();
}

void keyPressed() {
  if (state == 0 && keyCode == ENTER) {
    state = 1;
    enterSound.play();
  } else if (state == 1 && keyCode == ENTER) {
    state = 2;
    enterSound.play();
  } else if (state == 2 && keyCode == ENTER) {
    state = 3;
    backgroundSound.stop();
    enterSound.play();
  }

  if (state == 3 && isSetting) {
    if (keyCode == ' ') {
      isKicking = true;
    } else if (keyCode == UP) {
      settingUP = true;
    } else if (keyCode == DOWN) {
      settingDOWN = true;
    } else if (keyCode == LEFT) {
      settingLEFT = true;
    } else if (keyCode == RIGHT) {
      settingRIGHT = true;
    }
  }

  if (state == 3 && keyCode == 'R' && !shotTaken && !goalScreen) {
    if (!readingTaken) {
      timeReading = true;
    }
    isReady = true;
    whistleSound.play();
  }
  if (state == 3 && keyCode == ENTER) {
    if (shotTaken) {
      shotTaken = false;
      enterSound.play();
    }
    if (goalScreen) {
      goalScreen = false;
      enterSound.play();
    }
  }
}

void keyReleased() {
  isKicking = false;
  settingUP = false;
  settingDOWN = false;
  settingLEFT = false;
  settingRIGHT = false;
}

void mousePressed() {
  if (state == 4) {
    restart();
  }
} 

void serialEvent(Serial myPort) {

  String inString = myPort.readStringUntil('\n');
  // Always check to make sure the string isn't empty
  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    // convert to a float
    LDRreading = float(inString);
  }
  myPort.write(int(isKicking)+","+int(settingUP)+","+int(settingDOWN)+","+int(settingLEFT)+","+int(settingRIGHT)+"\n"); //Send the LED values back to arduino
}
