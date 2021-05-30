//This artwork is inspired by Moiré pattern.

float pos2; //Position of the second set of verticle lines.
float rotationAngle = 5; //Used to facilitate the rotation of the second set of lines using mouse (see code lines 14 and 20).

void setup() {
  size(600, 600);
  strokeWeight(5);
}

void draw() {
  background(255);

  pos2 = map(mouseX, 0, width, -width/2, width/2); // the position of the second set of verticle lines will be changed using mouseX.
  rotationAngle = map(mouseY, 0, height, -90, 90); // the second set of lines will be rotated using mouseY.

  translate(width/2, height/2); //translates sets of lines to the center.

  drawLines1(); //Create the verticle lines on screen.

  rotate(radians(rotationAngle)); //Used to rotate the second set of lines.

  drawLines2(); //Create the second set of verticle lines on screen
}

// The function below creates a set of verticle line where the distance between any two lines is 10.
void drawLines1() {
  for (int x = -width/2; x <= width/2; x+=10) {
    line(x, -height/2, x, height/2);
  }
}  

/* The function below creates a second set of verticle lines on screen which can be moved using mouseX with the help of pos2 variable, 
 and rotated using mouseY with the help of rotationAngle variable and rotate() function in draw function.*/

void drawLines2() {
  for (int x = -width/2; x <= width/2; x+=10) {
    line(x+pos2, -height/2, x+pos2, height/2);
  }
}
