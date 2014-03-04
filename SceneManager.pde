/**
  Scene
*/
 
interface Scene
{ 
    void initialScene();
    void drawScene();
    void closeScene();
    String getSceneName();
    void onPressedKey(String k);
}


class SceneManager{

  Scene[] scenes;  
  Scene actualScene;
  
  SceneManager(){
    scenes = new Scene[10];
    scenes[0] = new Nothing("nothing");
    scenes[0].initialScene();
    scenes[1] = new NoisyCircle("noisy");
    //scenes[0].initialScene();
    scenes[2] = new RotatingWords("rota");
    //scenes[1].initialScene();
    scenes[3] = new Spotlight("spotlight");
    //scenes[2].initialScene();
    scenes[4] = new WordCircle("WordCircle");
    //scenes[3].initialScene();
    scenes[5] = new Repeller("repi");
   // scenes[4].initialScene();
    scenes[6] = new BlackWings("BlackWings");
    //scenes[5].initialScene();    
    actualScene = scenes[0];

  }

  void setBlack(){
  	background(0);
  }

  void activate(int sceneNr){
  	actualScene.closeScene();
  	setBlack();
  	actualScene = scenes[sceneNr];
  	actualScene.initialScene();
  }

  void pressedKey(String pKey){
    actualScene.onPressedKey(pKey);
  }
}

class Example implements Scene
{   
    String name;
  
    public Example(String na)
    {
      name = na;
    }
 
    void closeScene(){};
    void initialScene(){};
    void drawScene(){};

    void onPressedKey(String k){};
    String getSceneName(){return this.name;};

}