import processing.serial.*;

boolean startGame = false;
float ballSize = 20;
float barSize = 200;
int backgroundColor;
int fillColor;

Game game;
Serial myPort;  // The serial port

void setup() {
  size(1360, 768);

  String portname=Serial.list()[0];
  myPort = new Serial(this, portname, 9600);
  myPort.clear();
  myPort.bufferUntil('\n');

  game = new Game();
}

class Ball {
  float x, y, speedX, speedY, maxSpeedX, maxSpeedY;
  boolean gameOver = false;

  Ball() { //constructor
    x = width/2;
    y = height/2;
    speedX = random(3, 6);
    speedY = random(3, 6);
    maxSpeedX = 12;
    maxSpeedY = 13;
  }  

  void update() {
    x += speedX;
    y += speedY;

    // if ball hits movable bar, invert Y direction
    if ( y > height-35 && y < height-20 && x > game.xPos && x < game.xPos+barSize ) {
      game.greenLED = true;
      speedY *= -1;
      y += speedY;
    }

    // if ball hits left or right wall, change the direction of X and increase the speed
    if (x < 30 || x > width-(30)) {
      if (speedX < maxSpeedX && speedY < maxSpeedY) {
        speedX *= -1.1;
        speedY *= 1.1;
      } else {
        speedX *= -1;
        speedY *= 1;
      }    
    }

    // if ball hits upper wall, change the direction of Y   
    if (y < 30) {
      speedY *= -1;
    }

    if (y > height) {
      game.redLED = true;
      gameOver = true;
    }
  }
  void display() {
    if (startGame) {
      update();
      circle(x, y, ballSize);
    }
  }
}




class Game {
  Ball[] ball = new Ball[1];
  float xPos = width/2-barSize; //x position of the player's bar.
  boolean keyLeft = false, keyRight = false, redLED = false, greenLED = false;

  Game() {
    for (int i = 0; i < ball.length; i++) {
      ball[i] = new Ball();
    }
  }
  void display() {

    //Check if game is over:
    for (int i = 0; i < ball.length; i++) {
      if (ball[i].gameOver) {
        background(backgroundColor);

        PFont algerian = createFont("algerian", 40);
        textFont(algerian);
        text("Game Over", width/2.4, height/2.2);
        text("Click To Restart", width/2.7, height/1.8);
        return;
      }
    }

    //Turn both the LEDs off:
    redLED = false;
    greenLED = false;

    //Update the X position of player's bar:
    if (keyLeft == true && xPos > 0) {
      xPos -= 15;
    } else if (keyRight == true && xPos < width-barSize) {
      xPos += 15;
    }

    //Display ball(s):
    for (int i = 0; i < ball.length; i++) {
      ball[i].display();
    }

    //Display walls:
    noStroke();
    rect(0, 0, 20, height);
    rect(0, 0, width, 20);
    rect(width-20, 0, 20, height);

    //Display player's bar:
    rect(xPos, height-30, barSize, 20); //player bar
  }
}  


void draw() { 
  background(backgroundColor);
  fill(fillColor);
  if (startGame) {
    game.display();
  }
}

void mousePressed() {
  for (int i = 0; i < game.ball.length; i++) {
    if (game.ball[i].gameOver) {
      game = new Game();
    }
  }
}

void serialEvent(Serial myPort) {
  String s=myPort.readStringUntil('\n');



  s=trim(s);
  if (s!=null) {

    startGame = true;

    int values[]=int(split(s, ','));

    if (values.length==3) {
      if (values[0] == 1) {
        game.keyRight = true;
      } else {
        game.keyRight = false;
      }

      if (values[1] == 1) {
        game.keyLeft = true;
      } else {
        game.keyLeft = false;
      }

      if (values[2] > 400) {
        backgroundColor = 255;
        fillColor = 0;
      } else {
        backgroundColor = 0;
        fillColor = 255;
      }
    }
  }
  myPort.write(int(game.greenLED)+","+int(game.redLED)+"\n");
}
