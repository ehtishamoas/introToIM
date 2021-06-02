// Student Name: Ehtisham Ul Haq
// Assignment Due Date: 3rd June, 2021

/* The Overall Concept:
                       
   In this assignment, I have employed the concepts of Transformation, Object Oriented Programming, Arrays, and Perlin Noise to
   create the rotating squares of random colors that move randomly and smoothly on canvas. The user can add as much squares 
   as they wishes on the canvas by altering the size of array.*/


RandomSquare[] squares= new RandomSquare[10]; //Array of 10 objects of RandomSquare class.

float angle; //counter variable used for the continous rotation of the square(s)

void setup() {
  size(900, 900);
  background(0);
  rectMode(CENTER); //first two parameters to the rect() function will be interpreted as of the center rather than of corner. This will allow us to rotate the squares from the center. 

  //five squares will be created randomly on the canvas from where they start to rotate continously and move randomly.
  for (int i = 0; i < squares.length; i++) {
    squares[i] = new RandomSquare();
  }
}

void draw() {
  background(0);
  for (int i = 0; i < squares.length; i++) {
    squares[i].randomMovement();
    squares[i].rotatingSquare();
  }
}

class RandomSquare {
  float x, y, r, g, b, t, t1;

  //The constructor takes no arguments. Instead it is used to simply set random values for our variables.
  RandomSquare() {
    r = random(255); //color red value for the fill function
    g = random(255); //color green value for the fill function
    b = random(255); //color blue value for the fill function
    
    //t and t1 are parameters to the noise function for x and y coordinates. Random value has range of 1000 numbers, so that there is a greater chance to have different values for many different squares.
    //we have used different variables for x and y coordinates to allow the squares to move in all directions instead of limiting their movement to the y=x line.
    t = random (1000);
    t1 = random(1000);
  }

  void randomMovement() {
    //Randomly and Smoothly move the square on the canvas
    x = noise(t);
    x = map(x, 0, 1, 0, width);
    y = noise(t1);
    y = map(y, 0, 1, 0, height);
    t += 0.005;
    t1 += 0.005;

    //Prevent the squares to leave the canvas
    x = constrain(x, 0, width);
    y = constrain(y, 0, height);
  }
  void rotatingSquare() {
    fill(r, g, b); //assign random color to the square

    //below lines are used to create a continous rotating square of sides 50:
    
    //Push and pop matrix functions are used to allow us to repeat the process of translating the canvas to x and y coordinates for all the squares and creating them there.
    pushMatrix();
    translate(x, y);
    rotate(radians(angle)); //rotates the square with respect to the counter vaiable 'angle'
    rect(0, 0, 50, 50); //creates the square of sides 50 at x,y becaus eof translate function.
    angle += 1; // the speed of rotation can be increased by using a greater value here than 1, and can be decreased by using the smaller value here than 1.
    popMatrix();
  }
}
