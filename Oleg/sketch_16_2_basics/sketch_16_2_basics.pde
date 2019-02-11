import processing.video.*; //<-- import video library 
Capture video; //<-- initialize a Capture object named video
void setup() { //<--- create function setup
size(320, 240); //<-- create a canvas with width 320px by height 240px
video = new Capture(this, 320, 240); 
// <-- create new Capture with parent this, and requestWidth of 320 and requestHeight with 2Ω40
video.start();//<-- function to start capturing frames
}

void captureEvent(Capture video) {//<--function to capture with a property video
video.read(); //<-- read the current video frame
}

void draw() { //<--fucntion to draw on a canvas
background(255); //<--create a white background 
tint(mouseX, mouseY, 255);
translate(width/2, height/2);
imageMode(CENTER);
rotate(PI/4);
image(video, 0, 0, mouseX, mouseY);
}
