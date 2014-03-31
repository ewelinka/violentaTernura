class Spotlight implements Scene
{   
  String name;
  PImage img;
  float radius = 300;
  int threshold = 30;
  boolean isPulseActive;
  float pulsesize = 7;

  public Spotlight(String na)
  {
    name = na;
    img = createImage(width,height,ARGB);
  }

  void closeScene(){};
  void initialScene(){
    isPulseActive = true;
  };
  void drawScene(){
    background(0);
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++ ) {
        // Calculate the 1D location from a 2D grid
        int loc = x + y*width;

        // Calculate an amount to change brightness based on proximity to the mouse
        float maxdist = radius;
        if(isPulseActive) maxdist = radius + pulsesize;
        float d = dist(x, y, mouseX, mouseY);
        if(d<maxdist){
          float adjustalpha = 255*(maxdist-d)/maxdist;
          // to introduce some noise to spotlight

          if(random(50)>this.threshold){
            img.pixels[loc] = color(255,0,0,adjustalpha);
          }else{
            img.pixels[loc] = color(255,0,0,max(adjustalpha-44,0));
          }
        }else{
          img.pixels[loc] = color(0);
        }
        
      }
    }
    img.updatePixels();
    image(img,0,0);  
    pulsesize*=-1;
  };

  void startPulse(){
    isPulseActive= !isPulseActive;
  }  
  void addPulse(){
    if(pulsesize<0) pulsesize-=1 ;
    else pulsesize=pulsesize+=1 ;
    println("pulsesize " + pulsesize);
  }  
  void killPulse(){
    if(pulsesize<0) pulsesize+=1 ;
    else pulsesize=pulsesize-=1 ;
    println("pulsesize " + pulsesize);
  }

  void onPressedKey(String k){

    if (k == "UP") {this.threshold = min(this.threshold+1,30); println("T: "+this.threshold);}
    if (k == "DOWN") {this.threshold = max(0,this.threshold-=1); println("T: "+this.threshold);}
    // radius between 10 and 100
    if (k == "RIGHT") this.radius += 10;
    if (k == "LEFT") this.radius = max(10,this.radius-=10);

    if (k == "start") startPulse();
    if (k == "add") addPulse();
    if (k == "kill") killPulse();
 
  };    

  String getSceneName(){return this.name;};

}