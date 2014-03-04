class WordCircle implements Scene
{   
  String name;
  String message= "la mente del hombre esta diseñada para sobrevivir";
  PFont f;
  // The radius of a circle
  //float radius = 250;
  float rotation = 0.2;
  float rotationBase = rotation;
  float overlayAlpha = 255;

  int cx, cy;
  float clockRadius = min(width, height) / 2;
  float secondsRadius = clockRadius * 0.72;
  float minutesRadius = clockRadius * 0.60;
  float hoursRadius = clockRadius * 0.50;

  float radius = secondsRadius;

  public WordCircle(String na)
  {
    name = na;

  }

  void closeScene(){};
  void initialScene(){
    f = createFont("Georgia",40,true);
    textFont(f);
    // The text must be centered!
    textAlign(CENTER);
    cx = width/2;
    cy = height/2;
    //smooth();
  };
  void drawScene(){
    fill(255, this.overlayAlpha);
    noStroke();
    ellipse(width/2, height/2, this.clockRadius*1.7,this.clockRadius*1.7);
    // minute-points
    stroke(0);
    fill(0);
    // strokeWeight(4);
    // beginShape(POINTS);
    //   for (int a = 0; a < 360; a+=6) {
    //     float angle = radians(a);
    //     float x = width/2 + cos(angle) * 270;
    //     float y = height/2 + sin(angle) * 270;
    //     vertex(x, y);
    //   }
    // endShape();
     // Angles for sin() and cos() start at 3 o'clock;
    // subtract HALF_PI to make them start at the top
    float s = map(second(), 0, 60, 0, TWO_PI) - HALF_PI;
    float m = map(minute() + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI; 
    float h = map(hour() + norm(minute(), 0, 60), 0, 24, 0, TWO_PI * 2) - HALF_PI;
    
    // Draw the hands of the clock
    strokeWeight(2);
    line(cx, cy, cx + cos(s) * secondsRadius, cy + sin(s) * secondsRadius);
    strokeWeight(4);
    line(cx, cy, cx + cos(m) * minutesRadius, cy + sin(m) * minutesRadius);
    strokeWeight(6);
    line(cx, cy, cx + cos(h) * hoursRadius, cy + sin(h) * hoursRadius);
    // Start in the center and draw the circle
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
    rotation+=rotationBase;
    rotation = rotation % 360;
  };

  void onPressedKey(String k){
    // overlayAlpha between 5 and 255
    if (k == "UP") this.overlayAlpha = min(this.overlayAlpha+5,255);
    if (k == "DOWN") this.overlayAlpha = max(this.overlayAlpha-5, 0);
    // radius between 10 and 100
    if (k == "RIGHT") this.radius += 5;
    if (k == "LEFT") this.radius = max(this.radius-5,10);
  };
  String getSceneName(){return this.name;};

}