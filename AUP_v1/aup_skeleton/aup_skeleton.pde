/*
////////////////////////////////////////////////////////
 AUP SKELETON
 
 TESTING
 Press keys 1-3 to test (see below).
 
 VOICES:
 Install voices from https://www.assistiveware.com/products/infovox-ivox . 
 If no voices installed, use Apple voice "fred"
 Finalist voices / speeds: Harry (200), BadGuy (200), Rhona (175)
 
 ////////////////////////////////////////////////////////
 */

//MODE*********
String mode= "kinect";

//TTS 
import java.util.*;
Figure figure;  //creates new object from Figure class
String voice= "Rhona"; //keep voice as "fred" if no other voices installed
int voiceSpeed= 175;
boolean silence= true; 

//KINECT STUFF
import SimpleOpenNI.*;
SimpleOpenNI context;

//FACE
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

//LIVE DATA STUFF
int aqi = 0; //tracks air quality index
String aqi_desc = "";
String air_key= "KwYLLNsmAx4de4gaS";  //AB's key 
String url = "http://api.airvisual.com/v2/city?city=New%20York&state=New%20York&country=USA&key=" + air_key;

//KINECT
int userCount=0;

//MORE VARIABLES
String text, state;
int currentInput, whichInput, randomInput;


/////////////////////////////////////////////////////////////////////////////////////


void setup() {
  size (1600, 600); // testing

  figure = new Figure(voice, voiceSpeed); //input installed voice name and speed
  face= new Face();

  //FILL ARRAYS FOR RANDOMIZATON
  fillRandomizer(joke, randomJoke);

  // Load the JSON data
  JSONObject nyc_air = loadJSONObject(url); //load the entire Object
  JSONObject pollution = nyc_air.getJSONObject("data").getJSONObject("current").getJSONObject("pollution"); //get object within objects
  aqi = pollution.getInt("aqius"); //here's the aqi!

  if (mode== "kinect") {
    context= new SimpleOpenNI(this);
    context.enableDepth();
    context.enableUser(); //SimpleOpenNI.SKEL_PROFILE_NONE
    context.setMirror(true);
  }
}

/////////////////////////////////////////////////////////////////////////////////////


void draw() {
  background (255);
  fill (0);

  //**********************CALIBRATE FACE**********************
  face.eye(width/2, height/3, 50, 50);  //x, y, width, height
  face.eye(width/2 + 75, height/3, 50, 50);

  if (figure.isSpeaking()) {
    silence= false;
  } else {
    silence=true;
  }

  if (mode== "kinect") {
    kinect();
  }
}



/////////////////////////////////////////////////////////////////////////////////////
//END OF DRAW////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////


//FOR TESTING
  void keyPressed() {
    if (key=='1') {
      figure.speak("Hello, this is a text to speech demo. We are testing voices for legibility. How clearly can you understand me?");
    } else if (key== '2') {
      joke();
    } else if (key== '3') {
      aqi_report();
    }
  }


  void joke() {
    handle(joke, "joke", whichJoke, randomJoke);
    whichJoke= currentInput;
    figure.speak(text);
    println(text);
  }


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
  image(context.depthImage(), 0, 0);
  userCount = context.getNumberOfUsers();
  IntVector userList= new IntVector();
  context.getUsers(userList);

  //println ("number of users: "+ userCount);
  for (int u=0; u<userList.size(); u++) {
    int userID= userList.get(u);
    PVector position= new PVector();
    context.getCoM( userID, position);
    context.convertRealWorldToProjective(position, position);

    //TESTING COM FOR KINECT ON/OFF*****
    fill(255, 0, 0);
    textSize(40);
    text(userID, position.x, position.y, position.z);

    println ("x: " + position.x + " Y  " + position.y + " z: " + position.z);
    println ("kinect:  " + " userCount: " + userCount);
  }
}
