/*
  Stage Challenge
 
  
  ==============================
  
  Author: Johnny, Daniel, Anthony, Oleg
  
  CHANGE LOCATION OF FOR LOOP TO ONLY LOCATE THE RANDOM PERSON WHO IS SELECTED
  CHA 3 AND 4 NEEDED
  
*/

//importing library
import SimpleOpenNI.*;

//SET KINECT 9 SQUARES AWAY FROM CHAIR

//declare object name it kinect
SimpleOpenNI kinect;


float RX, RY; //initionalizing X and Y variable as flaot(decimal #)
float RW = 140; // Setting the Rectangle width
float RH = 130; // Setting the Rectangle Height
float distance;
float boundaryX;
int state = 0; 
int rand = -1;

//run setup
void setup() {
 
   // Size of the sketch
   size(640, 480);
   
   // intiate kinect object
   kinect = new SimpleOpenNI(this);
   
   //enables the method depth (IR camera)
   kinect.enableDepth();
   
   //enable rgb
   kinect.enableRGB();
   
   //Must be changed to just enableUser() otherwise error will occur and sketch will not run.
   kinect.enableUser(); 
   
   //X and Y positions of the rectangle.
   RX = width/2 - RW/2;
   RY = (height/2 - RW/2)*2;
 
}

//run draw loop
void draw() {
  
   //update kinect for use depending on what we called (methods)
   kinect.update();
   background(0, 0, 0);

   //call and ask library for next available depth image and then place the image
   // on location xpos 0,ypos 0.
   image(kinect.rgbImage(), 0, 0);

   IntVector userList = new IntVector();
   kinect.getUsers(userList);
   
   //create a rectangle with origin in the center of the sketch
   //give the rectangle no fill or stroke (invisible)
   noFill();
   noStroke();
   rect(RX, RY, RW,RH);
   
   
       
   voter(userList);
     
     
     
   }
   
   
   
   void voter(IntVector userList){
     kinect.getUsers(userList);
     
     //loop to get all the CoM
     for(int i = 0; i < userList.size(); i++){
       PVector position = new PVector();
       int userId = userList.get(i);
       //get Center of Mass 
       kinect.getCoM(userId, position); 
       kinect.convertRealWorldToProjective(position, position);
       
       //if position of user at y > 20
       if(position.y > 20){
         //print that userID
         println(userId);
       }
       else{
         //print none of the above
         println("none");
       }
       //make everyone sit down as an initial state
       //Start game
     }
     
     
     
   }
   
   
   /*
     States:
      --> State 0
          --> for loop to detect people
      --> State 1
          --> if statements for choosing people

   
   */
