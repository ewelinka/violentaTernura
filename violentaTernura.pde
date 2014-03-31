import fisica.*;

SceneManager manager;
float globalAlpha;
FWorld world;

void setup(){
 // size(1024, 768,OPENGL);
  size(displayWidth, displayHeight, P3D);
 // size(800, 600 , P3D);


  manager = new SceneManager();  
  globalAlpha = 250;
  noCursor();
  Fisica.init(this);


}

void draw() { 
  manager.actualScene.drawScene();
  drawGlobalAlpha();
}

void keyReleased(){
  if (keyCode == UP) manager.pressedKey("UP");
  if (keyCode == DOWN) manager.pressedKey("DOWN");
  if (keyCode == LEFT) manager.pressedKey("LEFT");
  if (keyCode == RIGHT) manager.pressedKey("RIGHT");

  if (key == 'm'){
    globalAlpha = max(globalAlpha-5, 0);
    println("globalAlpha "+globalAlpha);
  }
  if (key == 'n') {
    globalAlpha = min(globalAlpha+5,255);
    println("globalAlpha "+globalAlpha);
  }

  if (key == 'a') manager.pressedKey("add");  
  if (key == 's') manager.pressedKey("start"); 
  if (key == 'k') manager.pressedKey("kill");
  if (key == 'b') globalAlpha = 255;
  if (key == 'l') globalAlpha = 0;

  //TODO: if is number i pass it as scene to activate
  if (key == '0') manager.activate(0);
  if (key == '1') manager.activate(1);
  if (key == '2') manager.activate(2);
  if (key == '3') manager.activate(3);  
  if (key == '4') manager.activate(4);
  if (key == '5') manager.activate(5);
  if (key == '6') manager.activate(6);
  if (key == '7') manager.activate(7);
}

void drawGlobalAlpha(){
  fill(0, globalAlpha);
  noStroke();
  rect(0,0,width,height);
}
boolean sketchFullScreen() {
  return true;
}