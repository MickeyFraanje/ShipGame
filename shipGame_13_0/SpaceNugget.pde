//Class for the basic nugget from space.

class SpaceNugget {
  float xpos, ypos;
  color c; //Primary colour.
  color t; //Secondary colour

  SpaceNugget(float tempX, float tempY) {
    xpos = tempX;
    ypos = tempY;
    c = color(#FCA10D);
    t = color(#FCDDAB); 
  }

  void display() {

    //Displaying the nuggets.
    stroke(t);
    strokeWeight(3);
    noFill();
    ellipse(xpos, ypos, 15, 15);
    fill(c);
    noStroke();
    ellipse(xpos, ypos, 10, 10);
  }
  void hit() {
    //meteor.play(); //Plays a hit sound.
    xpos = -100;
  }
  boolean impact(Ship s) { //Checks if it hits a ship.
    if (xpos-7.5<s.xpos+20 && xpos+7.5>s.xpos-20 && ypos-7.5<s.ypos+20 && ypos+7.5>s.ypos-20) {
      xpos = -50;
      return true;
    } else {
      return false;
    }
  }
}