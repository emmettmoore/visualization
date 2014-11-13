class Cell {
  Rectangle rct;
  color heat_color;
  float count;
  boolean udp, tcp, info, teardown, built, deny;
  boolean[] source_ips;
  float posx, posy, h, w;
  
  
  Cell(float posx1, float posy1, float wt, float ht, String txt, int num_source_ips) {
    posx = posx1; posy = posy1;
    w = wt; h = ht;
    heat_color = color(255);
    count = 0;
    udp = false; tcp = false; info = false; teardown = false; built = false; deny = false;
    source_ips = new boolean[num_source_ips];
    for (int i=0; i < num_source_ips; i++) {
      source_ips[i] = false;
    }
    rct = new Rectangle(posx1, posy1, wt, ht, txt, heat_color);
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
    rct.C1 = color(230, 123, 130);
    rct.Display();
  }
}
