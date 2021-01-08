import java.awt.Robot;
Robot rbt;

ArrayList<PImage>gif;
int n = 0;

//keyboard
boolean wkey, skey, akey, dkey;

//camerta variables
float eyex, eyey, eyez, focusx, focusy, focusz, upx, upy, upz;

//rotation variables
float leftRightAngle, upDownAngle;

void setup(){
  noCursor();
  try{
    rbt = new Robot();
  }
  catch(Exception e) {
    e.printStackTrace();
  }
  
  leftRightAngle = 0;
  upDownAngle = 0;
  
  size(displayWidth, displayHeight, P3D);
  
  eyex = width/2;
  eyey = height/2;
  eyez = height/2;
  
  focusx = eyex;
  focusy = eyey;
  focusz = eyez - 100;
  
  upx = 0;
  upy = 1;
  upz = 0;
  
  gif = new ArrayList<PImage>();
  int i = 0;
  while (i < 15){
    String zero = "";
    if(i < 10) zero = "0";
    gif.add (loadImage("frame_" + zero + i + "_delay-0.03s.png"));
    i++;
  }
}

void draw(){
  background(0);
  camera(eyex, eyey, eyez, focusx, focusy, focusz, upx, upy, upz);
  
  move();
  drawAxis();
  drawFloor(-2000, 2000, height, 100);
  drawFloor(-2000, 2000, 0, 100);
  drawInterface();
  gif();
}

void drawInterface(){
  pushMatrix();
  stroke(255, 0, 0);
  strokeWeight(5);
  line(width/2-15, height/2, width/2+15, height/2);
  line(width/2, height/2-15, width/2, height/2+15);
  popMatrix();
}

void move(){ 
  if (akey) {
    eyex += cos(leftRightAngle - PI/2)*10;
    eyez += sin(leftRightAngle - PI/2)*10;
  }
  if (dkey) {
    eyex += cos(leftRightAngle + PI/2)*10;
    eyez += sin(leftRightAngle + PI/2)*10;
  }
  if (wkey) {
    eyex += cos(leftRightAngle)*10;
    eyez += sin(leftRightAngle)*10;
  }
  if (skey) {
    eyex -= cos(leftRightAngle)*10;
    eyez -= sin(leftRightAngle)*10;
  }
  
  focusx = eyex + cos(leftRightAngle)*300;
  focusy = eyey + tan(upDownAngle)*300;
  focusz = eyez + sin(leftRightAngle)*300;
  
  leftRightAngle = leftRightAngle + (mouseX - pmouseX)*0.01;
  upDownAngle = upDownAngle + (mouseY - pmouseY)*0.01;
  
  if (upDownAngle > PI/2.5) upDownAngle = PI/2.5;
  if (upDownAngle < -PI/2.5) upDownAngle = -PI/2.5;
  
  if (mouseX > width-2) rbt.mouseMove(3, mouseY);
  if (mouseX < 2) rbt.mouseMove (width-3, mouseY);
}

void drawAxis(){
  stroke(255, 0, 0);
  strokeWeight(3);
  line(0,0,0, 1000,0,0); //x axis
  line(0,0,0, 0,1000,0); //y axis
  line(0,0,0, 0,0,1000); //z axis
}

void drawFloor(int floorStart, int floorEnd, int floorHeight, int floorSpacing){
  stroke(255);
  strokeWeight(1);
  int x = floorStart;
  int z = floorStart;
  while(x < floorEnd){
    line(x,floorHeight,floorStart, x,floorHeight,floorEnd);
    line(floorStart,floorHeight,z, floorEnd,floorHeight,z);
    x = x + floorSpacing;
    z = z + floorSpacing;
  }
}

void gif(){
  PImage frame = gif.get(n);
  image(frame, 0, 0, width, height);
    n++;
  if(n > 14){
    n = 0;
  }
}
