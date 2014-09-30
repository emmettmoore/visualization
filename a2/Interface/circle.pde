class Circle{
   int graphNum;
   boolean clicked;
   float centerX;
   float centerY;
   float radius;
   color C1;
   String T1;
    Circle(float centerX1, float centerY1, float radius1, color originalColor1, String text1, int graphNum1){
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
        textAlign(CENTER);
        text(T1,centerX, centerY);
    }
    boolean within(){
      double squareX = Math.pow(mouseX - centerX,2);
      double squareY = Math.pow(mouseY - centerY,2);
       if(squareX + squareY <= Math.pow(radius,2)){
          return true;   
       } 
       return false;
    }   
}
