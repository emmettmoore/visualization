
class MyCircle {
  int id;
  int posx, posy, radius;
  int r, g, b;
  boolean selected = false;
  
  MyCircle(int _id, int _posx, int _posy, int _radius) {
    id = _id;
    posx = _posx;
    posy = _posy;
    radius = _radius;
  }
  
  void setColor (int _r, int _g, int _b) {
    r = _r; g = _g; b = _b;
  }
  
  boolean getSelected () {
    return selected;
  }
  
  void setSelected (boolean _selected) {
    selected = _selected;
  }
  
  void render() {
    strokeWeight(5);
    stroke(r, g, b);
    noFill();
    ellipse(posx, posy, radius*2, radius*2);  
  }
  
  void renderIsect(PGraphics pg) {
    pg.fill(red(id), green(id), blue(id));
    pg.stroke(red(id), green(id), blue(id));
    pg.strokeWeight(5);
    pg.ellipse(posx, posy, radius*2, radius*2);  
  }
  
  void renderSelected() {
    strokeWeight(1);
    stroke(r, g, b);
    fill (r, g, b, 128);
    ellipse(posx, posy, radius*2, radius*2);      
  }
boolean isect(float x1, float y1) {
  float x0 = posx;
  float y0 = posy;
  if (((x1 - x0) * (x1 - x0) + (y1 - y0)*(y1-y0)) <= (radius*radius)) {
          return true;
        }
    return false;
  }
}
