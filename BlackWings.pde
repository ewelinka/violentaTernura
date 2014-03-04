class BlackWings implements Scene
{   
  String name;

  ParticleManager particles;

  
  public BlackWings(String na)
  {
    name = na;
  }

  void closeScene(){};
  void initialScene(){
    background(0);
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