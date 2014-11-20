HashMap<Integer,fdtNode> fdt_nodes;
float coulombK,hookeK;
fdtNode draggedNode;
float xOffset,yOffset; //used to calculate dragging
float DAMPING = 0.987;
float ke_threshold;

class fdtSystem{
  int frames_since_equilibrium;
  float total_kinetic_energy;   
  float center_x = 0;
  float center_y = 0;
  float drift_x, drift_y;
  fdtSystem(){
    draggedNode = null;
    fdt_nodes = new HashMap<Integer,fdtNode>();
    frames_since_equilibrium = 0;
    total_kinetic_energy = 0;
    hookeK = 0.1*15;
  }
  void watch(){
    //print("total KE is " + total_kinetic_energy + "\n");
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
  // go through all nodes and draw the edges
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
  //for one node, draw all the edges
  void draw_neighbor_edges(fdtNode currNode){
     for(int i = 0; i<currNode.specific_neighbors.size();i++){
       
        //get the desired neighbor id and name
        node_name_link neighbor = currNode.specific_neighbors.get(i);
        
        //get the actual neighbor node
        fdtNode neighborNode = (fdtNode)fdt_nodes.get(neighbor.to_id);

        //get the index of the name in the current node  //CURR NAME INDEX
        int curr_index = currNode.adj_matrix.get_name_index(neighbor.current_name);
        
        //get the index of the name in the neighbor node //NEIGH NAME INDEX
        int neigh_index = neighborNode.adj_matrix.get_name_index(neighbor.to_name);
        
        //int NLEFT = 0;
//int NTOP = 1;
//int NRIGHT = 2;
//int NBOTTOM = 3;
//int NDIMENSIONS = 4;
          //Each node has four arrays of label cells. the following will find out which precise curr_index label cell  of curr_node
           //   is located closest to the closest precise neigh_index label cell of neigh_node.
         float distance = dist(neighborNode.adj_matrix.labels[NLEFT][neigh_index].posx, 
                               neighborNode.adj_matrix.labels[NLEFT][neigh_index].posy,
                               currNode.adj_matrix.labels[NLEFT][curr_index].posx,
                               currNode.adj_matrix.labels[NLEFT][curr_index].posy);   
         int currs_ind = NLEFT;
         int neighs_ind = NLEFT; 
         for(int a = 0; a < NDIMENSIONS; a++) {
           for (int b = 0; b < NDIMENSIONS; b++) {
              float tempDist = dist(neighborNode.adj_matrix.labels[a][neigh_index].posx, 
                                    neighborNode.adj_matrix.labels[a][neigh_index].posy,
                                    currNode.adj_matrix.labels[b][curr_index].posx,
                                    currNode.adj_matrix.labels[b][curr_index].posy);
                  if (tempDist < distance) {
                    distance = tempDist;
                    neighs_ind = a;
                    currs_ind = b;
                  }
           }
         }
         
         //The following will now find the positions of the two chosen cells.
        float sourceX,sourceY;//for curr_node
        float destX,destY;    //for neigh_node
        sourceX = currNode.adj_matrix.labels[currs_ind][curr_index].posx;
        sourceY = currNode.adj_matrix.labels[currs_ind][curr_index].posy;
        destX = neighborNode.adj_matrix.labels[neighs_ind][neigh_index].posx;
        destY = neighborNode.adj_matrix.labels[neighs_ind][neigh_index].posy;

        //The following function call will result in finding the eact x and y
        //points of the two chosen cells, so that a line
        //  can be drawn to connect the outer edges of the two the cells together.
        //NOTE: uses global variable for cell_width.
        sourceX = find_midpoint_x(sourceX, cell_width, currs_ind);
        sourceY = find_midpoint_y(sourceY, cell_width, currs_ind);
        destX = find_midpoint_x(destX, cell_width, neighs_ind);
        destY = find_midpoint_y(destY, cell_width, neighs_ind);
        
        
        print ("curr " + curr_index + "neighbor index " + neigh_index + "\n");

        
        //doesn't mean anything really. this line is just aesthetic. this is where we will
        //draw lines that connect names. REMEMBER, drawn lines mean nothing as far as the forces are concerned
        //Taylor, pick up here!
        //calc which side of the adj matrix to draw in
        //all the information you need is in curr_node and neighborNode
//        line(currNode.posx, currNode.posy, neighborNode.posx,neighborNode.posy);
        line(sourceX, sourceY, destX, destY);
        
        //currNode.point.Display();
        //neighborNode.point.Display();
     }
  }
  
  //Helper function to draw_neighbor_edges().
  //The following will now find the midpoint of a cell given the xposition which was
  //  passed in and the side of the cell on which the midpoint will need to lay
  //Takes in the positionX of the cell, and the dimension_position (whether its ==
  //     NTOP, NRIGHT, NLEFT, or NBOTTOM) and finds the midpoint for X.
  float find_midpoint_x(float p_x, float cellWid, int dimension_pos) {
    float x_midpoint = p_x; 
    if ((dimension_pos == NTOP) || (dimension_pos == NBOTTOM)) {
      x_midpoint = p_x + cellWid /2f;
    } else if (dimension_pos == NRIGHT) {
      x_midpoint = p_x + cellWid;
    }
    return x_midpoint;
  }
  
    //Helper function to draw_neighbor_edges().
  //The following will now find the midpoint of a cell given the yposition which was
  //  passed in and the side of the cell on which the midpoint will need to lay
  //Takes in the positionY of the cell, and the dimension_position (whether its ==
  //     NTOP, NRIGHT, NLEFT, or NBOTTOM) and finds the midpoint for Y.
  float find_midpoint_y(float p_y, float cellWid, int dimension_pos) {
    float y_midpoint = p_y;
    if ((dimension_pos == NLEFT) || (dimension_pos == NRIGHT)) {
      y_midpoint = p_y + cellWid / 2f;
    } else if (dimension_pos == NBOTTOM) {
      y_midpoint = p_y + cellWid;
    }
    return y_midpoint;
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
    frames_since_equilibrium++;
    if (frames_since_equilibrium > 60) {
      return (total_kinetic_energy > ke_threshold);
         
    }
    else {
      return true;
    }
  } 
  void checkHover(){
    Set set = fdt_nodes.entrySet();
    Iterator i = set.iterator();
    // Display elements
    while(i.hasNext()) {
      Map.Entry temp = (Map.Entry)i.next();
      fdtNode currNode = (fdtNode)temp.getValue();
      if(currNode.adj_matrix.border.within()){
//        displayNodeInfo(currNode);
        currNode.adj_matrix.display_border();
               displayNodeInfo(currNode);

      }
      else{
         currNode.point.C1 = color(250,100,0); 
      }
    }
  }
  void checkMouseState(fdtNode currNode){
    print ("dickwad\n");

    if (pressed || already_pressed) {
      frames_since_equilibrium = 0;
    }
    if (pressed && !already_pressed){
       xOffset = mouseX - currNode.posx;
       yOffset = mouseY - currNode.posy;
       draggedNode = currNode;
       already_pressed = true;
    }
  }
  
  void displayNodeInfo(fdtNode currNode){
      textFont(createFont("Arial Bold", 18));//taylor added
      textAlign(CENTER);
      String str = "ID: " + Integer.toString(currNode.id)  + "\n"
           + "Mass: " + Float.toString(currNode.mass); 
      fill(0,0,0);
      text(str, mouseX, mouseY - 30);
      currNode.point.C1 = color(0,100,250);
      checkMouseState(currNode);//ONLY LINE that wasnt commented out
  }
}
