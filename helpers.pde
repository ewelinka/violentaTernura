class ParticleManager{
  final int 
    MAX_AGE = 100,
    STEPS = 900,
    DIST = 40,
    SQD = DIST*DIST;
  final float 
    SMOOTHNESS = .005;

  ArrayList<Particle> particles;  
  HashGrid hg;
  PVector[] DIRECTIONS;
  int[][] INDICES;
  
  ParticleManager(){
    particles = new ArrayList<Particle>();
    hg = new HashGrid(DIST, width, height); 
      
    //LUT to store the indices associated with the vector field
    INDICES = new int[width][height];
    for (int y = 0; y < height; y++) for (int x = 0; x < width; x++) INDICES[x][y] = int(noise(x*SMOOTHNESS, y*SMOOTHNESS)*STEPS); 

    //LUT to store the directions associated with the vector field
    DIRECTIONS = new PVector[STEPS];
    for (int i = 0; i < STEPS; i++) DIRECTIONS[i] = new PVector(cos(i*.5)*.1, sin(i*.5)*.1);  
  }
  
  class Particle implements Locable
  {   
    PVector 
      pos, 
      vel;
    int 
      age;
    
    public Particle(int x, int y)
    {
      pos = new PVector(x,y);
      vel = new PVector();
      age = MAX_AGE;
    }
   
    PVector getLocation()
      { return pos; } 
     
    boolean isDead() 
      { return (age == 0 || pos.x <= 0 || pos.x >= width || pos.y <= 0 || pos.y >= height); } 
    
    void update() 
    { 
      age--;
      if(!(isDead())) vel.add(DIRECTIONS[INDICES[floor(pos.x)][floor(pos.y)]]);
      pos.add(vel);
    }
    
    int sqDistTo(Locable other) {  
      PVector o = other.getLocation();
      return int((pos.x - o.x)*(pos.x - o.x)+(pos.y - o.y)*(pos.y - o.y)); 
    }  
  }  
  
  void add(int x, int y){
    particles.add(new Particle(x, y));  
  }  
  
  void update(){
    for(int i = 0; i < particles.size(); i++) {
      Particle p = particles.get(i);
      p.update();
      if (p.isDead()) particles.remove(i);      
    }
    hg.update((Iterable)particles);
  }

  void draw(){
    for (Particle p: particles) 
      for (Locable other: hg.nearElements(p)) {
        int d = p.sqDistTo(other);
        if (d<=SQD) {          
          PVector o = other.getLocation();
          int a = int(map(d,0,SQD,25,0));
          beginShape(LINES);          
          stroke(255,255,255);
          vertex(p.pos.x, p.pos.y);
          stroke(0,0,255);
          vertex(o.x, o.y);
          endShape();
        }
      }
  }   
}

class HashGrid 
{
  //The map itself
  ArrayList <Locable> [] buckets;
  //Bucket and map parameters:
  // · bW and bH define the bucket dimensions,
  // · rowB and colB are the number of buckets per row and column
  int bW, bH, rowB, colB;
   
  HashGrid (float distanceToCheck, int w, int h)
  {
    //Calculate dimensions of buckets and map
    int d = int(distanceToCheck)-1;
    for (int i = d; i < w; i++) 
      if (w % i ==0) {
        bW = i; 
        break;
      }
    for (int i = d; i < h; i++) 
      if (h % i ==0) {
        bH = i; 
        break;
      }
    rowB = w/bW;
    colB = h/bH;
    
    //Instantiate the map and buckets inside
    buckets = new ArrayList [rowB * colB] ;
    clear();
  }

  //clear all the buckets of their current information
  void clear() {                  
    for (int i = 0; i < buckets.length; buckets[i++] = new ArrayList());
  }
   
  //Methods to know the bucket that contains a given location
  int getCol(PVector location) { 
    return (int)(location.x/bW); 
  }      
  
  int getRow(PVector location) { 
    return (int)(location.y/bH); 
  }
  
  int getInd(PVector location) {
    return getCol(location) + getRow(location)*rowB;
  }
   
  //To put a given element inside of its correspondent bucket
  void update (Locable element) {            
     if(element != null) buckets[getInd(element.getLocation())].add(element);  
  }
   
  void update(Iterable<Locable> locations) 
  {
     clear();
     for (Locable element : locations) 
       update(element); 
  } 
   
  //Retrieve the nearest neighbours of a given element
  ArrayList<Locable> nearElements(Locable element) 
  {   
    ArrayList
      nearest = new ArrayList ();    //the container to be returned
    PVector
      l = element.getLocation();     //element's location  
    int               
      t,                 //a variable to hold temporary values
      c  = getCol (l),        
      r  = getRow (l),               // Bucket 'b' and its neighbours 'n':
      iC = (t=c-1)>0 ? t : 0 ,           //
      iR = (t=r-1)>0 ? t : 0 ,           //  n(iC,iR)  ·  n(eC,iR)
      eC = (t=c+1)<rowB ? t : rowB-1 ,       //    ·  b(c,r)   ·         
      eR = (t=r+1)<colB ? t : colB-1 ;       //  n(iC,eR)  ·  n(eC,eR)  
     
    //Retrieve nearest buckets 
    for (r=iR, t=r*rowB; r<=eR; r++, t+=rowB) for (c=iC; c<=eC; c++) nearest.addAll (buckets[t+c]);
      
    return nearest;
  }
  
  //Displays the grid defined by the buckets
  void displayGrid (int col) {
    stroke (col);
    for (int r=0, y=0; r<=colB; r++, y+=bH) line (0, y, width, y);
    for (int c=0, x=0; c<=rowB; c++, x+=bH) line (x, 0, x, height);
  }
  
}

/**
  Locable
*/
 
interface Locable
{ 
  PVector getLocation();
}