int BUFFER = 10;

class fdtNode {
  float posx;
  float posy;
  float radius;
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
    initializeCircle();

  }
  void printNeighbors(){
     for (int i = 0; i<neighbors.size();i++){
        neighborData temp = (neighborData) neighbors.get(i); 
        print(temp.id + " ");
        print(temp.d); 
        print("\n"); 
   }
  } 
  void initializeCircle(){
      float radius = sqrt(mass/PI) * 10;
      posx = (float)Math.random() * width + BUFFER;
      posy = (float)Math.random() * height + BUFFER;
      point = new Circle(posx,posy, radius, color(250,100,0));
  }
}
class neighborData {
  int id;
  float d;
  float posx;
  float posy;
  neighborData(int id1, float d1, float posx1, float posy1) {
    id = id1;
    d = d1;
    posx = posx1;
    posy = posy1;
  }
}
