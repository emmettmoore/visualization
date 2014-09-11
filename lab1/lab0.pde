
class Rectangle {
  float orig_w;
  float orig_h;
  float curr_w;
  float curr_h;  
  float rect_posx, rect_posy; //top left corner
  String T1,T2, curr_txt;
  color C1, C2, curr_color;
  Rectangle(float w, float h, float posx, float posy, String txt, String txt2, color coluh, color coluh2) {
    orig_w = w;
    orig_h = h;
    curr_w = orig_w;
    curr_h = orig_h;        
    rect_posx = posx;
    rect_posy = posy;
    T1 = txt;
    T2 = txt2;
    curr_txt = T1;
    C1 = coluh;
    C2 = coluh2;
    curr_color = C1;
    draw_me();
  }
  boolean within() {
    if ((rect_posx <= mouseX) && (mouseX <= rect_posx + curr_w)) {
      if ((rect_posy <= mouseY) && (mouseY <= rect_posy + curr_h)) {
        return true;
      }
    }
    return false;
  }
  boolean is_small() {
    if ((curr_h == orig_h) && (curr_w == orig_w)) {
      return false;
    }
    return true;
  }
  
  void new_size() {
    color my_color;
    if (is_small()) {
      curr_h = orig_h;
      curr_w = orig_w;
      rect_posx = (SCREEN_WIDTH / 4);
      rect_posy = (SCREEN_HEIGHT / 4);      
      curr_color = C1;
      curr_txt = T1;
    }
    else {
      curr_h = SCREEN_HEIGHT / 3; 
      curr_w = SCREEN_WIDTH / 3;
      rect_posx = orig_w - (curr_w / 2);
      rect_posy = orig_h - (curr_h / 2);      
      curr_color = C2;
      curr_txt = T2;

    }  
    draw_me();

  }
  void draw_me(){
     fill(curr_color);
     rect(rect_posx, rect_posy, curr_w, curr_h);
     fill(50);
     textAlign(CENTER);
     text(curr_txt, rect_posx + curr_w /2 , rect_posy + curr_h/2);
  }
}
