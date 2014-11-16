class Cell {
  Rectangle rct;
  color heat_color;
  float posx, posy, h, w;
  
  Cell(float posx1, float posy1, float wt, float ht, String txt, int strength) {
    posx = posx1; posy = posy1;
    w = wt; h = ht;
    rct = new Rectangle(posx1, posy1, wt, ht, txt, heat_color);
    colorMode(HSB, 360, 100, 100);
    set_heat_color(color(240, strength * 20, 100));
    colorMode(RGB, 255, 255, 255);
  }
  void set_heat_color(color hc) {
      heat_color = hc;
      rct.C1 = hc;
  }
  void display_highlight() {
    rct.C1 = color(23, 23, 230);
    rct.Display();
  }
  void display_heat() {
    rct.C1 = heat_color;
    rct.Display();
  }
}
