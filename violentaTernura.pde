SceneManager manager;

void setup(){
 // size(1024, 768,OPENGL);
  size(displayWidth, displayHeight);
  manager = new SceneManager();  

}

void draw() { 
  manager.actualScene.drawScene();
}

void keyReleased(){
  if (keyCode == UP) manager.pressedKey("UP");
  if (keyCode == DOWN) manager.pressedKey("DOWN");
  if (keyCode == LEFT) manager.pressedKey("LEFT");
  if (keyCode == RIGHT) manager.pressedKey("RIGHT");

  if (key == 'b') manager.pressedKey("b");
  if (key == 'n') manager.pressedKey("n");

  //TODO: if is number i pass it as scene to activate
  if (key == '0') manager.activate(0);
  if (key == '1') manager.activate(1);
  if (key == '2') manager.activate(2);
}
