//Class for the basic meteor enemy.

class spaceNugget {
  float xpos, ypos;
  float xspeed;
  color c; //Primary colour.

  spaceNugget(float tempX, float tempY) {
    xpos = tempX;
    ypos = tempY;
    c = color(#FFE658);
    xspeed = random(2+level/2, 3+level); //Speed increases based on level. 
  }

  void move() {
    xpos = xpos - xspeed;
  }
  void display() {

    //Displaying the enemies.
    noStroke();
    fill(c);
    ellipse(xpos, ypos, 10, 10);
  }
  void hit() {
    //meteor.play(); //Plays a hit sound.
    xpos = -100;
    xspeed = 0;
  }
  /*boolean impact(Ship s) { //Checks if it hits a ship.
    if (xpos-15<s.xpos+20 && xpos+15>s.xpos-20 && ypos-15<s.ypos+20 && ypos+15>s.ypos-20) {
      ypos = height+50;
      xspeed = 0;
      return true;
    } else {
      return false;
    }
  }*/
}