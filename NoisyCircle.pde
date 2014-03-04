class NoisyCircle implements Scene
{   
  // will be set in constructor
  String name;
  // additional parameters specific for the scene
  float radius = 300; 
  float noiseVal = 0;
  float x,y,lastX,lastY;

  public NoisyCircle(String na)
  {
    name = na;
  }

  // main functions
  void closeScene(){};

  void initialScene(){
    background(0);
    strokeWeight(2);
    hint(DISABLE_OPTIMIZED_STROKE);
  };

  void drawScene(){
    background(0);
    stroke(255,122);
    pushMatrix();
      translate(mouseX,mouseY);

      for (int i=0;i<360 ;i++ ) {
      //for (float i=0.01;i<6.3 ;i=i+0.01 ) {
        x = (this.radius +random(this.noiseVal*-1,this.noiseVal))* cos(i);
        y = (this.radius +random(this.noiseVal*-1,this.noiseVal)) * sin(i);
   

        line(this.lastX, this.lastY, this.x, this.y);   
        this.lastX = this.x;
        this.lastY = this.y;
        
      }
    popMatrix();
  };

  String getSceneName(){return this.name;};
  void onPressedKey(String k){
    if (k == "UP") this.noiseVal += 1;
    if (k == "DOWN") this.noiseVal = max(0,this.noiseVal-=1);
    // radius minimum is 10
    if (k == "RIGHT") this.radius += 5;
    if (k == "LEFT") this.radius = max(10,this.radius-=5);
    
  };
}
