int BUFFER = 10;

class fdtNode {
  float posx, posy;
  float vX,vY;
  float kinetic_energy;
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
    reset_velocities();
    kinetic_energy = 0;
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
  
  void update_forces() {
    calc_coulomb();
    //calc_hooke();
    sum_forces();
  }
  
  void update_velocity() {
    vX = vX + forceData.totalX / mass * time_step;
    vY = vY + forceData.totalY / mass * time_step;
  }
  
  void update_kinetic_energy() {
    kinetic_energy = (0.5 * mass * (pow(vX, 2) + pow(vY, 2)));
    
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
        float y_dist = abs(currNode.posy - posy);
        float x_dist = abs(currNode.posx - posx);
         if (posx > currNode.posx) {
           forceData.coulombX += (x_dist / y_dist) * (coulombK*mass*currNode.mass)/(pow(dist(posx, posy, currNode.posx, currNode.posy),2));
         }
         else {
           forceData.coulombX -= (x_dist / y_dist) * (coulombK*mass*currNode.mass)/(pow(dist(posx, posy, currNode.posx, currNode.posy),2));
         }  
         if (posy > currNode.posy) {
           forceData.coulombY += (y_dist / x_dist) * (coulombK*mass*currNode.mass)/(pow(dist(posx, posy, currNode.posx, currNode.posy),2));
         }
         else {
           forceData.coulombY -= (y_dist / x_dist) * (coulombK*mass*currNode.mass)/(pow(dist(posx, posy, currNode.posx, currNode.posy),2));
         }
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
  void sum_forces() {
    sum_forcesX();
    sum_forcesY();
  }
  //add the hook and coulomb forces together
  void sum_forcesX(){
      forceData.totalX = 0;
      forceData.totalX += forceData.coulombX;
      //forceData.totalX += forceData.hookeX;
  }
  void sum_forcesY(){
      forceData.totalY = 0;
      forceData.totalY = forceData.coulombY;
      //forceData.totalY += forceData.hookeY;
  }
  void reset_velocities() {
    vX = 0;
    vY = 0;
  }
  void update_positions() {
    print("got to update_positions\n");
    print("posx pre-change: " + posx + " \n");
    //print("posy pre-change: " + posy + " \n");
    posx = posx + (vX * time_step);
    posy = posy + (vY * time_step);
    print("posx post-change: " + posx + " \n");
    point.posx = posx;
    point.posy = posy;
    point.Display();
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
