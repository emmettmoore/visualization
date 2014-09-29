
class Rectangle {
  float posx;
  float posy;
  float w;
  float h;
  String T1;
  color C1;
  Rectangle(float posx1, float posy1, float w1, float h1, color color1) {

    update( posx1,  posy1,  w1,  h1,  color1);
    
  }
  
  boolean within() {
    if ((posx <= mouseX) && (mouseX <= posx + w)) {
      if ((posy <= mouseY) && (mouseY <= posy + h)) {
        return true;
      }
    }
    return false;
  }
  void update(float posx1, float posy1, float w1, float h1, color color1){
    posx = posx1;
    posy = posy1;
    w = w1;
    h = h1;
    C1 = color1;
    fill(color1); 
    rect(posx,posy,w,h);
  }
}
