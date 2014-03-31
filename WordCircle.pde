class WordCircle implements Scene
{   
  String name;
  String message2= "La mente del hombre esta diseñada para sobrevivir";
  String message= "A cada pensamiento lo acompaña el universo";
  PFont f;
  // The radius of a circle
  //float radius = 250;
  float rotation = 0.2;
  float rotationBase = rotation;
  float overlayAlpha = 255;

  int cx, cy;
  float clockRadius = min(width, height) / 2;
  float radius = clockRadius * 0.66;
  float smallerRadius = this.radius - 25;

  public WordCircle(String na)
  {
    name = na;

  }

  void closeScene(){};
  void initialScene(){
    f=loadFont("CharterBT-BoldItalic-48.vlw");
    textFont(f);
    // The text must be centered!
    textAlign(CENTER);
    cx = width/2;
    cy = height/2;
    radius = radius + 80;
    //smooth();
  };
  void drawScene(){
    fill(255, this.overlayAlpha);
    noStroke();
    ellipse(width/2, height/2, this.clockRadius*1.7,this.clockRadius*1.7);
    // minute-points
    stroke(0);
    fill(0);

    // Start in the center and draw the first circle
    pushMatrix();
    translate(width/2, height/2);
    //to make words rotate
    rotate(radians(rotation));
    noFill();

    // For every box
    float arclength = 0;
    for (int i = 0; i < message.length(); i++)
    {
      // Instead of a constant width, we check the width of each character.
      //textSize(random(22,36));
      char currentChar = message.charAt(i);
      float w = textWidth(currentChar);
      // Each box is centered so we move half the width
      arclength += w/2;
      // Angle in radians is the arclength divided by the radius
      // Starting on the left side of the circle by adding PI
      float theta = PI + arclength / this.radius;    
      pushMatrix();
        // Polar to cartesian coordinate conversion
        translate(this.radius*cos(theta), this.radius*sin(theta));
        // Rotate the box
        rotate(theta+PI/2); // rotation is offset by 90 degrees
        // Display the character
        fill(0);
        text(currentChar,0,0);
      popMatrix();
      // Move halfway again
      arclength += w/2;
    }
    popMatrix();

    // Start in the center and draw the second circle
    pushMatrix();
    translate(width/2, height/2);
    //to make words rotate
    rotate(radians(360-rotation));
    noFill();

    // For every box
    arclength = 0;
    for (int i = 0; i < message2.length(); i++)
    {
      // Instead of a constant width, we check the width of each character.
      //textSize(random(22,36));
      char currentChar = message2.charAt(i);
      float w = textWidth(currentChar);
      // Each box is centered so we move half the width
      arclength += w/2;
      // Angle in radians is the arclength divided by the radius
      // Starting on the left side of the circle by adding PI
      float theta = PI + arclength / this.smallerRadius;    
      pushMatrix();
        // Polar to cartesian coordinate conversion
        translate(this.smallerRadius*cos(theta), this.smallerRadius*sin(theta));
        // Rotate the box
        rotate(theta+PI/2); // rotation is offset by 90 degrees
        // Display the character
        fill(0);
        text(currentChar,0,0);
      popMatrix();
      // Move halfway again
      arclength += w/2;
    }
    popMatrix();

    rotation+=rotationBase;
    rotation = rotation % 360;
  };

  void onPressedKey(String k){
    // overlayAlpha between 5 and 255
    if (k == "UP") this.overlayAlpha = min(this.overlayAlpha+5,255);
    if (k == "DOWN") this.overlayAlpha = max(this.overlayAlpha-5, 0);
    // radius between 10 and 100
    if (k == "RIGHT") {
      this.radius += 0.5;
      println("radius "+this.radius);
    }
    if (k == "LEFT"){
      this.radius = max(this.radius-0.5,10);
      println("radius "+this.radius);
    } 
  };
  String getSceneName(){return this.name;};

}