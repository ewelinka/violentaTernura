class Wings implements Scene
{   
  String name;
  boolean isActive;
  ParticleManager particles;

  
  public Wings(String na)
  {
    name = na;
  }

  void closeScene(){};
  void initialScene(){
    hint(ENABLE_OPTIMIZED_STROKE);
    background(0);
    this.isActive = false;
    particles = new ParticleManager(); 
  };
  void drawScene(){
    //fill(0,0,122);
    //ellipse(mouseX, mouseY, 4,4);
    //if(mousePressed) particles.add(mouseX, mouseY); 
    if(this.isActive){  
      particles.add(mouseX, mouseY);   
      particles.update();
      particles.draw();
    }
  };

  void activateWings(){
    this.isActive = true;
  }  

  void killWings(){
    this.isActive = false;
  }

  void onPressedKey(String k){
    if (k == "start") activateWings();
    if (k == "kill") killWings();
  };
  String getSceneName(){return this.name;};

}