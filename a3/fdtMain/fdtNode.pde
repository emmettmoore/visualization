int BUFFER = 10;

class fdtNode {
  float posx, posy;
  float vX,vY, new_vX, new_vY;
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

  void initializeCircle(){
      float radius = sqrt(mass/PI) * 10;
      posx = (float)Math.random() * width + BUFFER;
      posy = (float)Math.random() * height + BUFFER;
      point = new Circle(posx,posy, radius, color(250,100,0));
  }
  
  void update_forces() {
    calc_coulomb();
    calc_hooke();
    sum_forces();
  }
  
  void update_velocity() {
    new_vX = vX + forceData.totalX / mass * time_step;
    new_vY = vY + forceData.totalY / mass * time_step;
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
        
        float theta = get_theta(currNode);
        float dist = dist(posx, posy, currNode.posx,currNode.posy);
        forceData.coulombX += (coulombK/dist)* cos(theta);
        forceData.coulombY += (coulombK/dist)* sin(theta);
       }
     }
   }
   
  void calc_hooke() {
      forceData.hookeX = 0;
      forceData.hookeY = 0;
      for(int i = 0; i<neighbors.size();i++){
        neighborData neighbor_info = (neighborData)neighbors.get(i);
        fdtNode curr_node = (fdtNode) fdt_nodes.get(neighbor_info.id);
        float theta = get_theta(curr_node);
        float dist = dist(posx, posy, curr_node.posx,curr_node.posy);
        float delta_dist = neighbor_info.equil_dist - dist;
        forceData.hookeX += (hookeK*delta_dist)* cos(theta);
        forceData.hookeY += (hookeK*delta_dist)* sin(theta);
        
    }
  }
  
  float get_theta(fdtNode currNode){
     float distHeight = currNode.posy - posy ;
     float distWidth = currNode.posx - posx;
     if(posx <= currNode.posx){
         return atan(distHeight/distWidth) + PI;    
     }
     return atan(distHeight/distWidth);
   }
  void sum_forces() {
    sum_forcesX();
    sum_forcesY();
  }
  //add the hook and coulomb forces together
  void sum_forcesX(){
      forceData.totalX = 0;
      forceData.totalX += forceData.coulombX;
      forceData.totalX += forceData.hookeX;
  }
  void sum_forcesY(){
      forceData.totalY = 0;
      forceData.totalY = forceData.coulombY;
      forceData.totalY += forceData.hookeY;
  }
  void reset_velocities() {
    vX = 0;
    vY = 0;
  }
  void update_positions() {
    float new_posx = posx;
    float new_posy = posy;
    new_posx = new_posx + (new_vX * time_step);
    new_posy = new_posy + (new_vY * time_step);
    if (new_posx > 0 && new_posx < width && new_posy > 0 && new_posy < height) { 
      vX = new_vX;
      vY = new_vY;
      posx = new_posx;
      posy = new_posy;
      point.posx = new_posx;
      point.posy = new_posy;
    }
    else {
      if (id == 1){
      print (vX + "\n");
      }
      vX = vX * 0.75;
      vY = vY * 0.75;
      posx -= forceData.coulombX * 0.25;
      posy -= forceData.coulombY * 0.25;
      point.posx = posx;
      point.posy = posy;
      
    }
  }

}
