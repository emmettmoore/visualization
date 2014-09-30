int LINECHART = 0;
int PIECHART = 1;
int BARCHART = 2;
class animInterface{
  ArrayList animOrder;
  Circle[] buttons;
  String[] ButtonNames = {"Line Graph", "Pie Chart", "Bar Chart"};
  Rectangle buttonArea;
  Rectangle goButtonArea;

  animInterface(){
      animOrder = new ArrayList(3);
      buttonArea = new Rectangle(0, height * 7/8f, width*.75f, height*1/8f, color(0,250,0));
      goButtonArea = new Rectangle(.75*width,7/8f*height,width*.25,height*1/8f, color(250,12,30));
      buttons = new Circle[ButtonNames.length];
      initializeButtons();
      update();

  }
    
  void update(){
    buttonArea.update(0, height * 7/8f, width*.75f, height*1/8f, color(0,250,0));
    goButtonArea.update(.75*width,7/8f*height,width*.25,height*1/8f, color(250,12,30));
    for(int i = 0; i<buttons.length;i++){
      buttons[i].Display();
    }
  }

  void checkButtons(){
      for (int i = 0; i<buttons.length; i++){
         if(buttons[i].within()){
            if(!buttons[i].clicked){
              print(buttons[i].graphNum + "\n");
               animOrder.add(buttons[i].graphNum);
               buttons[i].clicked = true;
            }
            else{
                int index = animOrder.indexOf(buttons[i].graphNum);
                animOrder.remove(index);
                buttons[i].clicked = false;
            }
         } 
      }
  }
      
  
  void initializeButtons(){
     float interval = buttonArea.w/buttons.length;
     float radius = height/8/2f;
     for(int i = 0; i<buttons.length;i++){
         buttons[i] = new Circle(i*interval+interval/2,buttonArea.posy + radius,radius,color(250,250, 100),ButtonNames[i],i);
     }
  }
  
}

