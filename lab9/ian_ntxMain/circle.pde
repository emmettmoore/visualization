class Circle{
   float posx;
   float posy;
   float radius;
   color C1;
    Circle(float x, float y, float r, color c){
        posx = x;
        posy = y;
        radius = r;
        C1 = c;
        //Display();
    }
    void Display(){
        //fill(C1);
        //ellipse(posx, posy, radius*2,radius*2);
    }
    boolean within(){
      double squareX = Math.pow(mouseX - posx,2);
      double squareY = Math.pow(mouseY - posy,2);
       if(squareX + squareY <= Math.pow(radius,2)){
          return true;   
       } 
       return false;
    }   
}
