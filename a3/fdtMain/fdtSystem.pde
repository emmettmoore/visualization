HashMap<Integer,fdtNode> fdt_nodes;
float coulombK,hookeK;

class fdtSystem{
  float ke_threshold;
  boolean first_run;
  float total_kinetic_energy;
  fdtSystem(){
    fdt_nodes = new HashMap<Integer,fdtNode>();
    first_run = true;
    total_kinetic_energy = 0;
    ke_threshold = 0; // fiddle with this to find appropriate value 
    coulombK = 9000; // 10000
    hookeK = 0.1;
  }
  void watch(){
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
      currNode.update_positions();
      
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
          fill(0,0,0);
          textAlign(CENTER);
          String str = "ID: " + Integer.toString(currNode.id)  + "\n"
               + "Mass: " + Float.toString(currNode.mass); 
          text(str, currNode.posx, currNode.posy - 30);
          currNode.point.C1 = color(0,100,250);
          currNode.point.Display();
      }
      else{
         currNode.point.C1 = color(250,100,0); 
      }
    }
  }
}
