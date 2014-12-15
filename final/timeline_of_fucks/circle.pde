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
    }
    void Display(){
//        strokeWeight(0);
//        fill(C1);
//        ellipse(posx, posy, radius*2,radius*2);
//        strokeWeight(1);
//  float animRadiusY=50+50*abs(sin(frameCount*0.05));
  drawGradientDisc(
    posx,
    posy,
    radius,
    radius,
    C1,
    color(0,0,0,10)
  );

}

void drawGradientDisc(float x,float y, float radiusX, float radiusY, int innerCol, int outerCol) {
  noStroke();
  beginShape(TRIANGLE_STRIP);
  for(float theta=0; theta<TWO_PI; theta+=TWO_PI/36) {
    fill(innerCol);
    vertex(x,y);
    fill(outerCol);
    vertex(x+radiusX*cos(theta),y+radiusY*sin(theta));
  }
  endShape();
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
