class Node{
  int id;  //keyID
  int total;
  SortedSet children;
  float posx;                                        //TAYLOR
  float posy;                                        //TAYLOR
  float rectHeight;                                  //TAYLOR (previously height)
  float rectWidth;                                  //TAYLOR   (previously width)
  boolean isPlaced;                                  //TAYLOR
  float rectArea;                                    //TAYLOR
  float aspectRatio;                                  //TAYLOR
  Node(int id1) {
    id = id1;
    total = 0;
    isPlaced = false;                                //TAYLOR
    children = new TreeSet();
    aspectRatio = 0;                                //TAYLOR
  }
  


void populateRectInfo(float VA_ratio) {                                       
  rectArea = total * (1/ VA_ratio);
 //populates the rect's information (e.g. area)                 
}

void display_rect() {                                          
//  rect(posx, posy, rectHeight, rectWidth);
  rect(posx, posy, rectWidth, rectHeight);
}
}
