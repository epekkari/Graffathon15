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
  //  moonlander = Moonlander.initWithSoundtrack(this, "tekno_127bpm.mp3", 127, 8);
 
    // Other initialization code goes here.
    size(800, 450, P3D);
 
 

    // Last thing in setup; start Moonlander. This either
    // connects to Rocket (development mode) or loads data
    // from 'syncdata.rocket' (player mode).
    // Also, in player mode the music playback starts immediately.
   // moonlander.start();
}
 
boolean sketchFullScreen() {
  return false;
}
 
void draw() {
   drawCube();
} 
 
void drawCube() {
 //   clear();
 // moonlander.update();
    
    beginCamera();
    camera();
    translate(width/2, height/2);
    rotateY(millis()/1000f);
    endCamera();
 
   /* double bg_red = moonlander.getValue("background_red");
    int bg_green = moonlander.getIntValue("background_green");
    int bg_blue = moonlander.getIntValue("background_blue");  */
    background(100);
   
    float baseX=width/2;
    float baseY=height/2;
    float baseZ=0;
    
//    rotateX((float)millis()/1000f);
//    rotateY((float)millis()/1000f);
    int size=50;
    
    pushMatrix();
    
    translate(0, -size, 0);
    
    drawPyramid(size);

    
    popMatrix();
    pushMatrix();
    
    translate(0, 2*size, 0);
    rotateZ(PI);
    
    drawPyramid(size);
    
    popMatrix();
    pushMatrix();
   
    translate(0, size, -size);
    rotateX(PI/2);
    
    drawPyramid(size);
    
    popMatrix();

    perspective();

     
}

void drawPyramid(int size) {
      float[] v1={1*size,0,1*size};
    float[] v2={-1*size,0,1*size};
    float[] v3={-1*size,0,-1*size};
    float[] v4={1*size,0,-1*size};
    float[] v5={0,1*size,0};
    float[][] verts={v1,v2,v3,v4,v5};
    fill(255);
    beginShape(TRIANGLES);
    int i;
    int i2;
    int i3;
    for(i=0; i<5 ;i++){
      for(i2=0; i2<5 ;i2++){
        if(i2==i){
          continue;
        }
        for(i3=0; i3<5 ;i3++){
          if(i3==i2||i3==i){
            continue;
          }
          vertex( verts[i][0],verts[i][1],verts[i][2]);
          vertex( verts[i2][0],verts[i2][1],verts[i2][2]);
          vertex( verts[i3][0],verts[i3][1],verts[i3][2]);
        }
      }
    }
    
    endShape();
    
//    textSize(32);
//    fill(255, 102, 0);
//    text("V1",v1[0], v1[1],v1[2]); 
//    text("V2",v2[0], v2[1],v2[2]); 
//    text("V3",v3[0], v3[1],v3[2]); 
//    text("V4",v4[0], v4[1],v4[2]); 
//    camera((70f-140f*sin(millis()/1000f)*20f)/3 ,35 , 120.0, 0,0, 0, 
//    0.0, 1.0, 0.0);
}

