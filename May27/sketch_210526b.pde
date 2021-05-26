float rotationAngle = 0; //variable responsible for rotations of rectangles, and thus animation.

void setup(){
 size(900, 900);
}

void draw(){
  background(0,0,128); //Sets the background color as Navy Blue
  
  fill(128,0,0);  //Fill the rectangles with Maroon color
  strokeWeight(10); //Makes the strokes (borders) thicker 
  stroke(0,0,128); //Makes the color of stroke Navy Blue
  
  translate(width/2, height/2); //Translates the rectangle to the center of the sketch
  
  for(int i = 0; i < 100; i++){ //loop to draw 100 rectangles
    scale(0.95); //Makes sure that every next rectangle has 5 percent less size than the size of the previous rectangle
    
    rotate(radians(rotationAngle)); //rotate the rectangles with respect to the value of rotationAngle
    
    rectMode(CENTER); //Makes the first two parameters to the rect function into coordinates of center rather than the coordinates of corner point 
    rect(0,0,600,600); //Makes the rectangle at the center of the sketch using translate and rectMode functions
  }
  rotationAngle += 0.1; //increases the value gradually to make the animation
}  
