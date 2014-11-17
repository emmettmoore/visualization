class ntxSystem {
  int frames_since_equilibrium;
  ArrayList<ntxNode> nodes; //   CRUCIAL data structure
  float total_kinetic_energy;
  float center_x, center_y;
  float drift_x, drift_y;
  float ke_threshold;
  ntxSystem(int num_nodes) {
    center_x = 0;
    center_y = 0;
    frames_since_equilibrium = 0;
    ke_threshold = 0;
    total_kinetic_energy = 0;
    nodes = new ArrayList<ntxNode>(num_nodes);
  }
  void init_put(Integer curr_id, ntxNode curr_node){
    nodes.add(curr_id, curr_node);
  }
  void update() {
    calc_center();
    calc_drift_direction();
    calc_vector_changes();
    total_kinetic_energy = calc_kinetic_energy();
    if (KE_gt_threshold()) {
      apply_positional_changes();
    } 
    else {
      reset_system();
    }
    // don't delete this. only lines in update not yanked from fdt
    for (int i=0; i<nodes.size(); i++) {
      ntxNode curr_node = nodes.get(i);
      curr_node.update();
    }
  }
  void add_external_link(String from_name, String from_id, String to_name, String to_id){
    ntxNode from_node = nodes.get(Integer.parseInt(from_id));
    from_node.add_external_link(from_name, Integer.parseInt(to_id), to_name);
    // other side: needed for correct force values
    ntxNode to_node = nodes.get(Integer.parseInt(to_id));
    to_node.add_external_link(to_name, from_id, from_name);
  }
  
  
  /*  EMMETT does not guarantee trustworthy functionality below this line 
   *** copied from fdt ************************ unfinished work **********
   *** continue at your own risk **************** you have been warned ***
   ***********************************************************************
   */ //TAYLOR
   
  void calc_center() {
    float total_x = 0;
    float total_y = 0;
    for (int i=0; i<nodes.size(); i++) {
      ntxNode currNode = nodes.get(i);
      total_x += currNode.posx;
      total_y += currNode.posy;
    }

    center_y = total_y / nodes.size();
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
    for (int i=0; i<nodes.size(); i++) {
       ntxNode curr_node = nodes.get(i);
       //sums the forces of a single node
       curr_node.update_forces();
       curr_node.update_velocity();
     }  
  }
  // updates the kinetic energy of each node and returns the sum of the system
  float calc_kinetic_energy() {
    float KE = 0;
    for (int i=0; i<nodes.size(); i++) {
      ntxNode curr_node = nodes.get(i); 
      curr_node.update_kinetic_energy();
      KE += curr_node.kinetic_energy;
    }
    return KE;
  }
  //calculate:
    //acceleration
    //
  void apply_positional_changes(){
    for (int i=0; i<nodes.size(); i++) {
      ntxNode curr_node = nodes.get(i);
      curr_node.update_positions(drift_x, drift_y);
    }
  }
  void draw_all_edges(){
    for (int i=0; i<nodes.size(); i++) {
      ntxNode curr_node = nodes.get(i);
      draw_neighbor_edges(curr_node);
    }
  }
  void draw_neighbor_edges(ntxNode currNode){
/*     for(int i = 0; i<currNode.neighbors.size();i++){
        neighborData neighbor = currNode.neighbors.get(i);
        ntxNode neighborNode = (ntxNode)ntx_nodes.get(neighbor.id);
        line(currNode.posx, currNode.posy, neighborNode.posx,neighborNode.posy);
        currNode.point.Display();
        neighborNode.point.Display();
     }*/
  }
  void reset_system() {
    for (int i=0; i<nodes.size(); i++) {
      ntxNode curr_node = nodes.get(i);
      curr_node.reset_velocities(); 
    }
  }
  boolean KE_gt_threshold() {
    frames_since_equilibrium++;
    if (frames_since_equilibrium > 60) {
      return (total_kinetic_energy > ke_threshold);
        
    }
    else {
      return true;
    }
  }
  void checkHover(){
    for (int i=0; i<nodes.size(); i++) {
      ntxNode curr_node = nodes.get(i);
      if(curr_node.within()){
        displayNodeInfo(curr_node);
      }
    }
  }
/*  void checkMouseState(ntxNode currNode){
    if (pressed || already_pressed) {
      frames_since_equilibrium = 0;
    }
    if (pressed && !already_pressed){
       xOffset = mouseX - currNode.posx;
       yOffset = mouseY - currNode.posy;
       draggedNode = currNode;
       already_pressed = true;
    }
  }*/
  
  void displayNodeInfo(ntxNode currNode){
/*    textAlign(CENTER);
    String str = "ID: " + Integer.toString(currNode.id)  + "\n"
         + "Mass: " + Float.toString(currNode.mass); 
    fill(0,0,0);
    text(str, mouseX, mouseY - 30);
    currNode.point.C1 = color(0,100,250);
    checkMouseState(currNode);
  */}
}
