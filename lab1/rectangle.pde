





class Rectangle {
  float posx;
  float posy;
  float w;
  float h;
  String T1;
  color C1;
  Rectangle(float posx1, float posy1, float w1, float h1, String txt, color color1) {

    update( posx1,  posy1,  w1,  h1, txt, color1);
    
  }
  
  boolean within() {
    if ((posx <= mouseX) && (mouseX <= posx + w)) {
      if ((posy <= mouseY) && (mouseY <= posy + h)) {
        return true;
      }
    }
    return false;
  }
  void update(float posx1, float posy1, float w1, float h1, String txt, color color1){
    posx = posx1;
    posy = posy1;
    w = w1;
    h = h1;
    T1 = txt;
    C1 = color1;
    fill(color1); 
    rect(posx,posy,w,h);
    textAlign(CENTER);
    text(T1, posx + w /2 , posy + h/2);
  }
  void Display(){
      fill(C1);
      rect(posx,posy, w,h);
      textAlign(CENTER);
      text(T1, posx + w /2 , posy + h/2);
  }
}







/*
class Rectangle {
  float orig_w;
  float orig_h;
  float curr_w;
  float curr_h;  
  float rect_posx, rect_posy; //top left corner
  String T1;
  color C1;
  Rectangle(float w, float h, float posx, float posy,String txt, color coluh) {
    draw_me(w,h,posx,posy,txt,coluh);
  }
  
  boolean within() {
    if ((rect_posx <= mouseX) && (mouseX <= rect_posx + curr_w)) {
      if ((rect_posy <= mouseY) && (mouseY <= rect_posy + curr_h)) {
        return true;
      }
    }
    return false;
  }
  void draw_me(float w, float h, float posx, float posy,String txt, color coluh){
    orig_w = w;
    orig_h = h;
    curr_w = orig_w;
    curr_h = orig_h;        
    rect_posx = posx;
    rect_posy = posy;
    T1 = txt;
    C1 = coluh;
     fill(C1);
     rect(rect_posx, rect_posy, curr_w, curr_h);
     fill(50);
     textAlign(CENTER);
     text(T1, rect_posx + curr_w /2 , rect_posy + curr_h/2);
  }
  void Display(){
     fill(C1);
     rect(rect_posx, rect_posy, curr_w, curr_h);
     fill(50);
     textAlign(CENTER);
     text(T1, rect_posx + curr_w /2 , rect_posy + curr_h/2);
  }
}*/
