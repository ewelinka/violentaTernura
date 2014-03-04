class Nothing implements Scene
{   
    String name;
  
    public Nothing(String na)
    {
      name = na;
    }
 
    void closeScene(){};
    void initialScene(){
        background(0);
    };
    void drawScene(){};

    void onPressedKey(String k){};
    String getSceneName(){return this.name;};

}