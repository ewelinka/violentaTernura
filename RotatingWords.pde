class RotatingWords implements Scene
{   
  // will be set in constructor
  String name;
  // additional parameters specific for the scene
  String[] palabras = {"sin poder hacer nada","ahora", "el horror","sin aviso", "sin tiempo de reaccion"};
  float [] angulitos = {0.005,0.007,0.022,0.009,0.011};
  float [] angulitosNuevos = {0,0,0,0,0};
  PFont f;
  float overlayAlpha = 10;
  int radius = 10;

  public RotatingWords(String na)
  {
    name = na;
  }

  // main functions
  void closeScene(){};

  void initialScene(){
    f=loadFont("GFSNeohellenic-Bold-48.vlw");
    textFont(f);
    textAlign(LEFT); 
  };

  void drawScene(){
    // darker or heller
    fill(0, overlayAlpha);
    noStroke();
    rect(0,0,width,height);
    // Translate to the mouse pointes
    translate(mouseX,mouseY);  
       
    for(int i=0;i<palabras.length;i++){
      pushMatrix();
        fill(255);
        rotate(angulitosNuevos[i]);
        text(palabras[i],this.radius,0); 
      popMatrix();
      //TODO add some modulo to avoid big nmbers
      angulitosNuevos[i] += angulitos[i];
    } 
  };

  String getSceneName(){return this.name;};
  void onPressedKey(String k){
    // overlayAlpha between 5 and 255
    if (k == "UP") this.overlayAlpha = min(this.overlayAlpha+5,255);
    if (k == "DOWN") this.overlayAlpha = max(this.overlayAlpha-5, 0);
    // radius between 10 and 100
    if (k == "RIGHT") this.radius = min(this.radius+5,100);
    if (k == "LEFT") this.radius = max(this.radius-5,10);
    
  };
}
