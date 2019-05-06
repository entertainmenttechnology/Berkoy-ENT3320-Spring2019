//importing library
import SimpleOpenNI.*;

//SET KINECT 9 SQUARES AWAY FROM CHAIR

//declare object name it kinect
SimpleOpenNI kinect;


float[] y = new float[height];
int state = 0;
int totalTime = 0;
int rand = -1;
float a = 0;
float b = 0;
float c = 0;




void setup() { 
  size(500, 500);

   // intiate kinect object
  kinect = new SimpleOpenNI(this);

  //enables the method depth (IR camera)
  kinect.enableDepth();

  //enable rgb
  kinect.enableRGB();

  //Must be changed to just enableUser() otherwise error will occur and sketch will not run.
  kinect.enableUser(); 
}

void draw() {
  println("location is: " + a);
    //update kinect for use depending on what we called (methods)
  kinect.update();
  background(0, 0, 0);

  //call and ask library for next available depth image and then place the image
  // on location xpos 0,ypos 0.
  image(kinect.rgbImage(), 0, 0);

  IntVector userList = new IntVector();
  kinect.getUsers(userList);
  // Shift the values to the right
  for (int i=0; i<userList.size(); i++) { 

    //get an id for each person in the camera view.
    int userIdChosen = userList.get(i);
    PVector person1 = new PVector();

    kinect.getCoM(userIdChosen, person1); 
    kinect.convertRealWorldToProjective(person1, person1);
      fill(0, 255, 0);
      textAlign(CENTER);
      textSize(40);
      text(userIdChosen, person1.x, person1.y);
  
  if (state == 0){
   a = person1.y;
   state = 1;
}
  if (state == 1){
  for (int q = y.length-1; q > 0; q--) {
    y[q] = y[q-1];
  }
  // Add the new values to the beginning of the array
  y[0] = person1.y;
  for (int w = 0; w < y.length; w++) {
    println("y position is:  " + y[w]);
    
      if(totalTime == 0)
  {
    totalTime=millis()/1000 + 5;
  }
  int passedTime = totalTime - int(millis()/1000);
  if (passedTime <= 0) {
    totalTime = 0;
    state = 2;
  }
  }
  if (state == 2){
  b = min(y);  
  c = b - a;
  println("height is:  " + c);
  println("Max Height was:  " + min(y));
  }

  }
  }
}
