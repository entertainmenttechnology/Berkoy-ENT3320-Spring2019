/*
  Stage Challenge
 
  
  ==============================
  
  Author: Johnny, Daniel, Anthony, Oleg
  
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
   
   //run for loop to locate person in front of camera
   for (int i=0; i<userList.size(); i++) { 
   
     //get an id for each person in the camera view.
     int userId = userList.get(i);
     PVector position = new PVector();
     
     kinect.getCoM(userId, position); 
     kinect.convertRealWorldToProjective(position, position);
     
     distance = position.z / 25.4;
     boundaryX = position.x / 25.4;
     
    
    //fill(255,0,0);
    //    textAlign(CENTER);
    //    textSize(40);
    //   text(position.x/25.4, position.x, position.y);
     
    
       if(distance < 128 && boundaryX > 2 && boundaryX < 21.5 ){
         fill(255,0,0);
         textAlign(CENTER);
         textSize(40);
         text("On Stage", position.x, position.y);
         
       }
       else if(distance < 175 && boundaryX > 4 && boundaryX < 20){
          fill(0,255,0);
          textAlign(CENTER);
          textSize(40);
          text(userId, position.x, position.y);
          
         
          
          if(mousePressed == true){
            mouseClicked(userList, position);
          }
          
       }
       else{
          /*
          textAlign(CENTER);
          textSize(40);
          text("Waiting For Users", width/2, height/2);
          */
       }
     
     
     
   }

}
void randomBox(IntVector id)
{
  
  
}

void mouseClicked(IntVector userList, PVector position){
  
  println("Random Box running");
  int length = int(userList.size());
  int []arr=new int[length];
  for (int i = 0; i < userList.size(); i++){
    arr[i] = userList.get(i);
    //println(arr[i]);
  } 
  
  int index = int(random(arr.length));  // Same as int(random(4))
  println("Index:");
  println(arr[index]);
   noFill();
   strokeWeight(4);
   stroke(0,255,0);
   rectMode(CENTER);
   rect(position.x, position.y, 100,200);
  //println(arr);
}
