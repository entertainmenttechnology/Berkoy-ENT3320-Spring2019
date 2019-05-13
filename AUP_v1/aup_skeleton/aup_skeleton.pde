/*
////////////////////////////////////////////////////////
 AUP SKELETON
 
 TESTING:
 Press keys 1-3 + q-i to test (see below).
 'k' to display Kinect, 'l' to stop/clear.
 
 DISPLAYS:
 Triple-display output: laptop screen, monitor, projector. 
 Calibrate display arrangement in system preferences. 
 Drag output window to align.
 
 VOICES:
 Install voices from https://www.assistiveware.com/products/infovox-ivox . 
 If no voices installed, use Apple voice "fred"
 Finalist voices / speeds: Harry (200), BadGuy (200), Rhona (175)
 
 SOUND:
 Uses Minim Library for sound. 
 Install from Processing Contributed Libraries.
 Reference at http://code.compartmental.net/minim/ under AudioPlayer
 
 ////////////////////////////////////////////////////////
 */

//MODE*********
String mode= "kinect";

//DISPLAYS*********
int display1_width = 1920;
int display2_width = 1920;
int display_height = 1080; //display heights must match
int display_width = display1_width + display2_width; //total width

//VIDEO
import processing.video.*;

//SOUND STUFF
import ddf.minim.*;
Minim minim; //Minim object

//TTS 
import java.util.*;
Figure figure;  //creates new object from Figure class
String voice= "Rhona"; //keep voice as "fred" if no other voices installed
int voiceSpeed= 175;
boolean silence= true; 


//KINECT STUFF
import SimpleOpenNI.*;
SimpleOpenNI context;
int userCount=0;
boolean displayDepthImage= false;
boolean displayCOM= false;


//FACE
Face face; //creates new object from Face class
boolean displayFace= false;
//***callibrate face in draw***

//JOKE STUFF
String [] joke= {
  "Here we go. .  Why do ambulances require two drivers at all times? . . .  Because they’re a pair o' medics!", 
  "Here we go. .  Did you hear about the guy whose entire left side was cut off? . . .  Do not worry. He is all right now!", 
  "Here we go. .  How do Hurricanes See? . . .  With one eye!", 
  "Here we go. .  What’s the difference between Weather and Climate? . . .  You can’t weather a tree, but you can climate.", 
  "Here we go. .  What do cows produce during a hurricane?. . .  Milk shakes!", 
  "Here we go. .  Did you hear the joke about amnesia?. . .  I forgot how it goes! Hahaha!", 
  "Here we go. .  How do you gift wrap a cloud?. . .  With a rainbow!", 
  "Here we go. .  What did the Tsunami say to the island?. . .  Nothing. It just waved!", 
  "Here we go. .  Why did the tornado finally take a break?. . .  It was winded!"
};
int whichJoke;
int[] randomJoke= new int [joke.length];

//LIVE DATA STUFF
int aqi = 0; //tracks air quality index
String aqi_desc = "";
String air_key= "KwYLLNsmAx4de4gaS";  //AB's key 
String url = "http://api.airvisual.com/v2/city?city=New%20York&state=New%20York&country=USA&key=" + air_key;

//SAMPLE ASSETS
PImage face1, face2, face3;
PImage back1, back2, back3, back4, back5;
Movie video1;
Movie video2;
Movie video3;
AudioPlayer sound1;
AudioPlayer sound2;


//WHAT'S DISPLAYED AND HEARD
PImage display1_image;  //image on display 1
PImage display2_image;  //image on display 2 
Movie display1_video; //video on display 1
Movie display2_video;  //video on display 2
//to display or not to display
boolean display1_image_visible=false;
boolean display2_image_visible=false;
boolean display1_video_visible=false;
boolean display2_video_visible=false;
AudioPlayer sound; //object for current sound loaded


//MORE VARIABLES
String text, state;
int currentInput, whichInput, randomInput;


/////////////////////////////////////////////////////////////////////////////////////


void setup() {
  size(3840, 1080);  //enter number parameters ****************

  //SOUND
  minim = new Minim(this); //assigns new minim sound object

  //TTS
  figure = new Figure(voice, voiceSpeed); //input installed voice name and speed

  //FACE
  face= new Face();

  //FILL ARRAYS FOR RANDOMIZATON
  fillRandomizer(joke, randomJoke);

  //LOAD JSON DATA
  JSONObject nyc_air = loadJSONObject(url); //load the entire Object
  JSONObject pollution = nyc_air.getJSONObject("data").getJSONObject("current").getJSONObject("pollution"); //get object within objects
  aqi = pollution.getInt("aqius"); //here's the aqi!

  //LOAD SAMPLE IMAGES
  face1 = loadImage("data/sample_assets/faces/smiley1.png");
  face2 = loadImage("data/sample_assets/faces/smiley2.png");
  face3 = loadImage("data/sample_assets/faces/smiley3.png");
  back1 = loadImage("data/sample_assets/backgrounds/back1.jpg");
  back2 = loadImage("data/sample_assets/backgrounds/back2.jpg");
  video1= new Movie(this, "sample_assets/videos/video1.mp4");
  video2= new Movie(this, "sample_assets/videos/video2.mov");
  video3= new Movie(this, "sample_assets/videos/video3.mp4");
  sound1 = minim.loadFile("sample_assets/music/music1.wav");
  sound2 = minim.loadFile("sample_assets/music/music3.wav");

  //ASSIGN INITIAL ASSET PLACEHOLDERS TO OBJECTS
  display1_image= back1;
  display2_image= face1;
  display1_video= video1;
  display2_video= video2;
  sound= sound1;


  //ASSIGN MODE
  if (mode== "kinect") {  //**********************
    context= new SimpleOpenNI(this);
    context.enableDepth();
    context.enableUser(); //SimpleOpenNI.SKEL_PROFILE_NONE
    context.setMirror(true);
  }
}

/////////////////////////////////////////////////////////////////////////////////////


void draw() {

  //FACE**********************
  //**********************CALIBRATE FACE**********************
  if (displayFace==true){
  clearDisplay("display2", 255, 255, 255);
  face.eye(2425, 880, 100, 100);  //x, y, width, height
  face.eye(2325, 680, 100, 100);
  }
  
  /*
  //callibrate face
  fill(0);
  ellipse (mouseX, mouseY, 100, 100);
  println (mouseX, mouseY);
  */

  //TTS
  if (figure.isSpeaking()) {
    silence= false;
  } else {
    silence=true;
  }

  //KINECT
  if (mode== "kinect") {
    kinect();
  }


  //DISPLAY STUFF
  if (display1_image_visible== true) {
    //display 1
    image (display1_image, 0, 0);
  }
  if (display2_image_visible== true) {
    //display 2 : sample face test
    image (display2_image, display1_width, 0);
  }
  if (display1_video_visible== true) {
    if (display1_video.available()) {
      display1_video.read();
    }
    image (display1_video, 0, 0);
  }
  if (display2_video_visible== true) {
    if (display2_video.available()) {
      display2_video.read();
    }
    image (display2_video, display1_width, 0);
  }
  //KINECT NOTE: SEE DISPLAY IN KINECT();
}



/////////////////////////////////////////////////////////////////////////////////////
//END OF DRAW////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////


//FOR TESTING
void keyPressed() {

  //TTS, JOKE, DATA
  if (key=='1') {
    figure.speak("Hello, this is a text to speech demo. We are testing voices for legibility. How clearly can you understand me?");
  } else if (key== '2') {
    joke();
  } else if (key== '3') {
    aqi_report();
  }

  //SAMPLE IMAGES AND VIDEOS
  if (key== 'q') {
    //blue on display 1, red on display 2
    clearDisplay ("display1", 0, 0, 255);
    clearDisplay ("display2", 255, 0, 0);
  } else if (key== 'w') {
    clearDisplay("display1", 0, 0, 0);
    clearDisplay("display2", 255, 255, 255);
    display1_image_visible= true;
    display2_image_visible= true;
    display1_image= back1;
    display2_image= face1;
  } else if (key== 'e') {
    clearDisplay("display1", 0, 0, 0);
    display1_image_visible= true;
    display1_image= back2;
  } else if (key== 'r') {
    clearDisplay("display1", 0, 0, 0);
    display1_video_visible= true;
    display1_video= video1;
    video1.stop();
    video1.play();
  } else if (key== 't') {
    clearDisplay("display1", 0, 0, 0);
    display1_video_visible= true;
    display1_video= video2;
    video2.stop();
    video2.play();
  } 

  //SAMPLE SOUNDS
  if (key== 'y') {
    sound.pause();
    sound= sound1;
    sound.rewind();
    sound.play();
  } 
  if (key=='u') {
    sound.pause();
    sound= sound2;
    sound.rewind();
    sound.play();
  } else if (key== 'i') {  //stop sound
    sound.pause();
  }

  //DISPLAY KINECT
  if (key== 'k') {
    clearDisplay("display1", 0, 0, 0);
    displayDepthImage= true;
    displayCOM= true;
  } else if (key=='l') {
    displayDepthImage=false;
    displayCOM= false;
    clearDisplay("display1", 0, 0, 0);
  }
  
  //DISPLAY FACE
  if (key== 'f'){
    displayFace= true;
  } else if (key== 'g'){
    clearDisplay("display2", 0, 0, 0);
    displayFace= false;
  }
}

//CLEAR DISPLAY
void clearDisplay(String whichDisplay, int r, int g, int b) { 
  fill (r, g, b);
  if (whichDisplay== "display1") {
    display1_image_visible= false;
    display1_video_visible= false;
    rect (0, 0, display1_width, display_height);
  } else if (whichDisplay== "display2") {
    display2_image_visible= false;
    display2_video_visible= false;
    rect(display1_width, 0, display2_width, display_height);
  }
}

//JOKE
void joke() {
  handle(joke, "joke", whichJoke, randomJoke);
  whichJoke= currentInput;
  figure.speak(text);
  println(text);
}

//JSON DATA (AQI)
void aqi_report() {
  if (aqi >= 0 && aqi <= 50) {
    aqi_desc= "good. . . Air quality is satisfactory and poses little or no health risk. . . Ventilating your home is recommended. . . Recommendations. . . Enjoy your usual outdoor activities. We recommend opening your windows and ventilating your home to bring in fresh, oxygen-rich air.";
  } else if (aqi >= 51 && aqi <= 100) {
    aqi_desc= "moderate. . . Air quality is acceptable and poses little health risk. . . Sensitive groups may experience mild adverse effects and should limit prolonged outdoor exposure. . . Recommendations Enjoy your usual outdoor activities. . . We recommend opening your windows and ventilating your home to bring in fresh, oxygen-rich air.";
  } else if (aqi >= 101 && aqi <= 150) {
    aqi_desc= "Unhealthy for Sensitive Groups. . . Air quality poses increased likelihood of respiratory symptoms in sensitive individuals while the general public might only feel slight irritation. . . Both groups should reduce their outdoor activity. . . Recommendations The general public should greatly reduce outdoor exertion. . . Sensitive groups should avoid all outdoor activity. . . Everyone should take care to wear a pollution mask.. . Ventilation is discouraged. . . Air purifiers should be turned on.";
  } else if (aqi >= 151 && aqi <= 200) {
    aqi_desc= "Unhealthy. . . Air quality is deemed unhealthy and may cause increased aggravation of the heart and lungs. . . Sensitive groups are at high risk to experience adverse health effects of air pollution. . . Recommendations . . . Outdoor exertion, particularly for sensitive groups, should be limited. . . Everyone should take care to wear a pollution mask. . . Ventilation is not recommended. . .  Air purifiers should be turned on if indoor air quality is unhealthy.";
  } else if (aqi >= 201 && aqi <= 300) {
    aqi_desc= "Very Unhealthy. . . Air quality is deemed unhealthy and may cause increased aggravation of the heart and lungs. . . Sensitive groups are at high risk to experience adverse health effects of air pollution. . .  Recommendations The general public should greatly reduce outdoor exertion. . . Sensitive groups should avoid all outdoor activity. . . Everyone should take care to wear a pollution mask. . . Ventilation is discouraged. . . Air purifiers should be turned on.";
  } else if (aqi >= 301 && aqi <= 500) {
    aqi_desc= "Hazardous. . . Air quality is deemed toxic and poses serious risk to the heart and lungs. . . Everyone should avoid all outdoor exertion. Recommendations. . . The general public should avoid outdoor exertion. Everyone should take care to wear a quality pollution mask. . . Ventilation is discouraged. . . Homes should be sealed and air purifiers turned on.";
  }

  figure.speak ("The current Air Quality Index for New York City is " + aqi + " . . . " + "This means that the air quality is . . ." + aqi_desc);
}


/////////////////////////////////////////////////////////////////////////////////////

//ARRAY STUFF FOR GRABBING RANDOM WITH NO-REPEAT

void handle(String input[], String tempState, int whichInput, int randomInput[]) {
  state= tempState;
  whichInput ++;
  currentInput=whichInput;
  if (whichInput >= input.length) {
    whichInput = 0;
    currentInput=0;
    fillRandomizer(input, randomInput);
  }
  text= input[randomInput[whichInput]];
}

void fillRandomizer(String input [], int randomInput[]) {
  int slot = 0;
  //fill with negative numbers
  for (int i=0; i<input.length; i++) {
    randomInput[i] = -1;
  }
  // fill with unique numbers
  while (slot<input.length) {
    int myRand =   floor(random(0, input.length));
    boolean bFound = false;
    for (int i=0; i<input.length && !bFound; i++) {
      if ( myRand == randomInput[i] )
        bFound = true;
    }
    if (!bFound) {
      randomInput[slot] = myRand;
      slot += 1;
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////

//KINECT STUFF

void kinect() {
  context.update();
  //image(context.depthImage(), 0, 0);
  userCount = context.getNumberOfUsers();
  IntVector userList= new IntVector();
  context.getUsers(userList);


  for (int u=0; u<userList.size(); u++) {
    int userID= userList.get(u);
    PVector position= new PVector();
    context.getCoM( userID, position);
    context.convertRealWorldToProjective(position, position);

    //USER IDS + COM DISPLAYED ONLY IF DEPTH IMAGE DISPLAYED
    if (displayDepthImage== true) { 
      if (displayCOM== true) {
        image(context.depthImage(), 0, 0, 1920, 1080);
        fill(255, 0, 0);
        textSize(60);
        text(userID, position.x * 3, position.y * 2.5, position.z); //scaled to 1920x1080 display
      }
    }


    println ("user ID: " + userID + " x: " + position.x + " Y  " + position.y + " z: " + position.z);
    println ("kinect:  " + " userCount: " + userCount);
  }
}
