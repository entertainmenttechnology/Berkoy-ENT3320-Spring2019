import processing.video.*;
int x = 0;
int Red = 255;
int Green = 255;
int Blue = 255;

// Variable for capture device
Capture video;
// Previous Frame
PImage prevFrame;
// How different must a pixel be to be a "motion" pixel
float threshold = 50;
void setup() {
  size(320, 240);
  video = new Capture(this, width, height, 30);
  video.start();
  // Create an empty image the same size as the video
  prevFrame = createImage(video.width, video.height, RGB);
}
void captureEvent(Capture video) {
  // Before reading the new frame, always save the previous frame for comparison!
  prevFrame.copy(video, 0, 0, video.width, video.height, 0, 
    0, video.width, video.height);
  prevFrame.updatePixels(); // Read image from the camera
  video.read();
}
void draw() {
  loadPixels();
  video.loadPixels();
  prevFrame.loadPixels();
  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x++) {
    for (int y = 0; y < video.height; y++) {
      int loc = x + y * video.width; // Step 1: What is the 1D pixel location?
      color current = video.pixels[loc]; // Step 2: What is the current color?
      color previous = prevFrame.pixels[loc]; // Step 3: what is the previous color?
      // Step 4, compare colors (previous vs. current)
      float r1 = red(current); 
      float g1 = green(current); 
      float b1 = blue(current);


      float r2 = red(previous); 
      float g2 = green(previous);
      float b2 = blue(previous);
      float diff = dist(r1, g1, b1, r2, g2, b2);
      // Step 5, How different are the colors?
      if (diff > threshold) {
        // If motion, display black
        pixels[loc] = color(Red, Green, Blue);
      } else {
        // If not, display white
        pixels[loc] = color(0);
      }
    }
  }
  updatePixels();
}
void mousePressed(){
  if (x == 0){
  Red = 255;
  Green = 255;
  Blue = 255;
  x = 1;
    }
    else if (x == 1){
      Red = 255;
      Green = 0;
      Blue = 0;
      x = 2;
    }
    else if (x == 2){
      Red = 0;
      Green = 255;
      Blue = 0;
      x = 3;
    
  }
   else if (x == 3){
      Red = 0;
      Green = 0;
      Blue = 255;
      x = 4;
   }
    else if (x == 4){
      Red = 255;
      Green = 255;
      Blue = 0;
      x = 5;
    }
    else if (x == 5){
      Red = 255;
      Green = 0;
      Blue = 255;
      x = 6;
    }
    else if (x == 6){
      Red = 0;
      Green = 255;
      Blue = 255;
      x = 0;
    }
    
    

}
