//Class for the progress bar.

class Bar {
  float xpos;
  float progress;
  int timerReset;
  color c;

  Bar() {
    xpos = 0;
    progress = millis();
    c = color(#DB7900);
  }
  void move() {
    if (ship1.alive) { //The level only progresses if anyone is still alive.
      xpos = xpos + progress/50; //Speed at which the bar progresses.
      if (xpos >= 500) {
      //  nextLevel.play(); //Plays sound effect.
       SpaceNugget newNugget = new SpaceNugget(random(width*0.3, width*0.6), random(50, height-50));
    nuggets.add(newNugget);
        xpos = 0;
      }
    } else{
      xpos = 0;
    }
  }
  void display() {
    rectMode(CENTER);
    fill(c);
    rect(width-10, (height/2), 10, xpos);
  }
}