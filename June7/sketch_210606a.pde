PImage photo;

//Below variable is used to switch between different effects for the image.
int photoMode = 0;

//Below lines ae used to create a 4x4 matrix of pixels used to blur the image.
float v = 1.0 / 16.0;
float[][] kernel = {{ v, v, v , v}, { v, v, v , v}, { v, v, v , v}, { v, v, v , v}};

void setup() {
  size(800, 600);
  photo = loadImage("dogs.jpg"); //The portrait mode works specifically for this picture. This picture can be found in June7 folder in my github repository.
  photo.resize(800, 600);
}
void draw() { //Different effects are controlled by the value of PhotoMode variable which itself is controlled by mouseClick() function.
  if (photoMode == 0) {
    image(photo, 0, 0);
  } else if (photoMode == 1) {
    grayScale();
  } else if (photoMode == 2) {
    portraitMode();
  }
}


void grayScale() {
  image(photo, 0, 0);
  loadPixels();
  //Loop over every pixel in the image
  for (int x = 0; x < width; x++) {   
    for (int y = 0; y < height; y++) {
      int i = x+y*width;
      color c = photo.get(x, y);
      float r = red(c);
      float g = green(c);
      float b = blue(c);
      pixels[i] = color((r+b+g)/3); //1 argument r+g+b turn the pixel color into the shade of gray relative to the original color of the pixel. Dividing by 3 makes the brightness more suitable.
    }
  }
  updatePixels();
}
void portraitMode() {

  photo.loadPixels();
  // Create an image of the same size as the original to blur. We did this so the original image will not be blurred over and over again when mouseClick() would signal to call the portraitMode() function.
  PImage photo_1 = createImage(photo.width, photo.height, RGB);

  for (int y = 2; y  < photo.height-2; y++) {   // Skip 2 pixels from top and bottom edges in order for the for loops to work
    for (int x = 2; x < photo.width-2; x++) {   // Skip 2 pixels from left and right edges in order for the for loops to work
    
      if ((x > width/2 && x < width/1.6) && (y > height/4) && y < height/2.3) {
        photo_1.pixels[x+ y*photo.width] = photo.pixels[x+ y*photo.width];
      } else {

        // Kernel sums (r,g, and b) for this pixel
        float red = 0;
        float green = 0;
        float blue = 0;
        
        // Update the values of adjacent pixels to blend with the original pixel in order to give the blurred effect:
        
        for (int ky = -1; ky <= 2; ky++) {
          for (int kx = -1; kx <= 2; kx++) {
 
            int loc = (x + kx) + (y + ky)*photo.width; //Find the location of the adjacent pixel
            
            float r = red(photo.pixels[loc]);
            float g = green(photo.pixels[loc]);
            float b = blue(photo.pixels[loc]);
            
            red += kernel[ky+1][kx+1] * r;
            green += kernel[ky+1][kx+1] * g;
            blue += kernel[ky+1][kx+1] * b;
          }
        }
        //Set the adjacent pixel
        photo_1.pixels[x+ y*photo.width] = color(red, green, blue);
      }
    }
  }
  photo_1.updatePixels();

  image(photo_1, 0, 0); // Draw the newly produced image
}  

//Used to switch picture effects on mouse clicks:
void mouseClicked() {
  if (photoMode == 0) {
    photoMode = 1;
  } else if (photoMode == 1) {
    photoMode = 2;
  } else if (photoMode == 2) {
    photoMode = 0;
  }  
}  
