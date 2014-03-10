class BlackWings implements Scene
{   
  String name;

  ParticleManager particles;

  
  public Wings(String na)
  {
    name = na;
  }

  void closeScene(){};
  void initialScene(){
    background(0);
    fill(0,0,255);
    noStroke();
    ellipse(width/2,height/2, 300, 300);
    particles = new ParticleManager(); 
  };
  void drawScene(){
    if(mousePressed) particles.add(mouseX, mouseY);   
    particles.update();
    particles.draw();
  };

  void onPressedKey(String k){};
  String getSceneName(){return this.name;};



}