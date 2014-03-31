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
    scenes[1] = new Wings("Wings"); 
    //scenes[0].initialScene();
    scenes[2] = new Worms("Worms"); 
    //scenes[1].initialScene();
    scenes[3] = new RotatingWords("rota"); 
    //scenes[2].initialSceRotatingWords("rota"); ne();
    scenes[4] = new Repeller("repi"); 
    //scenes[3].initialScene();
    scenes[5] = new NoisyCircle("noisy");
   // scenes[4].initialScene();
    scenes[6] = new WordCircle("WordCircle");
    //scenes[5].initialScene();  
    scenes[7] = new Spotlight("spotlight");
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
    println(sceneNr+" "+actualScene.getSceneName());
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