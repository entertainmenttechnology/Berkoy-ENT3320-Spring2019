import SimpleOpenNI.*;
SimpleOpenNI kinect;
int []values = {1,2,451,23,345,324,123,134,567,76,344,4,2,1,3};

int totalTime = 6;
float rand = random(255);


void setup(){
  size(640, 480);
  background(0);
  textSize(24);
  textAlign(CENTER);
  
  
   // intiate kinect object
  kinect = new SimpleOpenNI(this);

  //enables the method depth (IR camera)
  kinect.enableDepth();

  //enable rgb
  kinect.enableRGB();

  //Must be changed to just enableUser() otherwise error will occur and sketch will not run.
  kinect.enableUser(); 
}

void draw(){
  
  addPosY();
  ////capture the largest number on input
  //println("random Arr");
  //ranArr(values);
  
  ////print the largest number in array at Timer 0
  //if(Timer()>0){
  //  println(Timer());
  //}else{
  //  maxNum(values);
  //}
}  

void maxNum(int [] values){
  int maxNum = max(values);
  println("The max num in array is:" + " " +maxNum);
  
}

int Timer(){
  // Calculate how much time has passed
  int passedTime = totalTime - int(millis()/1000);
  background(rand);
  text(passedTime,100,100);
  // Has five seconds passed?
  if (passedTime < 0) {
    rand = random(150,255);
    background(rand); // Color a new background
    totalTime+=6;
}
  return passedTime;
}

//function for random number
void ranArr(int [] numbers){
  for (int i = 0; i< numbers.length; i++)
  {
    numbers[i] = (int)random(1, 225);
  }
  
  println(numbers);
}

float addPosY(){
  float posy;
   //update kinect for use depending on what we called (methods)
  kinect.update();
  background(0, 0, 0);

  //call and ask library for next available depth image and then place the image
  // on location xpos 0,ypos 0.
  image(kinect.rgbImage(), 0, 0);

  IntVector userList = new IntVector();
  kinect.getUsers(userList);
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
   
   //add values of person1 to posy
   posy = person1.y;
   
   println(posy);
   return posy;
   
  }


println("=========");
}
