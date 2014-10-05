// TO DO:
//    - window set-resizable while in transition-- set to false
//    - make bars half the screen
//    - see if clicking bar to pie, go, clear, then bar to pie works
//    - make the "BEGIN/CLEAR" button label font size depend upon the screensize.

int LINECHART = 0;
int PIECHART = 1;
int BARCHART = 2;
CircleButton[] buttons;

class animInterface{
  ArrayList animOrder; //list of currently pressed buttons  
  ArrayList animQueue; //list of buttons pressed at time of last "GO" Press
  String[] ButtonNames = {"Line Graph", "Pie Chart", "Bar Chart"};
  Rectangle buttonArea;
  Rectangle goButtonArea;

  animInterface(){
      animOrder = new ArrayList(3);
      animQueue = new ArrayList(3);
      buttonArea = new Rectangle(0, height * 7/8f, width*.75f, height*1/8f, "",color(0,250,0));
      goButtonArea = new Rectangle(.75*width,7/8f*height,width*.25,height*1/8f,"BEGIN", color(250,12,30));
      buttons = new CircleButton[ButtonNames.length];
      initializeButtons();
      update();

  }
    
  void update(){
    buttonArea.update(0, height * 7/8f, width*.75f, height*1/8f, "",color(0,250,0));
    goButtonArea.update(.75*width,7/8f*height,width*.25,height*1/8f,"BEGIN/CLEAR", color(250,12,30));
    redrawButtons();

  }

boolean goButtonClicked() {
  return goButtonArea.within(); 
}

  void checkButtons(){
    if (chart.state == NOCHART) {
      for (int i = 0; i<buttons.length; i++){
         if(buttons[i].within()){
            if(!buttons[i].clicked){
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
  }
      
  void updateOrder(){
     for(int i = 0; i<buttons.length;i++){
        //if buttons of i exists in the anim array, then update size;
        int curr = buttons[i].graphNum;
        if(animOrder.contains(curr)){
           buttons[i].orderNum = animOrder.indexOf(curr); 
        }
     } 
  }
  void initializeButtons(){
     float interval = buttonArea.w/buttons.length;
     float radius = height/8/2f;
     for(int i = 0; i<buttons.length;i++){
         buttons[i] = new CircleButton(i*interval+interval/2,buttonArea.posy + radius,radius-3,color(250,250, 100),ButtonNames[i],i);
     }
  }
  void redrawButtons(){
      updateOrder();

      float interval = buttonArea.w/buttons.length;
      float radius = height/16;
      for(int i = 0; i<buttons.length;i++){
        buttons[i].Redraw(i*interval+interval/2,buttonArea.posy + radius,radius-3);
      } 
  }
}

