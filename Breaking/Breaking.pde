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
   moonlander = Moonlander.initWithSoundtrack(this, "summerCart.mp3", 137, 8);
 
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
   beginCamera();
   camera();
   translate(width/2, height/2, 0);
   //translate(width/2+60*sin(millis()/1000f), height/2, 60*sin(millis()/1000f));
   rotateY(-PI*137/60*millis()/1000f/5);
   //translate(width/2, height/2);
   endCamera();
   
   background(100);
   float cubeSize = 50f;
  
   pushMatrix();
   translate(secondPower()*cubeSize, 0, 0);
   drawCube(cubeSize);
   popMatrix();
   
   pushMatrix();
   translate(-1*secondPower()*cubeSize, 0, 0);
   drawCube(cubeSize);
   popMatrix();
   
   perspective();
} 

float secondPower() {
    if (millis() > 5000) {
       return 3.0f;
    } else if (millis() < 2000) {
       return 0.0f;
    } else {
       return (float)(millis()/1000f); 
    }
}
 
void drawCube(float size) {
    // clear();
    // moonlander.update();
 
    float beat = 40*abs(sin(PI*137/60*millis()/1000f));
    rotateY(millis()/1000f);
    
    //y
    pushMatrix();
    translate(0, -(size+beat), 0);
    rotateY(PI*137/60*millis()/1000f);
    drawPyramid(size);
    popMatrix();
    
    //-y
    pushMatrix();
    translate(0, size+beat, 0);
    rotateZ(PI);
    rotateY(-PI*137/60*millis()/1000f);
    drawPyramid(size);
    popMatrix();
    
    //x
    pushMatrix();
    translate(0, 0, -(size+beat));
    rotateX(PI/2);
    rotateY(PI*137/60*millis()/1000f);
    drawPyramid(size);
    popMatrix();
    
    //-x
    pushMatrix();
    translate(0, 0, size+beat);
    rotateX(-PI/2);
    rotateY(-PI*137/60*millis()/1000f);
    drawPyramid(size);
    popMatrix();
    
    //z
    pushMatrix();
    translate(size+beat, 0, 0);
    rotateX(PI*137/60*millis()/1000f);
    rotateZ(PI/2);
    drawPyramid(size);
    popMatrix();
    
    //-z
    pushMatrix();
    translate(-(size+beat), 0, 0);
    rotateX(-PI*137/60*millis()/1000f);
    rotateZ(-PI/2);
    drawPyramid(size);
    popMatrix();
     
}

void drawPyramid(float size) {
    noStroke();
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
          if(i==4||i2==4||i3==4){
            fill(255,0,0);
          } else {fill(6,255,18);}
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

