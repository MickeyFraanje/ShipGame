//Class for the ship that the player controls

class Ship {
  color c; //Colour of the ship.
  color t; //Colour of the trail.
  float xpos, ypos; //The x and y position of the ship.
  float xspeed, yspeed; //The x and y speed of the ship.
  float velocity = 0.12; //Velocity of the ship;
  String d; //Direction the ship is moving in.
  boolean up, down, left, right; //Directions the ship can move in.
  int[] xTrail = new int[40], yTrail = new int[40]; //Smoke trail behind ship.
  Boolean alive = false; //As long as this is true, the ship lives.
  int health = 3; //Amount of times the ship can get hit.
  
  Ship(color tempC, color tempT, float tempX, float tempY) {
    c = tempC; 
    t = tempT;
    xpos = tempX;
    ypos = tempY;
    xspeed = 1;
    yspeed = 1;

    //Initialize smoke trail array.
    for (int i=0; i<xTrail.length; i++) {
      xTrail[i] = 0;
      yTrail[i] = 0;
    }
  }

  //Displays the ship.
  void display() {
    noStroke();

    //Shifting the array values of the smoke trail.
    for (int i=0; i<xTrail.length-1; i++) {
      xTrail[i] = xTrail[i+1]-3;
      yTrail[i] = yTrail[i+1];
    }
    //Updating the final spot of the array to the current location of the ship.
    xTrail[xTrail.length-1] = int(xpos);
    yTrail[yTrail.length-1] = int(ypos);
    //Drawing the actual smoke trail.
    for (int i=0; i<xTrail.length; i++) {
      fill(t, 0 + i *10);
      ellipse(xTrail[i], yTrail[i], i, i);
    }
    //Drawing the ship.
    rectMode(CENTER);
    fill(c);
    ellipse(xpos, ypos, 40, 40);
    rect(xpos+12, ypos, 20, 25);
    rect(xpos+18, ypos, 20, 15);
    rect(xpos+25, ypos, 30, 5);
    rect(xpos-18, ypos, 20, 5);
    rect(xpos-10, ypos+18, 20, 5);
    rect(xpos-10, ypos-18, 20, 5);
  }

//Sets the direction for the ship in a way that allows multiple ships.
  void direction(String tempD) {
    d = tempD;
    switch(d) {

    case "up":
      up = true;
      break;
    case "down":
      down = true;
      break;
    case "left":
      left = true;
      break;
    case "right":
      right = true;
      break;
    case "stop up": 
      up = false;
      break;
    case "stop down":
      down = false;
      break;
    case "stop left":
      left = false;
      break;
    case "stop right":
      right = false;
      break;
    }
  }
  //Updates the location and speed of the ship.
  void update() {
    xpos = xpos+xspeed;
    ypos = ypos+yspeed;
    
    // Slightly floaty controls since the ship flies in space.
    if (up) {
      yspeed = yspeed-velocity;
    } else if (down) {
      yspeed = yspeed+velocity;
    } else if (left) {
      xspeed = xspeed-velocity;
    } else if (right) {
      xspeed = xspeed+velocity;
    } else {
      xspeed = 0; 
      yspeed = 0;
    }
    
    xspeed = constrain(xspeed, -3, 3);
    yspeed = constrain(yspeed, -5, 5);
    xpos = constrain(xpos, 150, width);
    ypos = constrain(ypos, 50, height-50);
  }
  void hit(){
  //  shipHit.play();
    int h = millis();
    if(millis() - h <= 100){
     xpos = xpos-1000;
    }else{
     xpos = xpos +1000;
    }
    health--;
    if(health == 0){
      alive = false;
    }
  }
}