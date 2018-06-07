// Class for the stars that fly by in the background

class Star{
  color c;
  float xpos, ypos;
  float xspeed;
  
  Star(){
    c = color(255);
    xpos = width;
    ypos = random(height);
    xspeed = random(1, 10);
  }
  
  // Displaying the stars.
  void display(){
    noStroke();
    fill(c);
    ellipse(xpos, ypos, 2, 2);
  }
  // Moving the stars.
  void move(){
    xpos = xpos - xspeed;   
  }
}