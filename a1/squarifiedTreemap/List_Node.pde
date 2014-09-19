class Node{
  int id;  //keyID
  int total;
  SortedSet children;
  float posx;                                        //TAYLOR
  float posy;                                        //TAYLOR
  float rectHeight;                                  //TAYLOR (previously height)
  float rectWidth;                                  //TAYLOR   (previously width)
  boolean isPlaced;                                  //TAYLOR
  Node(int id1) {
    id = id1;
    total = 0;
    isPlaced = false;                                //TAYLOR
    children = new TreeSet();
  }
  


void populateRectInfo() {                                        //TAYLOR
 //populates the rect's information (e.g. area)                 //TAYLOR
}                                                                //TAYLOR

void display_rect() {                                          //TAYLOR
  rect(posx, posy, rectHeight, rectWidth);
}


}
