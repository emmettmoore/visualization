int BUFFER = 10;

class fdtNode {
  float posx, posy;
  float vX,vY;
  float radius;
  int id;
  float mass;
  Forces forceData;
  Circle point;
  ArrayList<neighborData> neighbors;
  //boolean locked; // tells whether the circle is being dragged
                    // i.e. immune from forces being acted on it

  fdtNode(int id1, int m) {
    neighbors = new ArrayList<neighborData>(); 
    id = id1;
    mass = m;
    initializeCircle();
    forceData = new Forces();

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
  float kineticEnergy(){
     return (0.5 * mass * (pow(vX, 2) + pow(vY, 2))); 
  }
  
  void update_forces() {
    calc_coulomb();
    //calc_hooke();
  }
  void calc_coulomb(){
    forceData.coulombX = forceData.coulombY = 0;
    Set set = fdt_nodes.entrySet();
    Iterator i = set.iterator();
    // Display elements
    while(i.hasNext()) {
      Map.Entry temp = (Map.Entry)i.next();
      fdtNode currNode = (fdtNode)temp.getValue();
      if(currNode.id != id){
         forceData.coulombX += (coulombK*mass*currNode.mass)/(pow(posx - currNode.posx,2));  
         forceData.coulombY += (coulombK*mass*currNode.mass)/(pow(posy - currNode.posy,2));
      }
    }
  }
  //not done yet
  void calc_hooke() {
      for(int i = 0; i<neighbors.size();i++){
        neighborData neighbor_info = (neighborData)neighbors.get(i);
        fdtNode curr_node = (fdtNode) fdt_nodes.get(neighbor_info.id);
    }
  }
  
  //add the hook and coulomb forces together
  void sum_forcesX(){
      forceData.totalX = forceData.coulombX;
  }
  void sum_forcesY(){
      forceData.totalY = forceData.coulombY;
  }
}
//--------------------------------end fdtNode class ----------------------------------------------

class neighborData {
  int id;
  float d;
  float posx;
  float posy;
  neighborData(int id1, float d1){
    id = id1;
    d = d1;
  }
}
class Forces{
 float coulombX, coulombY;
 float hookeX,hookeY;
 float totalX, totalY;
 Forces(){
  coulombX = coulombY = 0;
  hookeX = hookeY = 0;
 } 
  
}
