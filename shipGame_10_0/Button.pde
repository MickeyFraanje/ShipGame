//Class for the buttons used in the game menus.

class Button {
  float xpos, ypos; //Location.
  float sizeX, sizeY; //Size.
  color c; //Primary colour.
  color t; //secondary colour.
  String buttonText; //
  PFont text;

  Button(float tempX, float tempY, float tempSizeX, float tempSizeY, String s) {
    xpos = tempX;
    ypos = tempY;
    sizeX = tempSizeX;
    sizeY = tempSizeY;
    buttonText = s;
    c = color(#12001C);
    t = color(#FFD62E);
    text = loadFont("OratorStd-50.vlw"); //Font used in the menus.
  }
  void display() {
    if (mouseX < xpos+175 && mouseX > xpos-175 && mouseY < ypos+25 && mouseY > ypos-25) {
      stroke(t);
      fill(t);
    } else {
      stroke(255);
      fill(255);
    }
    strokeWeight(2);
    textAlign(CENTER);
    textFont(text);
    text(buttonText, xpos, ypos+18);
    rectMode(CENTER);
    noFill();
    rect(xpos, ypos, sizeX, sizeY);
   
  }
  boolean pressed(){
    if(mouseX < xpos+175 && mouseX > xpos-175 && mouseY < ypos+25 && mouseY > ypos-25 && mousePressed){
      return true;
    }else{
      return false;
    }
  }
}