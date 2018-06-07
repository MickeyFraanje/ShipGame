//Class for the bullets being shot.

class Bullet{
  float xpos, ypos;
  float speed;
  color c;
  
  Bullet(float tempX, float tempY, color tempC){
    xpos = tempX;
    ypos = tempY;
    c = tempC;
    speed = 10;
  }
  
  void display(){
    noStroke();
    fill(c);
    ellipse(xpos, ypos, 15, 8);
  }
  
  void move(){
    xpos = xpos+speed;
  }
  
  boolean impact(Enemy e){ //Checks if a bullet has hit an enemy.
    if(xpos>e.xpos-20 && xpos<e.xpos+20 && ypos>e.ypos-20 && ypos<e.ypos+20){
      ypos = -100;
      speed=0;
      return true;
    }else{
      return false;
    }
  }
}