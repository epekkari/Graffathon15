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
   double steps=moonlander.getValue("steps");
   background(demoState*50);
   if(demoState==0){
     doIntroIntro(steps);
    }else if(demoState>0&&demoState<3){
     doIntro(demoState);
     getReadyText(steps);
   } else if (demoState==3){
     doTheSplitCubesThing();
     drawExtraCubes();
   } else if (demoState==4){
     doOutro();
   } else if (demoState==5){
     exit();
   } 
   
//    textSize(32);
    fill(255, 102, 0);
//    text("State: "+demoState+" "+crapToShowInDebug, width-200, 35,0 );
   moonlander.update();
} 
float clamper(float value, float min, float max){
  if(value<min)return min;
  else if(value>max)return max;
  else return value;
}

void getReadyText(double steps){
  if(steps<140)return;
  
  int[] getRow1= { 1,1,1,1,0,1,1,1,1,0,1,1,1,1,1,0,0,0,0,0};
  int[] getRow2= { 1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0};
  int[] getRow3= { 1,0,1,1,0,1,1,1,0,0,0,0,1,0,0,0,0,0,0,0};
  int[] getRow4= { 1,0,0,1,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0};
  int[] getRow5= { 1,1,1,1,0,1,1,1,1,0,0,0,1,0,0,0,0,0,0,0};
  int[][]getRows={getRow5,getRow4,getRow3,getRow2,getRow1};
  int[] rdyRow1= { 1,1,1,1,0,1,1,1,0,0,1,0,0,0,1,0,1,1,0,0};
  int[] rdyRow2= { 1,0,0,1,0,1,0,0,1,0,0,1,0,1,0,0,1,1,0,0};
  int[] rdyRow3= { 1,1,1,0,0,1,0,0,1,0,0,0,1,0,0,0,1,1,0,0};
  int[] rdyRow4= { 1,0,0,1,0,1,0,0,1,0,0,0,1,0,0,0,0,0,0,0};
  int[] rdyRow5= { 1,0,0,1,0,1,1,1,0,0,0,0,1,0,0,0,1,1,0,0};
 
  int[][]rdyRows={rdyRow5,rdyRow4,rdyRow3,rdyRow2,rdyRow1};
  float i=0;
  float i2=0;
  pushMatrix();
  boolean firstTime=false;
  if(steps>150)firstTime=true; //menee väärinpäin, first time tarkottaa ei first time XD
  float scalingValue=1f;
  translate(0,0,100);
  if(millis()/100 % 2 ==1 ) {
    fill(0,0,0);  
  } else {
     fill(255,0,0); 
  }
  
  int addedFrames=0;
  if(firstTime){
    addedFrames=10; 
     translate(0,height*2,0);
   }
  stroke(255,255,0);
  for(i2=0;i2<clamper((float)(steps-(140+addedFrames)) ,0,(float)getRows.length) ;i2++){
    pushMatrix();
    for(i=0;i< getRow1.length;i++){
      boolean doABox=false;
      if(!firstTime){
        if(getRows[(int)i2][(int)i]>0){
          doABox=true;
        }
      } else {
       if(rdyRows[(int)i2][(int)i]>0){
          doABox=true;
        }
      }
      if(doABox){
        box(100*scalingValue,50*scalingValue,50*scalingValue);
      }
      crapToShowInDebug="i2 "+i2;
      translate(100*scalingValue,0,0);
    }
   // noStroke();
    popMatrix();
    translate(0,-100*scalingValue,0);
    //print("i2: "+i2);
  }
  popMatrix();
}
void doIntroIntro(double steps){
  
//  if(steps>20){
    double deltaSteps=steps-20;
    int i=0;
//    stroke(255,255,0);
//    fill(255,255,0);
//    for(i=0; i<(deltaSteps/4);i++){
//      print("joo");
//      bezier(0, height*0.2+height*sin((float) (i+1)* (float)deltaSteps) , 0, //p1
//      width/2, height/2, 0, //ctrl 1
//      width,height*0.2+height*tan( (i+1)* (float)deltaSteps) , 0,  //p2
//      width/2, height/2, 0); //ctrl2
//    } 
//    noStroke();
      fill(255,255,0);
      float rayWidth=40;
      float move=sin(millis()/1000f)*20;
      for(i=0;i <clamper( (float)deltaSteps/2 ,0,(float)width/rayWidth);i++){         
       if(i%4!=1)continue; 
        triangle(width/2, height/2, i*rayWidth+move, 0+move, (i+1)*rayWidth+move, 0+move);
        triangle(width/2, height/2, i*rayWidth+move, height+move, (i+1)*rayWidth+move, height+move);
      }
      for(i=0;i <clamper( (float)deltaSteps/2f ,0,height/rayWidth);i++){    
         if(i%4!=1)continue;      
        triangle(width/2, height/2, 0+move,i*rayWidth+move, 0+move,(i+1)*rayWidth+move);
        triangle(width/2, height/2, width+move,i*rayWidth+move, width+move,(i+1)*rayWidth+move);
      }
     beginCamera();
     camera();
     translate(0,0, 55);
     endCamera();
      
//  }
}
void drawExtraCubes(){
  int i;
  int i2;
  float scalingValue=1000f;
  pushMatrix();
   fill( 255*sin(millis()/1000f), 255*cos(millis()/1000f),255*tan(millis()/1000f) )  ;
//  translate(width,height,0);
  translate(-scalingValue, 0, -scalingValue*2); 
  for(i=0;i<3;i++){  
       pushMatrix();
    for(i2=0;i2<3;i2++){
      translate(0,0,scalingValue);
        
//      if(i==0){
//       
//      } else if(i==1) {
//        fill( 255*cos((millis()+i2*10)/1000f),255*sin((millis()+i*10)/1000f),255*tan(millis()/1000f) );  
//      } else{
//        fill(255*tan(millis()/1000f)  ,255*cos((millis()+i2*10)/1000f),255*sin((millis()+i*10)/1000f));  
//      }
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
  pushMatrix();
  translate(0, 0, scalingValue);
  box(scalingValue);
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

void doOutro() {
  background(220,220,0);
  beginCamera();
  camera();
  rotateY(0.15*sin(millis()/1000f));
  translate(-width, -height, 250*abs(sin(millis()/1000f))-800);
  endCamera();
  
  int moveIdx = moonlander.getIntValue("moveIdx");
  
  int size = 30;
  PShape s = setupPyramid(size);
  int n = width/size;
  boolean move = true;
  for(int i=0;i<n;i++){
    if (i == moveIdx) {
        move = false;
     }
    for(int j=0;j<n;j++) {
     pushMatrix();
     translate(5*i*size,5*j*size,random(-size, size));
     drawCube(size, s, move);
     popMatrix();
    }
  }
  
  String s1;
  //print(moveIdx);
  //print("\n");
  if (moveIdx < 6) {s1="TEAM MEGAFORCE";} 
  else if (moveIdx < 7) {s1="    AM MEGAFORCE";}
  else if (moveIdx < 8) {s1="        MEGAFORCE";}
  else if (moveIdx < 9) {s1="              FORCE";}
  else {s1="";}
  
  textSize(height/5);
  fill(0, 0, 0);
  text(s1, width ,height*2-size ,-2*size);
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
  
   PShape s = setupPyramid(cubeSize);
  
   pushMatrix();
   translate(cubeSeparation*cubeSize, 0, 0);
   drawCube(cubeSize, s, true);
   popMatrix();
   
   pushMatrix();
   translate(-1*cubeSeparation*cubeSize, 0, 0);
   drawCube(cubeSize, s, true);
   popMatrix();
   
   perspective();

}

void drawCube(float size, PShape s, boolean move) {
    // clear();
    // moonlander.update();
    
    float beat = 0.0f;
    float rot = 0.0f;
    int cubePhase = moonlander.getIntValue("cubePhase");
    float dampBeat = (float)(moonlander.getValue("dampBeat"));
    
    if (move) {
      rotateY(millis()/1000f);
      if (cubePhase >= 1) {
        beat = 25*dampBeat*abs(sin(PI*137/60*millis()/1000f));
      }
      if (cubePhase >= 2) {
        rot = PI*137/60*millis()/1000f;
      }
      if (cubePhase >= 3) {
        rot = 0.0f;
      }
      if (cubePhase >= 4) {
        rot = 0.0f;//PI*137/60*millis()/1000f;
      }
      if (cubePhase >= 5) {
       beat = 10*abs(sin(2*PI*137/60*millis()/1000f));
        rot = PI*137/60*millis()/1000f;
      }
    }
    //y
    pushMatrix();
    translate(0, -(size+beat), 0);
    if (cubePhase < 5) {
       rotateY(rot);
    } else {
       rotateZ(rot);
    }
    drawPyramid(s);
    popMatrix();
    
    //-y
    pushMatrix();
    translate(0, size+beat, 0);
    rotateZ(PI);
    if (cubePhase < 5) {
       rotateY(-rot);
    } else {
       rotateZ(-rot);
    }
    //drawPyramid(size);
    drawPyramid(s);
    popMatrix();
    
    //x
    pushMatrix();
    translate(0, 0, -(size+beat));
    rotateX(PI/2);
    if (cubePhase < 5) {
       rotateY(rot);
    } else {
       rotateZ(rot);
    }
    //drawPyramid(size);
    drawPyramid(s);
    popMatrix();
    
    //-x
    pushMatrix();
    translate(0, 0, size+beat);
    rotateX(-PI/2);
    if (cubePhase < 5) {
       rotateY(-rot);
    } else {
       rotateZ(-rot);
    }
    //drawPyramid(size);
    drawPyramid(s);
    popMatrix();
    
    //z
    pushMatrix();
    translate(size+beat, 0, 0);
    rotateZ(PI/2);
    if (cubePhase < 5) {
       rotateY(rot);
    } else {
       rotateZ(rot);
    }
    //drawPyramid(size);
    drawPyramid(s);
    popMatrix();
    
    //-z
    pushMatrix();
    translate(-(size+beat), 0, 0);
    rotateZ(-PI/2);
    if (cubePhase < 5) {
       rotateY(-rot);
    } else {
       rotateZ(-rot);
    }
    //drawPyramid(size);
    drawPyramid(s);
    popMatrix();
     
}

PShape setupPyramid(float size) {
    //PImage img = loadImage("boxtexture.jpg");
    noStroke();
    float[] v1={1*size,0,1*size};
    float[] v2={-1*size,0,1*size};
    float[] v3={-1*size,0,-1*size};
    float[] v4={1*size,0,-1*size};
    float[] v5={0,1*size,0};
    float[][] verts={v1,v2,v3,v4,v5};
    //fill(255);
    PShape s = createShape();
    lights();
    pointLight(251, 102, 126, 0, 0, 0);
    pointLight(251, 102, 126, height, width, height);
    //s.beginShape(TRIANGLES);
    int i;
    int i2;
    int i3;
    boolean green=true;
    int greenQuads=0;
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
          if (green) {
            if(greenQuads<1){
               continue; 
            }
            greenQuads++;
            s.beginShape(TRIANGLES);
            //s.texture(img);
            //s.fill((i==4)?220:0, 255, 0);
            s.vertex( verts[i][0],verts[i][1],verts[i][2], 512, 0);
            //s.fill((i2==4)?220:0, 255, 0);
            s.vertex( verts[i2][0],verts[i2][1],verts[i2][2], 0, 512);
            //s.fill((i3==4)?220:0, 255, 0);
            s.vertex( verts[i3][0],verts[i3][1],verts[i3][2], 0, 0);
            s.endShape();
          } else {
            s.beginShape(TRIANGLES);
            int edgeColor=0;
            int centerColor=0;
            if(i==4)centerColor=255; 
            else edgeColor=220;
            s.fill(centerColor+edgeColor, edgeColor, 0);
            s.vertex( verts[i][0],verts[i][1],verts[i][2]);
            if(i2==4)centerColor=255; 
            else edgeColor=220;
            s.fill(centerColor+edgeColor, edgeColor, 0);
            s.vertex( verts[i2][0],verts[i2][1],verts[i2][2]);
            if(i3==4)centerColor=255; 
            else edgeColor=220;
            s.fill(centerColor+edgeColor, edgeColor, 0);
            s.vertex( verts[i3][0],verts[i3][1],verts[i3][2]);
            s.endShape();
          }
         
        }
      }
    }
    
    s.beginShape(QUADS);
    //s.texture(img);
    //s.stroke(153);
    fill(255,0,0);
    s.vertex(verts[0][0],verts[0][1],verts[0][2], 512, 0);
    s.vertex(verts[2][0],verts[2][1],verts[2][2], 0, 512);
    s.vertex(verts[3][0],verts[3][1],verts[3][2], 512, 512);
    s.vertex(verts[1][0],verts[1][1],verts[1][2], 0, 0);
    s.endShape();
    
    //s.endShape();
    return s;
}

void drawPyramid(PShape s) {
    shape(s, 0, 0);
    
//    Size(32);
//    fill(255, 102, 0);
//    text("V1",v1[0], v1[1],v1[2]); 
//    text("V2",v2[0], v2[1],v2[2]); 
//    text("V3",v3[0], v3[1],v3[2]); 
//    text("V4",v4[0], v4[1],v4[2]); 
//    camera((70f-140f*sin(millis()/1000f)*20f)/3 ,35 , 120.0, 0,0, 0, 
//    0.0, 1.0, 0.0);
}

