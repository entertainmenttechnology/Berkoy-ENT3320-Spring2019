//video files
import processing.video.*;
import ddf.minim.*;
Movie movie1, movie2, movie3;
Movie whichMovie;
Minim minim;
AudioPlayer music1, music2, music3;
AudioPlayer speech1, speech2;

//dimensions for display 1
int display1_length = 1920;
int display1_height = 1080;

//dimensions for display 2
int display2_length = 1920;
int display2_height = 1080;

//total dimensions for both displays
int length_total = display1_length + display2_length;
int height_total = display1_height + display2_height;

//image files
PImage face1, face2, face3;
PImage back1, back2, back3, back4, back5;


void setup() {
  //Size() values have to be numbers, not variables
  size(3840, 2160);
  
  //load face images
  face1 = loadImage("data/faces/smiley1.png");
  face2 = loadImage("data/faces/smiley2.png");
  face3 = loadImage("data/faces/smiley3.png");
  
  //load background images
  back1 = loadImage("data/backgrounds/back1.jpg");
  back2 = loadImage("data/backgrounds/back2.jpg");
  back3 = loadImage("data/backgrounds/back3.jpg");
  back4 = loadImage("data/backgrounds/back4.jpg");
  back5 = loadImage("data/backgrounds/back5.jpg");
  
  //load videos
  movie1 = new Movie(this, "videos/video1.mp4");
  movie2 = new Movie(this, "videos/video2.mov");
  movie3 = new Movie(this, "videos/video3.mp4");
  
  //load sounds
  minim = new Minim(this);
  music1 = minim.loadFile("music/music1.wav");
  //music2 = minim.loadFile("music/music2.wav");
  music3 = minim.loadFile("music/music3.wav");
  speech1 = minim.loadFile("speech/speech1.wav");
  speech2 = minim.loadFile("speech/speech2.wav");
  //speech3 = minim.loadFile("speech/speech3.wav");
}

void draw() {
  //empty sketch
  //fill(0, 0, 0);
  
  //red/blue background test
  if (keyCode == '0') { 
  fill(0, 0, 255);
  rect(0, 0, display1_length, display1_height);
  
  fill(255, 0, 0);
  rect(display1_length, 0, length_total, height_total);
  }
  
  //three faces
  else if (keyCode == '1') {
    fill(255);
    rect(0, 0, display1_length, display1_height);
    imageMode(CENTER);
    image(face1, display1_length/2, display1_height/2, display1_length/2, display1_height/2);
  }
  
  else if (keyCode == '2') {
    fill(255);
    rect(0, 0, display1_length, display1_height);
    imageMode(CENTER);
    image(face2, display1_length/2, display1_height/2, display1_length/2, display1_height/2);
  }
  
  else if (keyCode == '3') {
    fill(255);
    rect(0, 0, display1_length, display1_height);
    imageMode(CENTER);
    image(face3, display1_length/2, display1_height/2, display1_length/2, display1_height/2);
  }
  
  
  //five backgrounds
  else if (key == 'q') {
    fill(255);
    rect(display1_length, 0, display2_length, display2_height);
    imageMode(CORNER);
    image(back1, display1_length, 0, display2_length, display2_height);
  }
  
  else if (key == 'w') {
    fill(255);
    rect(display1_length, 0, display2_length, display2_height);
    imageMode(CORNER);
    image(back2, display1_length, 0, display2_length, display2_height);
  }
  
  else if (key == 'e') {
    fill(255);
    rect(display1_length, 0, display2_length, display2_height);
    imageMode(CORNER);
    image(back3, display1_length, 0, display2_length, display2_height);
  }
  
  else if (key == 'r') {
    fill(255);
    rect(display1_length, 0, display2_length, display2_height);
    imageMode(CORNER);
    image(back4, display1_length, 0, display2_length, display2_height);
  }
  
  else if (key == 't') {
    fill(255);
    rect(display1_length, 0, display2_length, display2_height);
    imageMode(CORNER);
    image(back5, display1_length, 0, display2_length, display2_height);
  }
  
  //two videos
  else if (key == 'z') {
    fill(255);
    rect(display1_length, 0, display2_length, display2_height);
    imageMode(CORNER);
    image(movie1, display1_length, 0);
    movie2.stop();
    movie3.stop();
    movie1.play();
  }
  
  else if (key == 'x') {
    fill(255);
    rect(display1_length, 0, display2_length, display2_height);
    imageMode(CORNER);
    image(movie2, display1_length, 0);
    movie1.stop();
    movie3.stop();
    movie2.play();
  }
  
  else if (key == 'c') {
    fill(255);
    rect(display1_length, 0, display2_length, display2_height);
    imageMode(CORNER);
    image(movie3, display1_length, 0);
    movie1.stop();
    movie2.stop();
    movie3.play();
  }
}

public void movieEvent (Movie m) {
  if (m == movie1) {
    movie1.read();
  }
  if (m == movie2) {
    movie2.read();
  }
  if (m == movie3) {
    movie3.read();
  }
}
  
void keyPressed() {
  if (key == '[') {
    music1.rewind();
    music1.play();
    music3.pause();
  }
  
  else if (key == ']') {
    music3.rewind();
    music3.play();
    music1.pause();
  }
  
  else if (key == ',') {
    speech1.rewind();
    speech1.play();
    speech2.pause();
  }
  
  else if (key == '.') {
    speech2.rewind();
    speech2.play();
    speech1.pause();
  }
}
