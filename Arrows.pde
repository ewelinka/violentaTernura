class Arrows implements Scene
{   
  String name;

  PShape currentShape;
  int tileCount = 10;
  float tileWidth, tileHeight;
  float shapeSize = 50;
  float shapeAngle = 0;
  float maxDist;

  int fillMode = 0;
  int sizeMode = 0;

  public Arrows(String na)
  {
    name = na;
  }

  void closeScene(){};
  void initialScene(){
    tileWidth = width/float(tileCount);
    tileHeight = height/float(tileCount);
    maxDist = sqrt(sq(width)+sq(height));

    currentShape = loadShape("flecha.svg");
    currentShape.enableStyle();
  };

  void drawScene(){
    background(0);
    fill(255);
    ellipse(width/2,height/2, 600, 600);  

    for (int gridY=0; gridY<tileCount; gridY++) {
      for (int gridX=0; gridX<tileCount; gridX++) {

        float posX = tileWidth*gridX + tileWidth/2;
        float posY = tileHeight*gridY + tileWidth/2;

        // calculate angle between mouse position and actual position of the shape
        float angle = atan2(mouseY-posY, mouseX-posX) + radians(shapeAngle);

        pushMatrix();
        translate(posX, posY);
        rotate (angle);
        shapeMode (CENTER);

        noStroke();
        shape(currentShape, 0,0, shapeSize,shapeSize);
        popMatrix();
      }
    } 

  };

  void onPressedKey(String k){
    if (k == "UP") shapeSize +=5;
    if (k == "DOWN") shapeSize = max(shapeSize-5, 5);
    if (k == "LEFT") shapeAngle -=5;
    if (k == "RIGHT") shapeAngle +=5;

    if (k == "g" || k == "G") {
      tileCount = tileCount+5;
      if (tileCount > 20) {
        tileCount = 10;
      }
      tileWidth = width/float(tileCount);
      tileHeight = height/float(tileCount);
    }
  };

  String getSceneName(){return this.name;};

}