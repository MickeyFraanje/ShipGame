//Class for the basic nugget from space.

class SpaceNugget {
  float xpos, ypos;
  float xspeed;
  color c; //Primary colour.
  color t; //Secondary colour

  SpaceNugget(float tempX, float tempY) {
    xpos = tempX;
    ypos = tempY;
    c = color(#FCA10D);
    t = color(#FCDDAB);
    xspeed = 0; //Speed increases based on level. 
  }

  void move() {
    xpos = xpos - xspeed;
  }
  void display() {

    //Displaying the enemies.
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
    xspeed = 0;
  }
  boolean impact(Ship s) { //Checks if it hits a ship.
    if (xpos-15<s.xpos+20 && xpos+15>s.xpos-20 && ypos-15<s.ypos+20 && ypos+15>s.ypos-20) {
      ypos = height+50;
      xspeed = 0;
      return true;
    } else {
      return false;
    }
  }
}