HashMap<Integer,fdtNode> fdt_nodes;
float coulombK,hookeK;
fdtNode draggedNode;
float xOffset,yOffset; //used to calculate dragging


class fdtSystem{
  float ke_threshold;
  boolean first_run;
  float total_kinetic_energy;   
  float center_x = 0;
  float center_y = 0;
  float drift_x, drift_y;
  fdtSystem(){
    draggedNode = null;
    fdt_nodes = new HashMap<Integer,fdtNode>();
    first_run = true;
    total_kinetic_energy = 0;
    ke_threshold = 0; // fiddle with this to find appropriate value 
    coulombK = 200;//9000; // 10000
    hookeK = 0.1;
  }
  void watch(){
    print(total_kinetic_energy + "\n");
    calc_center();
    calc_drift_direction();
    calc_vector_changes();
    total_kinetic_energy = calc_kinetic_energy();
    if (first_run || KE_gt_threshold()) {
      first_run = false;
      apply_positional_changes();
    } 
    else { 
      reset_system();
      } 
    }
    
  void calc_center() {
    float total_x = 0;
    float total_y = 0;
    Set set = fdt_nodes.entrySet();
    Iterator i = set.iterator();
    while(i.hasNext()) {
      Map.Entry temp = (Map.Entry)i.next();
      fdtNode currNode = (fdtNode)temp.getValue();
      total_x += currNode.posx;
      total_y += currNode.posy;
    }
    center_x = total_x / fdt_nodes.size();
    center_y = total_y / fdt_nodes.size();
  }
  
  void calc_drift_direction() {
    calc_drift_x();
    calc_drift_y();
  }
  void calc_drift_x() {
    if (center_x < width / 2) {
      drift_x = 0.5;
    }
    else if (center_x == width / 2) {
      drift_x = 0;
    }
    else if (center_x > width / 2) {
      drift_x = -0.5;
    }
  }
void calc_drift_y() {
  if (center_y < height / 2) {
    drift_y = 0.5;
  }
  else if (center_y == height / 2) {
    drift_y = 0;
  }
  else if (center_y > height / 2) {
    drift_y = -0.5;
  }
}
  //vectors to calc:
    //hooke force vectors
    //coulomb force vectors
    //velocities
  //calculates all of the vector   
  void calc_vector_changes() {
     Set set = fdt_nodes.entrySet();
     Iterator i = set.iterator();
     while(i.hasNext()) {
       Map.Entry temp = (Map.Entry)i.next();
       fdtNode curr_node = (fdtNode)temp.getValue();
       //sums the forces of a single node
       curr_node.update_forces();
       curr_node.update_velocity();
     }  
  }
  // updates the kinetic energy of each node and returns the sum of the system
  float calc_kinetic_energy() {
     float KE = 0;
     Set set = fdt_nodes.entrySet();
     Iterator i = set.iterator();
     while(i.hasNext()) {
       Map.Entry temp = (Map.Entry)i.next();
       fdtNode curr_node = (fdtNode)temp.getValue();
       curr_node.update_kinetic_energy();
       KE += curr_node.kinetic_energy;
    }
    return KE;
  }
  
  //calculate:
    //acceleration
    //
  void apply_positional_changes(){
    Set set = fdt_nodes.entrySet();
    Iterator i = set.iterator();
    // Display elements
    while(i.hasNext()) {
      Map.Entry temp = (Map.Entry)i.next();
      fdtNode currNode = (fdtNode)temp.getValue();
      currNode.update_positions(drift_x, drift_y);
      
    }    
    
  }
  void draw_all_edges(){
    Set set = fdt_nodes.entrySet();
    Iterator i = set.iterator();
    // Display elements
    while(i.hasNext()) {
      Map.Entry temp = (Map.Entry)i.next();
      fdtNode currNode = (fdtNode)temp.getValue();
      draw_neighbor_edges(currNode);
    }
  }
  void draw_neighbor_edges(fdtNode currNode){
     for(int i = 0; i<currNode.neighbors.size();i++){
        neighborData neighbor = currNode.neighbors.get(i);
        fdtNode neighborNode = (fdtNode)fdt_nodes.get(neighbor.id);
        line(currNode.posx, currNode.posy, neighborNode.posx,neighborNode.posy);
        currNode.point.Display();
        neighborNode.point.Display();
     }
  }
  void reset_system() {
    Set set = fdt_nodes.entrySet();
    Iterator i = set.iterator();
    // set velocities to zero; the system is stable
      while(i.hasNext()) {
        Map.Entry temp = (Map.Entry)i.next();
        fdtNode curr_node = (fdtNode)temp.getValue();
        //sums the forces of a single node
        curr_node.reset_velocities(); 
      }
  }
  boolean KE_gt_threshold() {
    return (total_kinetic_energy > ke_threshold);   
  } 
  void checkHover(){
    Set set = fdt_nodes.entrySet();
    Iterator i = set.iterator();
    // Display elements
    while(i.hasNext()) {
      Map.Entry temp = (Map.Entry)i.next();
      fdtNode currNode = (fdtNode)temp.getValue();
      if(currNode.point.within()){
        displayNodeInfo(currNode);
      }
      else{
         currNode.point.C1 = color(250,100,0); 
      }
    }
  }
  void checkMouseState(fdtNode currNode){
    if (pressed && !already_pressed){
       xOffset = mouseX - currNode.posx;
       yOffset = mouseY - currNode.posy;
       draggedNode = currNode;
       already_pressed = true; 
    }
  }
  
  void displayNodeInfo(fdtNode currNode){
      textAlign(CENTER);
      String str = "ID: " + Integer.toString(currNode.id)  + "\n"
           + "Mass: " + Float.toString(currNode.mass); 
      fill(0,0,0);
      text(str, mouseX, mouseY - 30);
      currNode.point.C1 = color(0,100,250);
      checkMouseState(currNode);
  }
}
