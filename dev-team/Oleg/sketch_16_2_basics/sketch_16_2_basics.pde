import processing.video.*; //<-- import video library 
Capture video; //<-- initialize a Capture object named video
void setup() { //<--- create function setup
size(320, 240); //<-- create a canvas with width 320px by height 240px
video = new Capture(this, 320, 240); 
// <-- create new Capture with parent this, and requestWidth of 320 and requestHeight with 240
video.start();//<-- function to start capturing frames
}

void captureEvent(Capture video) {//<--function to capture with a property video
video.read(); //<-- read the current video frame
}

void draw() { //<--fucntion to draw on a canvas
background(255); //<--create a white background 
//<<<<<<< HEAD
tint(mouseX, mouseY, 255);//<-- function to use mouseX and mouseY values to change rgb values of tint
translate(width/2, height/2); //<-- function to replace starting points of image from 0,0 to width/2, height/2.
imageMode(CENTER);//<-- Use CENTER as a manipulating point for an image
rotate(mouseX); //<-- Rotate image to 45 degrees
image(video, 0, 0, mouseX, mouseY); // <-- show image of a video on canvas with starting points 0, 0, and width and height of an image comparable to MouseX and MouseY
//=======
tint(mouseX, mouseY, 255); // Changes video feed color based on mouse position
translate(width/2, height/2);
imageMode(CENTER); // Centers video in middle of screen
rotate(PI/4); // <-- rotate image by 45 degrees
image(video, 0, 0, mouseX, mouseY); //<-- create video image on canvas at point 0,0 with width and height mouseX and mouseY 

}
