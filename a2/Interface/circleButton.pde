class CircleButton{
   int graphNum;
   int orderNum;
   boolean clicked;
   float centerX;
   float centerY;
   float radius;
   color C1;
   String T1;
    CircleButton(float centerX1, float centerY1, float radius1, color originalColor1, String text1, int graphNum1){
        clicked = false;
        graphNum = graphNum1;
        centerX = centerX1;
        centerY = centerY1;
        radius = radius1;
        T1 = text1;
        C1 = originalColor1;
        Display();
    }
    void Display(){

        fill(C1);
        ellipse(centerX, centerY, radius*2,radius*2);
        fill(0);
        textAlign(CENTER,BASELINE);
        textSize(12);
        text(T1,centerX, centerY);
        clickedStatus();
    }
    boolean within(){
      double squareX = Math.pow(mouseX - centerX,2);
      double squareY = Math.pow(mouseY - centerY,2);
       if(squareX + squareY <= Math.pow(radius,2)){
          return true;   
       } 
       return false;
    }   
    void clickedStatus(){
       if(clicked){
         textAlign(CENTER,BASELINE);
         textSize(32);
         fill(250,0,0);
          text(Integer.toString((Integer)orderNum +1),centerX, centerY + 20);  
       } 
    }
    void Redraw(float centerX1, float centerY1, float radius1){
        centerX = centerX1;
        centerY = centerY1;
        radius = radius1;
        Display();
    }
}
