
////////////////////////////////////////////////////////////////////////////////////////////////////
/*
MULTI-DISPLAY TEST WITH ASSETS
 Triple-display output: laptop screen, monitor, projector 
 Riffing off of Alberto's sketch.
 
 NOTE: 
 Calibrate display arrangement in system preferences. Drag output window to align.
 */
////////////////////////////////////////////////////////////////////////////////////////////////////

//display dimensions
int display1_width = 1920;
int display2_width = 1920;
int display_height = 1080; //display heights must match
int display_width = display1_width + display2_width; //total width

//sample image files
PImage face1, face2, face3;
PImage back1, back2, back3, back4, back5;

//display stuff
PImage display1;  //what's on display 1
PImage display2;  //what's on display 2 
//to display or not to display
boolean display1_image=false;
boolean display2_image=false;


void setup() {
  size(3840, 1080);  //enter number parameters ****************

  //load sample images
  face1 = loadImage("data/sample_assets/faces/smiley1.png");
  face2 = loadImage("data/sample_assets/faces/smiley2.png");
  face3 = loadImage("data/sample_assets/faces/smiley3.png");
  back1 = loadImage("data/sample_assets/backgrounds/back1.jpg");
  back2 = loadImage("data/sample_assets/backgrounds/back2.jpg");

  display1= back1;
  display2= face1;
}


void draw() {

  if (display1_image== true) {
    //display 1
    image (display1, 0, 0);
  }
  if (display2_image== true) {
    //display 2 : sample face test
    image (display2, display1_width, 0);
  }
}

void keyPressed() {

  //SAMPLE IMAGES
  if (key== 'q') {
    //blue on display 1, red on display 2
    clearDisplay ("display1", 0, 0, 255);
    clearDisplay ("display2", 255, 0, 0);
  } else if (key== 'w') {
    display1_image= true;
    display2_image= true;
    display1= back1;
    display2= face1;
  } else if (key== 'e') {
    display1_image= true;
    display1= back2;
  }
}


//to clear display of image 
void clearDisplay(String whichDisplay, int r, int g, int b) { 
  fill (r, g, b);
  if (whichDisplay== "display1") {
    display1_image= false;
    rect (0, 0, display1_width, display_height);
  } else if (whichDisplay== "display2") {
    display2_image= false;
    rect(display1_width, 0, display2_width, display_height);
  }
}
