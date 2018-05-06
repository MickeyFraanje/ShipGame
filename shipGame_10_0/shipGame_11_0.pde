/*ShipGame
 Survive as long as you can and shoot meteors out of the sky to get points.
 
 Controls Purple Ship: 
 Up = A
 Down = S
 Left = A
 Right = D
 Shoot = Spacebar
 
 Controls Green Ship:
 Up = Up arrow
 Down = Down arrow
 Left = Left arrow
 Right = Right arrow
 Shoot = Enter
 */

/*import processing.sound.*;
 SoundFile pew1; //Shooting sound for ship 1.
 SoundFile pew2; //Shooting sound for ship 2.
 SoundFile meteor; //The sound for when a meteor is hit.
 SoundFile shipHit; //Sound for when a ship is hit.
 SoundFile nextLevel; //Sound effect that plays when you have reached the next level.
 SoundFile BGM; //Background music.*/
 
 
import java.util.Collections; //collections interface
import java.util.Iterator;

PFont arcade; //The font used.

Ship ship1;  //Purple ship.
ArrayList<Bullet> bullets1; //Purple ship's bullets.
int purpleScore = 0; //Purple ship's score.
Ship ship2;  //Green ship.
ArrayList<Bullet> bullets2; //Green ship's bullets.
int greenScore = 0; //Green ship's score.
int[] highScore = new int[10]; //Array that records the highscores.

int spaceBarPressed1 = 0; 

ArrayList<SpaceNugget> nuggets; //Array of nuggets
ArrayList<Enemy> enemies; //Array of basic enemies;
int enemyTimer; //Times when to make a new enemy;
int nuggetTimer; //Times when to make a new nugget;
Star[] stars; //Array for background stars.
int starTotal = 0; //Total number of stars counted.
int starTimer; //Times when to make a new star.
int bullet1Total = 0; //Total number of bullets shot Purple Ship.
int bullet2Total = 0; //Total number of bullets shot Green Ship.
int reloadTimer1;  //Reload time for Purple Ship.
int reloadTimer2;  //Reload time for Green Ship.
Bar bar; //Progress bar;
int level = 0; //The difficulty level.
Button onePlayer; //Menu button for singleplayer mode.
Button twoPlayer; //Button for two-player mode.
Button highScoreButton; //Button to see the highscore.
Button menu; //Button to return to the main menu.
boolean gameStart = false; //Checks if the game has started.
boolean secondPlayer = false; //Checks if there should be a second player.
boolean highScoreMenu = false; //Checks if the game is in the high score menu.

void setup() {
  size(1000, 600); //Window size of the game.
  ship1 = new Ship(color(#BD3CCE), color(#FCA10D), width-2*(width/3), height/2-30); //Purple ship.
  bullets1 = new ArrayList<Bullet>(); //Array of bullets for the purple ship.
  ship2 = new Ship(color(#2EFF75), color(#FF2C84), width-2*(width/3), height/2+30); //Green ship.
  bullets2 = new ArrayList<Bullet>(); //Array of bullets for the green ship.
  enemies = new ArrayList<Enemy>(); //ArrayList of enemy meteors (though maybe they're technically asteroids).
  nuggets = new ArrayList<SpaceNugget>(); //ArrayList for spacenuggets
  stars = new Star[1000]; //Array of stars for the background.
  bar = new Bar(); //Bar that indicates when the level increases.
  onePlayer = new Button(width/2, (height/2)-150, 350, 100, "One Player"); //Button to start the game in singleplayer mode.
  twoPlayer = new Button(width/2, height/2, 350, 100, "Two Players"); //Two player mode.
  highScoreButton = new Button(width/2, (height/2)+150, 350, 100, "High Score"); //Used to go to the high score menu.
  menu = new Button((width/2), (height/2)+250, 300, 75, "Main Menu"); //The button to return to the main menu for when you are in the high score menu.
  arcade = loadFont("OCRAStd-20.vlw"); //The font used in the game.

  loadHighScore(); //Loads the highscore into the game.

  //All the sound files used in the game (all sounds made by me).
  /*pew1 = new SoundFile(this, "pew1.mp3"); //Shooting sound for player 1.
   pew2 = new SoundFile(this, "pew2.mp3"); //Shooting sound for player 2.
   meteor = new SoundFile(this, "meteor.mp3"); //Sound for when a meteor it hit.
   shipHit = new SoundFile(this, "ShipHit.mp3"); //Sound that plays when a ship is hit.
   nextLevel = new SoundFile(this, "Beepep.mp3"); //This sound plays when the timer is full and the next level starts.
   BGM = new SoundFile(this, "ShipGameBGM.mp3"); //Background music for the game.
   BGM.loop(); //Starts the background music for the gameplay and loops it.*/
}

void draw() {
  background(#12001C);
  makeStars(); //Makes stars.
  mainMenu(); //Shows the main menu.
  //println(spaceBarPressed1);
}

void mainMenu() {
  if (gameStart) {
    gamePlay(); //Starts the gameplay.
  } else if (gameStart == false && highScoreMenu == false) { //Loads up the start menu
    onePlayer.display();
    twoPlayer.display();
    highScoreButton.display();
    if (onePlayer.pressed()) { //Starts the game.
      gameStart = true;
      level = 0;
      ship1.alive = true;
      ship1.health = 3;
    } else if (twoPlayer.pressed()) { //Starts a two player game.
      gameStart = true;
      level = 0;
      ship1.alive = true;
      ship1.health = 3;
      ship2.alive = true;
      ship2.health = 3;
      secondPlayer = true;
    } else if (highScoreButton.pressed()) { //High Score screen.
      highScoreMenu = true;
    }
  } else if (highScoreMenu) {
    showHighScore();
    if (menu.pressed()) {
      highScoreMenu = false;
    }
  }
}
void keyPressed() {
  if (key == 'w') { //Purple ship controls.
    ship1.direction("up");
  } else if (key == 's') {
    ship1.direction("down");
  } else if (key == 'a') {
    ship1.direction("left");
  } else if (key == 'd') {
    ship1.direction("right");
  }  
  if (key == ' ' && millis()-reloadTimer1 >= 100) { //Creates a new bullet for the purple ship when pressed.
    Bullet nBullet = new Bullet(ship1.xpos+30, ship1.ypos, color(#FCA10D));
    bullets1.add(nBullet);
    reloadTimer1 = millis(); //Resets the reload time.
    spaceBarPressed1++;
    // pew1.play(); //Plays the sound effect.
  } 
  if (keyCode == UP) { //Green ship controls.
    ship2.direction("up");
  } else if (keyCode == DOWN) {
    ship2.direction("down");
  } else if (keyCode == LEFT) {
    ship2.direction("left");
  } else if (keyCode == RIGHT) {
    ship2.direction("right");
  }
  if (keyCode == ENTER && millis() - reloadTimer2 >= 100) { //Creates new bullet for the green ship when pressed.
    Bullet nBullet = new Bullet(ship2.xpos+30, ship2.ypos, color(#FF2C84));
    bullets2.add(nBullet);
    reloadTimer2 = millis(); //Resets the reload time
    //pew2.play(); //Plays the sound effect.
  }
}

void keyReleased() {
  if (key == 'w') { //Stops the purple ship from moving when key is released.
    ship1.direction("stop up");
  } else if (key == 's') {
    ship1.direction("stop down");
  } else if (key == 'a') {
    ship1.direction("stop left");
  } else if (key == 'd') {
    ship1.direction("stop right");
  } else if (keyCode == UP) { //Stops the green ship from moving when key is released.
    ship2.direction("stop up");
  } else if (keyCode == DOWN) {
    ship2.direction("stop down");
  } else if (keyCode == LEFT) {
    ship2.direction("stop left");
  } else if (keyCode == RIGHT) {
    ship2.direction("stop right");
  }
}

void gamePlay() {
  fill(ship1.c);
  textFont(arcade);
  text("Score " + purpleScore, 200, 30); //Shows purple score.
  fill(bar.c);
  text("Level " + level, width - 100, 30);
  makeBullets(); //Makes bullets.
  makeEnemies(); //Makes enemies.
  makeNuggets(); //Makes nuggets.
  
  showLives(ship1, 21); //Shows the amount of lives the ship has left.
  secondPlayerInfo(); //Adds info for the second player if it is two player mode.
  bar.move(); 
  bar.display();
  displayShips(); //Displays the ships if they are alive.
  bulletHit(); //Checks if a bullet is hitting an enemy.
  endGame(); //Ends the game, updates the high score and goes back to the main menu.
}

void showHighScore() {
  PFont title = loadFont("OratorStd-50.vlw"); //Font used for the text above the score.
  PFont score = loadFont("OratorStd-30.vlw"); //Font used for the high score itself.
  int xpos = (width/2)-150; //X position.
  int ypos = ((height/2)-175); //Y position.
  textAlign(CENTER);
  textFont(title);
  text("High Score", width/2, ypos - 50);
  textAlign(LEFT);
  textFont(score); 
  text("1st ", xpos, ypos);
  text("2nd ", xpos, ypos+40);
  text("3rd ", xpos, ypos+80);
  text("4th ", xpos, ypos+120);
  text("5th ", xpos, ypos+160);
  text("6th ", xpos, ypos+200);
  text("7th ", xpos, ypos+240);
  text("8th ", xpos, ypos+280);
  text("9th ", xpos, ypos+320);
  text("10th ", xpos, ypos+360);

  textAlign(RIGHT);
  for (int i = 0; i<highScore.length; i++) {
    text(highScore[i], xpos+300, ypos+(i*40));
  }
  menu.display();
}

void loadHighScore() {
  String[] data = loadStrings("highScore.txt"); //Loads the previous highscores.
  String temp = join(data, ','); //Puts the data on a single line so it can be split more easily.
  highScore = int(split(temp, ',')); //Splits the scores, converts them to int and puts them in the highScore array.
}

void updateHighScore() {
  String[] data = new String[10]; //String array to store the highscores.
  if (highScore[9] <= (purpleScore + greenScore)) { //Checks if the total score is higher than the lowest on the list.
    highScore[9] = purpleScore + greenScore; //If it is higher, it replaces it.
    highScore = sort(highScore); //Sorts the array from lowest to highest.
    highScore = reverse(highScore); //Reverses the array so the highest score is at the top.
  } 
  for (int i = 0; i<highScore.length; i++) {
    data[i] = str(highScore[i]); //The highscores are stored in the String array.
  }
  saveStrings("data/highScore.txt", data); //The highscores are saved to the text file.
}

void endGame() {
  if (secondPlayer) { // If both players are dead the game ends.
    if (ship1.alive == false && ship2.alive == false) {
      updateHighScore();
      gameStart = false;
      secondPlayer = false;
      enemies.clear(); //Resets the enemies.
      nuggets.clear(); //Clears dem nuggets.
      purpleScore = 0; //Resets score.
      greenScore = 0;
    }
  } else { //If the player is dead in singleplayer mode the game ends.
    if (ship1.alive == false) {
      updateHighScore();
      gameStart = false;
      enemies.clear(); //Resets the enemies. 
      nuggets.clear(); //Clears the nuggets;
      purpleScore = 0; //Resets score.
      spaceBarPressed1 = 0;
    }
  }
}

void displayShips() { //Function that displays the ships when they are alive.
  if (ship1.alive) {
    ship1.update();
    ship1.display();
  }
  if (ship2.alive) {
    ship2.update();
    ship2.display();
  }
}

void secondPlayerInfo() { //Function that adds the info for the second player if two player mode is selected.
  if (secondPlayer) {
    fill(ship2.c);
    text("Score " + greenScore, 200, height - 10); //Shows green score.
    showLives(ship2, height - 19);
  }
}

void showLives(Ship s, int y) { //Function to display the amount of lives a ship has.
  fill(s.c); //Uses the ship's colour.
  switch(s.health) {
  case 3:
    ellipse(30, y, 20, 20);
    ellipse(70, y, 20, 20);
    ellipse(110, y, 20, 20);
    break;
  case 2:
    ellipse(30, y, 20, 20);
    ellipse(70, y, 20, 20);
    break;
  case 1:
    ellipse(30, y, 20, 20);
    break;
  case 0:
    break;
  }
}

void bulletHit() { //Function to check if a bullet hit an enemy.
  Iterator<Bullet> bulletIter1 = bullets1.iterator();
  while (bulletIter1.hasNext()) { //Detects if the purple ship has hit an enemy.
    Bullet b = bulletIter1.next();
    Iterator<Enemy> enemyIter = enemies.iterator();
    while (enemyIter.hasNext()) {
      Enemy e = enemyIter.next();
      if (b.impact(e)) {
        e.hit();
        purpleScore++;
      }
    }
  }
  Iterator<Bullet> bulletIter2 = bullets2.iterator();
  while (bulletIter2.hasNext()) { //Detects if the green ship has hit an enemy.
    Bullet b = bulletIter2.next();
    Iterator<Enemy> enemyIter = enemies.iterator();
    while (enemyIter.hasNext()) {
      Enemy e = enemyIter.next();
      if (b.impact(e)) {
        e.hit();
        greenScore++;
      }
    }
  }
}

void makeStars() {
  if (millis()-starTimer>=100) {  //Every 100 milliseconds a new star is initialised 
    stars[starTotal] = new Star(); //New star.
    starTotal++; //Adds the star to the total.
    starTimer = millis(); //Resets the timer.
    if (starTotal>=stars.length) {
      starTotal = 0; //Starts over.
    }
  }
  for (int i = 0; i<starTotal; i++) { //Moves and displays each star.
    stars[i].move();
    stars[i].display();
  }
}

void makeBullets() {
  Iterator<Bullet> bulletIter1 = bullets1.iterator();
  while (bulletIter1.hasNext()) {
    Bullet b = bulletIter1.next();
    b.move();
    b.display();
  }
  Iterator<Bullet> bulletIter2 = bullets2.iterator();
  while (bulletIter2.hasNext()) {
    Bullet b = bulletIter2.next();
    b.move();
    b.display();
  }
}

void makeNuggets() {
  if (millis()-nuggetTimer>=random(5000, 7000)) {
    SpaceNugget newNugget = new SpaceNugget(random(width*0.3, width*0.6), random(50, height-50));
    nuggets.add(newNugget);
    nuggetTimer = millis();
  }
  Iterator<SpaceNugget> nuggetIter = nuggets.iterator();
  while (nuggetIter.hasNext()) {
    SpaceNugget n = nuggetIter.next();
    n.move();
    n.display();
    if(n.xpos < -50){
      nuggetIter.remove();
      }
    } 
}

void makeEnemies() {
  if (millis()-enemyTimer>=random(300, 2000)) { //Makes new enemies.
    Enemy newEnemy = new Enemy(width+20, random(50, height-50));
    enemies.add(newEnemy);
    enemyTimer = millis();
  }
  Iterator<Enemy> enemyIter = enemies.iterator();
  while (enemyIter.hasNext()) {
    Enemy e = enemyIter.next();
    e.move();
    e.display();
    if (e.impact(ship1)) {
      ship1.hit();
    }
    if (e.impact(ship2)) {
      ship2.hit();
    }
    if (e.xpos < -50){
      enemyIter.remove();
    }
  }
}