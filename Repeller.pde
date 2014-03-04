class Repeller implements Scene
{   
    String name;
    FCircle repeller;
    
    int w,h;
  
    public Repeller(String na)
    {
      name = na;
      
    }
 
    void closeScene(){};
    //TODO hacerlo solo una vez
    void initialScene(){
      world = new FWorld();
      world.setGravity(0, 0);
      world.setEdges();
      // load pictures from folders normal and over
      java.io.File folder = new java.io.File(dataPath("normal"));
      String[] filenames = folder.list();
      int noi = filenames.length;

      String current;
      for(int m=0;m<4;m++){
        for (int i = 0; i < noi; i++) {
          current = filenames[i];
          PImage imagen = loadImage("normal/"+current);
          FBox b = new FBox(imagen.width, imagen.height);
          float rx = random(width-imagen.width);
          float ry = random(height-imagen.height);
          println("rx: "+rx+" ry: "+ry);
          b.setPosition(rx, ry);
          b.attachImage(imagen);
          world.add(b);
        }
      }

      repeller = new FCircle(50);
      repeller.setPosition(width/2, height/2);
      repeller.setNoFill();
      //repeller.setNoStroke();
      stroke(10);
      world.add(repeller); 
      world.step();


    };
    void drawScene(){
      background(0);
      repeller.setPosition(mouseX,mouseY);
      ArrayList inContact = repeller.getTouching();
      //inContact
      for ( int i =0 ; i < inContact.size(); i++ ) {
         
        FBody inCo = (FBody) inContact.get(i);
        inCo.addForce((inCo.getX()-repeller.getX())*1000,(inCo.getY()-repeller.getY())*1000);
         
      }

      world.step();
      world.draw();
    };

    void onPressedKey(String k){};
    String getSceneName(){return this.name;};

}