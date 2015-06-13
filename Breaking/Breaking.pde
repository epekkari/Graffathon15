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
  //
  moonlander = Moonlander.initWithSoundtrack(this, "summerCartLyhennetty.mp3", 137, 4);
 
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
   clear();
   int demoState=moonlander.getIntValue("demoState");
    
   background(demoState*50);
   if(demoState>-1&&demoState<3){
     doIntro(demoState);
   }else if(demoState==3){
     doTheSplitCubesThing();
     drawExtraCubes();
   }
   
    textSize(32);
    fill(255, 102, 0);
    text("State: "+demoState+" "+crapToShowInDebug, width-200, 35,0 );
   moonlander.update();
} 
void drawExtraCubes(){
  int i;
  int i2;
  float scalingValue=1000f;
  pushMatrix();
  
//  translate(width,height,0);
  translate(-scalingValue, 0, -scalingValue*2); 
  for(i=0;i<3;i++){  
       pushMatrix();
    for(i2=0;i2<3;i2++){
      translate(0,0,scalingValue);
        
      if(i==0){
        fill(255*sin((millis()+i*10)/1000f), 255*cos((millis()+i2*10)/1000f),255*tan(millis()/1000f) );
      } else if(i==1) {
        fill( 255*cos((millis()+i2*10)/1000f),255*sin((millis()+i*10)/1000f),255*tan(millis()/1000f) );  
      } else{
        fill(255*tan(millis()/1000f)  ,255*cos((millis()+i2*10)/1000f),255*sin((millis()+i*10)/1000f));  
      }
      if(i2==1&&i==1){
        translate(0,scalingValue,0);
        box(scalingValue);
        translate(0,-scalingValue*2,0);
        box(scalingValue);
        continue;
      }  
      box(scalingValue);
   
    }
     popMatrix();
    translate(scalingValue,0,0);
  }
  popMatrix();
}
String crapToShowInDebug="";
double lastValue;
void cubeLine(float deltaX, float deltaY, boolean doFunkySpirals, double intro){
  float i;
  pushMatrix();
  for(i=0;i<intro;i++){
     translate(deltaX,deltaY,(float)(intro/52));
     box(20, 80, 20);
     if(doFunkySpirals){
       rotateZ((2*PI)*(sin(millis()/10000f ) ));
     }
   }
  popMatrix();
}
void doIntro(int demoState){
  noStroke();
   double intro=moonlander.getValue("introState");
   if(demoState==0){
      background( 0);
      return; 
   }
   
   background((float) (255*(intro%4)), 255, 0);
   
   cubeLine(20,20, false, intro);
   pushMatrix();
   translate(width,0);   
   cubeLine(-20,20,true, intro);
   popMatrix();
   pushMatrix();
   translate(width,height);
   cubeLine(-20,-20,false, intro);
   popMatrix();
   pushMatrix();
   translate(0,height);
   cubeLine(20,-20,true, intro);
   popMatrix();
   crapToShowInDebug=""+intro;
   if(intro>24) {
     
     int i;
      for(i=0; i<2;i++){
         pushMatrix();
         translate(-width+width*i*3,-height+height*i*3);
         cubeLine(20,-20,true, intro-24);
         popMatrix();
         pushMatrix();
         translate(-width+width*i*3,-height+height*abs(i-1)*3);
         cubeLine(20,-20,true, intro-24);
         popMatrix();
      }
   }
   if(intro>34) {
     
     fill(255);
     int i;
     float f=lerp(0,width*4f,((float)intro-34f)/(50f-34f));
      pushMatrix();
      translate(width/2, height,40);
      box(f , height/3,height/3);
      translate(0, -height,0);
      box(f , height/3,height/3);
      popMatrix();
   }
   
   
     beginCamera();
     camera();
     translate(0,0, lerp(0, -25,(float) (intro-30/30) ) );
     if(intro>70){
       rotateZ(lerp(0,PI*1, (float)(intro-70f/10f)));
     }
     endCamera();
   
    
}
void doTheSplitCubesThing(){
    beginCamera();
   camera();
   translate(width/2, height/2, 0);
   //translate(width/2+60*sin(millis()/1000f), height/2, 60*sin(millis()/1000f));
   rotateY(-PI*137/60*millis()/1000f/5);
   //translate(width/2, height/2);
   endCamera();
   
    
   float cubeSize = 50f;
  
   float cubeSeparation = (float)(moonlander.getValue("cubeSeparation"));
  
   pushMatrix();
   translate(cubeSeparation*cubeSize, 0, 0);
   drawCube(cubeSize);
   popMatrix();
   
   pushMatrix();
   translate(-1*cubeSeparation*cubeSize, 0, 0);
   drawCube(cubeSize);
   popMatrix();
   
   perspective();

}

void drawCube(float size) {
    // clear();
    // moonlander.update();
 
    
    rotateY(millis()/1000f);
    
    float beat = 0.0f;
    float rot = 0.0f;
    int cubePhase = moonlander.getIntValue("cubePhase");
    float dampBeat = (float)(moonlander.getValue("dampBeat"));
    
    if (cubePhase >= 1) {
      beat = 40*dampBeat*abs(sin(PI*137/60*millis()/1000f));
    }
    if (cubePhase >= 2) {
      rot = PI*137/60*millis()/1000f;
    }
    if (cubePhase >= 3) {
      rot = 0.0f;
    }
    if (cubePhase >= 4) {
      beat = 0.0f;
    }
    
    //y
    pushMatrix();
    translate(0, -(size+beat), 0);
    rotateY(rot);
    drawPyramid(size);
    popMatrix();
    
    //-y
    pushMatrix();
    translate(0, size+beat, 0);
    rotateZ(PI);
    rotateY(-rot);
    drawPyramid(size);
    popMatrix();
    
    //x
    pushMatrix();
    translate(0, 0, -(size+beat));
    rotateX(PI/2);
    rotateY(rot);
    drawPyramid(size);
    popMatrix();
    
    //-x
    pushMatrix();
    translate(0, 0, size+beat);
    rotateX(-PI/2);
    rotateY(-rot);
    drawPyramid(size);
    popMatrix();
    
    //z
    pushMatrix();
    translate(size+beat, 0, 0);
    rotateX(rot);
    rotateZ(PI/2);
    drawPyramid(size);
    popMatrix();
    
    //-z
    pushMatrix();
    translate(-(size+beat), 0, 0);
    rotateX(-rot);
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
    boolean green=true;
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
            green=false;
          } else if(i!=4&&i2!=4&&i3!=4){
            green=true;
          }
          fill((i==4)?220:(green)?0:255, (green)?255:30, 0);
          vertex( verts[i][0],verts[i][1],verts[i][2]);
          fill((i2==4)?220:(green)?0:255, (green)?255:30, 0);
          vertex( verts[i2][0],verts[i2][1],verts[i2][2]);
          fill((i3==4)?220:(green)?0:255, (green)?255:30, 0);
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

