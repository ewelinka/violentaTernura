class Worms implements Scene
{   
  String name;

  ArrayList<Worm> worms;
  boolean isActive = false;
  float overlayAlpha = 255;
  float wormStroke = 255;
  
  public Worms(String na)
  {
    name = na;
  }
 
  void closeScene(){};
  void initialScene(){
    background(255);
    worms = new ArrayList<Worm>();
    while(worms.size()< 200){
      add4worms();
    }
  };
  void drawScene(){
    drawOverlay();
    for (Worm worm: worms) {   
      worm.display();
    }
    if(this.isActive){
      for (Worm worm: worms) {         
        worm.advance();
      }
    }
  };

  void drawOverlay(){
    fill(255, overlayAlpha);
    noStroke();
    //ellipse(width/2,height/2, this.radius+500,this.radius+500);   
    rect(0,0, width, height);
  }

  void startWorms(){
    println("Activate worms!");
    this.isActive = true;
    while(worms.size()< 200){
      add4worms();
    }
  }

  void killWormsAndStop(){
    println("Kill all worms!");
    this.isActive = false;
    worms = new ArrayList<Worm>();
  }

  void onPressedKey(String k){
    // overlayAlpha between 5 and 255
    if (k == "UP") this.overlayAlpha = min(this.overlayAlpha+5,255);
    if (k == "DOWN") this.overlayAlpha = max(this.overlayAlpha-5, 0);
    // radius between 10 and x
    if (k == "RIGHT") this.wormStroke = min(this.wormStroke + 5,255);
    if (k == "LEFT") this.wormStroke = max(this.wormStroke-5,0);

    if (k == "add") add4worms();
    if (k == "start") startWorms();
    if (k == "kill") killWormsAndStop();
    
  };

  String getSceneName(){return this.name;};

  void add4worms(){
    // up
    float xStart = random(0,width);
    float yStart = 0;
    worms.add(new Worm(xStart, yStart-50));
    // down
    xStart = random(0,width);
    yStart = height;
    worms.add(new Worm(xStart, yStart+50));
    //right
    xStart = width;
    yStart = random(0,height);
    worms.add(new Worm(xStart+50, yStart));
    //left
    xStart = 0;
    yStart = random(0,height);
    worms.add(new Worm(xStart-50, yStart));
  }



  class Worm {
    ArrayList<PVector> points;
    float segLen;
    float weight;
    float x;
    float y;
   
    Worm(float posX, float posY) {
      points = new ArrayList<PVector>();
      segLen = random(.5, 5);
      weight = random(5, 10);
      x = posX;
      y = posY;
      points.add(new PVector(x, y));
      x = x + segLen * cos(random(TWO_PI));
      y = y + segLen * sin(random(TWO_PI));
      points.add(new PVector(x, y));
      for (int i = 0; i < 10; i++) {
        addPoint();
      }
    }
   
    void addPoint() {
      PVector p0 = points.get(0);
      PVector p1 = points.get(1);

      float a = atan2(p0.y - p1.y, p0.x - p1.x);
      float x = p0.x + segLen * cos(a + random(-QUARTER_PI, QUARTER_PI));
      float y = p0.y + segLen * sin(a + random(-QUARTER_PI, QUARTER_PI));

     //  if(dist(p0.x, p0.y, mouseX, mouseY) > 250) {
     //    x +=sin(atan2(mouseX-p0.x, mouseY-p0.y))*4-1/5;
     //    y +=cos(atan2(mouseX-p0.x, mouseY-p0.y))*4-1/5;
     // }
      points.add(0, new PVector(x, y));
    }
   
    void display() {
      for (int i = 0; i < 2; i++) {
        strokeWeight(weight - i * 4);
        stroke(i * wormStroke);     
        
        float xStart = points.get(0).x;
        float yStart = points.get(0).y;
        ellipse(xStart,yStart,1,1);
        beginShape();
        for (PVector p : points) {
          vertex(p.x, p.y);
        }
        endShape();
      }
    }
   
    void advance() {
      points.remove(points.size() - 1);
      addPoint();
    }
  }
}


 


