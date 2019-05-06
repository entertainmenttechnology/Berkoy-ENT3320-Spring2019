int totalTime = 6;
float rand = random(255);

void setup() {
  size(200, 200);
  background(0);
  textSize(24);
  textAlign(CENTER);
}

void draw() {
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
  
}
