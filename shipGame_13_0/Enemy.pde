//Class for the basic meteor enemy.

class Enemy {
  float xpos, ypos;
  float xspeed;
  color c; //Primary colour.
  color t; //Secondary colour.
  int[] xTrail = new int[40], yTrail = new int[40]; //Trail behind enemy

  Enemy(float tempX, float tempY) {
    xpos = tempX;
    ypos = tempY;
    c = color(#CB3535);
    t = color(#FC5759);
    xspeed = random(2+level/2, 3+level); //Speed increases based on level.
    
     //Initialize smoke trail array.
    for (int i=0; i<xTrail.length; i++) {
      xTrail[i] = -40;
      yTrail[i] = -40;
    }
  }

  void move() {
    xpos = xpos - (xspeed * purpleScore/10);

    //Shifting the index of the trail arrays.
    for (int i=0; i<xTrail.length-1; i++) {
      xTrail[i] = xTrail[i+1];
      yTrail[i] = yTrail[i+1];
    }
    //Updating the final spot of the array to the current location of the ship.
    xTrail[xTrail.length-1] = int(xpos);
    yTrail[yTrail.length-1] = int(ypos);
  }

  void display() {

    //Drawing the actual smoke trail.
    for (int i=0; i<xTrail.length; i++) {
      fill(t, 0 + i *10);
      ellipse(xTrail[i], yTrail[i], i, i);
    }
    //Displaying the enemies.
    noStroke();
    fill(c);
    ellipse(xpos, ypos, 40, 40);
  }
  void hit() {
   // meteor.play(); //Plays a hit sound.
    xpos = -100;
    xspeed = 0;
  }
  boolean impact(Ship s) { //Checks if it hits a ship.
    if (xpos-15<s.xpos+20 && xpos+15>s.xpos-20 && ypos-15<s.ypos+20 && ypos+15>s.ypos-20) {
      xpos = -50;
      xspeed = 0;
      return true;
    } else {
      return false;
    }
  }
}