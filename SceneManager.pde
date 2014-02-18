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
    scenes = new Scene[3];
   // scenes[0] = new SceneRotatingWords();
    //scenes[1] = new SceneCircle();
    //scenes[2] = new SceneNothing();
    scenes[0] = new DrawCircle("d");
    scenes[1] = new NoisyCircle("noisy");
    scenes[2] = new RotatingWords("rota");
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