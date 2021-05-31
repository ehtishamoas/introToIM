RandomWalker circle1, circle2, circle3, circle4, circle5;

void setup() {
  size(900, 900);
  background(255); //white background

  //five circles will be created from where they start to walk randomly, 4 at the corners and 1 at the center.

  circle1 = new RandomWalker(width, height);
  circle2 = new RandomWalker(0, 0);
  circle3 = new RandomWalker(width, 0);
  circle4 = new RandomWalker(0, height);
  circle5 = new RandomWalker(width/2, height/2);
}

void draw() {
  circle1.movement();
  circle2.movement();
  circle3.movement();
  circle4.movement();
  circle5.movement();
}

class RandomWalker {
  float x, y; //coordinates to draw the circles
  float noiseCount, colour; //these variables will be used to randomly and smoothly change colors of the circles

  //The constructor takes two parameters which are the x and y coordinates of where the circle is to be built.

  RandomWalker(float startX, float startY) {
    x = startX;
    y = startY;
  }

  void movement() {
    //The two lines below allow the next circle to build in any direction but only 10 units apart from the current circle. This gives the walking effect considering that the size of the circles is 30.
    x += random(-10, 10); 
    y += random(-10, 10);

    x = constrain(x, 0, width);
    y = constrain(y, 0, height);

    noiseCount += 0.01; //This will make the change in color shade of the circles very smooth
    colour = noise(noiseCount);
    colour = map(colour, 0, 1, 0, 255);
    fill(colour, 0, colour); //this will produce many different shades of pink
    ellipse(x, y, 30, 30); //creates an ellipse of size 30
  }
}
