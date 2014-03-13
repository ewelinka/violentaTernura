class RotatingWords implements Scene
{   
  // will be set in constructor
  String name;
  // additional parameters specific for the scene
  String[] palabras = {"sin poder","ahora", "el horror","sin aviso", "sin tiempo"};
 // float [] angulitos = {0.005,0.007,0.022,0.009,0.011};
  float [] angulitos = {0.125,0.075,0.3,0.225,0.025};
  float [] angulitosNuevos = {0,0,0,0,0};
  PFont f;
  float overlayAlpha = 255;
  int radius = 20;

  public RotatingWords(String na)
  {
    name = na;
  }

  // main functions
  void closeScene(){};

  void initialScene(){
    f=loadFont("CharterBT-BoldItalic-48.vlw");
    textFont(f);
    textAlign(LEFT); 
    background(0);
    fill(255);
    //ellipse(width/2,height/2, this.radius+500,this.radius+500);  

  };

  void drawScene(){
    //background(0);
    // darker or heller
    fill(255, this.overlayAlpha);
    noStroke();
    //ellipse(width/2,height/2, this.radius+500,this.radius+500);   
    ellipse(width/2,height/2, 600, 600);   

    stroke(0);
    fill(0);
    strokeWeight(4);
    beginShape(POINTS);
    for (int a = 0; a < 360; a+=6) {
      float angle = radians(a);
      float x = width/2 + cos(angle) * 270;
      float y = height/2 + sin(angle) * 270;
      vertex(x, y);
    }
    endShape();
    //fill(255);
    //ellipse(mouseX,mouseY,this.radius+500,this.radius+500);   

    for(int i=0;i<palabras.length;i++){
      pushMatrix();
        translate(width/2,height/2); 
        rotate(radians(angulitosNuevos[i]));
        text(palabras[i],this.radius,0); 
      popMatrix();
      //TODO add some modulo to avoid big nmbers
      angulitosNuevos[i] += angulitos[i];
      angulitosNuevos[i] = angulitosNuevos[i] % 360;
    } 
  };

  String getSceneName(){return this.name;};
  void onPressedKey(String k){
    // overlayAlpha between 5 and 255
    if (k == "UP") this.overlayAlpha = min(this.overlayAlpha+5,255);
    if (k == "DOWN") this.overlayAlpha = max(this.overlayAlpha-5, 0);
    // radius between 10 and x
    if (k == "RIGHT") this.radius += 5;
    if (k == "LEFT") this.radius = max(this.radius-5,20);
    
  };
}
