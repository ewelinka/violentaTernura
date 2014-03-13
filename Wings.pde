class Wings implements Scene
{   
  String name;

  ParticleManager particles;

  
  public Wings(String na)
  {
    name = na;
  }

  void closeScene(){};
  void initialScene(){
    hint(ENABLE_OPTIMIZED_STROKE);
    background(0);
    particles = new ParticleManager(); 
  };
  void drawScene(){
    fill(0,0,122);
    ellipse(mouseX, mouseY, 4,4);
    if(mousePressed) particles.add(mouseX, mouseY);   
    particles.update();
    particles.draw();
  };

  void onPressedKey(String k){};
  String getSceneName(){return this.name;};



}