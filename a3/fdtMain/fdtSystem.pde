HashMap<Integer,fdtNode> fdt_nodes;
float coulombK,hookeK;
class fdtSystem{
  float ke_threshold;
  boolean first_run;
  fdtSystem(){
    fdt_nodes = new HashMap<Integer,fdtNode>();
    first_run = true;
    ke_threshold = 1; // fiddle with this to find appropriate value 
    coulombK = hookeK = 1; //temporary
  }
  void watch(){
    calc_vector_changes();
    if (first_run || KE_gt_threshold()) {
      first_run = false;
      apply_positional_changes();  
    } 
  } 
  //vectors to calc:
    //hooke force vectors
    //coulomb force vectors
    //velocities
    
  void calc_vector_changes() {
     Set set = fdt_nodes.entrySet();
     Iterator i = set.iterator();
     while(i.hasNext()) {
       Map.Entry temp = (Map.Entry)i.next();
       fdtNode curr_node = (fdtNode)temp.getValue();
       //sums the forces of a single node
       curr_node.update_forces();
    }  
  }
  
  //calculate:
    //acceleration
    //
  void apply_positional_changes(){
    
    
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
     }
  }

  boolean KE_gt_threshold() {
     float total_ke = 0;
     Set set = fdt_nodes.entrySet();
     Iterator i = set.iterator();
     while(i.hasNext()) {
       Map.Entry temp = (Map.Entry)i.next();
       fdtNode curr_node = (fdtNode)temp.getValue();
       total_ke += curr_node.kineticEnergy();
    }
    return (total_ke > ke_threshold);   
  } 
}
