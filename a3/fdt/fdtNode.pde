class fdtNode {
  int id;
  int mass;
  Circle point;
  ArrayList<neighborData> neighbors;
  //boolean locked; // tells whether the circle is being dragged
                    // i.e. immune from forces being acted on it

  fdtNode(int id1, int m) {
    neighbors = new ArrayList<neighborData>(); 
    id = id1;
    mass = m;
    point = new Circle( 1, 2, 3, color(100)); //uhhhh TODO!!!! //tay tay
  }
  void printNeighbors(){
     for (int i = 0; i<neighbors.size();i++){
        neighborData temp = (neighborData) neighbors.get(i); 
        print(temp.id + " ");
        print(temp.d); 
        print("\n"); 
   }
  } 
}


class neighborData {
  int id;
  int d;
  neighborData(int id1, int d1) {
    id = id1;
    d = d1;
  }
}
