import moonlander.library.*;
 
// Minim must be imported when using Moonlander with soundtrack.
import ddf.minim.*;
 
Moonlander moonlander;
 
void setup() {
    // Parameters:
    // - PApplet
    // - soundtrack filename (relative to sketch's folder)
    // - beats per minute in the song
    // - how many rows in Rocket correspond to one beat
    moonlander = Moonlander.initWithSoundtrack(this, "tekno_127bpm.mp3", 127, 8);
 
    // Other initialization code goes here.
    size(800, 450, P3D);
 
    // Last thing in setup; start Moonlander. This either
    // connects to Rocket (development mode) or loads data
    // from 'syncdata.rocket' (player mode).
    // Also, in player mode the music playback starts immediately.
    moonlander.start();
}
 
boolean sketchFullScreen() {
  return false;
}
 
void draw() {
    // Handles communication with Rocket. In player mode
    // does nothing. Must be called at the beginning of draw().
    moonlander.update();
 
    // This shows how you can query value of a track.
    // If track doesn't exist in Rocket, it's automatically
    // created.
    double bg_red = moonlander.getValue("background_red");
 
    // All values in Rocket are floats; however, there's
    // a shortcut for querying integer value (getIntValue)
    // so you don't need to cast.
    int bg_green = moonlander.getIntValue("background_green");
    int bg_blue = moonlander.getIntValue("background_blue");
   
    // Use values to control anything (in this case, background color).
    //background((int)bg_red, bg_blue, bg_green);
   
    background(100);
   
    // You can also ask current time and row from Moonlander if you
    // want to do something custom in code based on time.
//    textSize(24);
//    text("Time: " + String.format("%.2f", moonlander.getCurrentTime()), 10, 30);
//    text("Row: " + String.format("%.2f", moonlander.getCurrentRow()), 10, 60);
//    text("Color values: (" + (int)bg_red + ", " + bg_green + ", " + bg_blue + ")", 10, 90);
    int size = 40;
    int xPos = 50;
    int yPos = 50;
    int n = 10;
    int shiftX = xPos + size * n / 2;
    int shiftY = yPos + size * n / 2;
    float breakPhase = moonlander.getIntValue("break_phase");
    for(int i = 0; i < n; i++) {
      for(int j = 0; j < n; j++) {
        int brokenXPos = (int)(xPos + breakingFunction(xPos + size*i, shiftX)
                          * breakPhase);
        int brokenYPos = (int)(yPos + breakingFunction(yPos + size*j, shiftY)
        * breakPhase);
        int offsetX = (int)(breakingFunction(xPos + size*i, shiftX)
                          * breakPhase * 0.3) * (i < 5 ? -1 : 1);        
        //print(brokenXPos);
//        triangle(size*i + brokenXPos - offsetX,
//                size*j + brokenYPos,
//                 size*i + brokenXPos + size - offsetX,
//                 size*j + brokenYPos + size,
//                 size*i + brokenXPos - offsetX,
//                 size*j + brokenYPos + size);
//         triangle(size*i + brokenXPos + offsetX,
//                   size*j + brokenYPos,
//                   size*i + brokenXPos + size + offsetX,
//                   size*j + brokenYPos + size,
//                   size*i + brokenXPos + size + offsetX,
//                   size*j + brokenYPos);
//        triangle(20*i,20,20 +20*i,40,20*i,40);
          //fill(255,255,255);
          beginShape(POINTS);
            vertex(size*i + brokenXPos - offsetX, size*j + brokenYPos, -50);
            vertex(size*i + brokenXPos + size - offsetX, size*j + brokenYPos + size, -50);
            vertex(size*i + brokenXPos - offsetX, size*j + brokenYPos + size, -50);
            vertex(30, 75, -50);
            endShape();
      }
    }
}
 
float breakingFunction(float x, float shift) {
  float temp = (x - shift) * 0.01f;  
  return temp*temp*temp;
}
