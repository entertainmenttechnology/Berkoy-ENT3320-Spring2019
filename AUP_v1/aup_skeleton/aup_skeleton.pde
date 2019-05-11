/*
////////////////////////////////////////////////////////
AUP SKELETON
 
 TESTING
 Press keys to test (see below).
 
 VOICES:
 Install voices from https://www.assistiveware.com/products/infovox-ivox . 
 If no voices installed, use Apple voice "fred"
 Finalist voices / speeds: Harry (200), BadGuy (200), Rhona (175)
 
 ////////////////////////////////////////////////////////
 */

//TTS STUFF
import java.util.*;
Figure figure;  //creates new object from Figure class
String voice= "fred"; //keep voice as "fred" if no other voices installed
int voiceSpeed= 100;
boolean silence= true; 

Face face; //creates new object from Face class
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

//MORE VARIABLES
String text, state;
int currentInput, whichInput, randomInput;


void setup() {
  size (800, 800);
  
  figure = new Figure(voice, voiceSpeed); //input installed voice name and speed
  face= new Face();
  
  //FILL ARRAYS FOR RANDOMIZATON
  fillRandomizer(joke, randomJoke);
}

void draw() {
  background (255);
  fill (0);

  ///////////////////callibrate face////////////////////////////////
  face.eye(width/2, height/3, 50, 50);  //x, y, width, height
  face.eye(width/2 + 75, height/3, 50, 50);
  

  if (figure.isSpeaking()) {
    silence= false;
  } else {
    silence=true;
  }
}

void keyPressed() {
  if (key=='1') {
    figure.speak("Hello, this is a text to speech demo. We are testing voices for legibility. How clearly can you understand me?");
  } else if (key== '2'){
    joke();
  }
}



void joke() {
  handle(joke, "joke", whichJoke, randomJoke);
  whichJoke= currentInput;
  figure.speak(text);
  println(text);
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
