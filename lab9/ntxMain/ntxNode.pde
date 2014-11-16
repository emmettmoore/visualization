// connection fields
int STRENGTH = 2;
//labels fields
int NLEFT = 0;
int NTOP = 1;
int NRIGHT = 2;
int NBOTTOM = 3;
int NDIMENSIONS = 4;

class ntxExtLink {
  Integer id;
  String name;

  ntxExtLink(Integer id1, String name1) {
    id = id1;
    name = name1;
  }
}

class ntxNode {
  int w;
  int cell_width;
  float posx, posy;
  ArrayList<String> names;
  HashMap<String, ntxExtLink> external_connections;
  HashMap<String, HashMap<String, Integer>> connections;
  Cell[][] matrix;
  Cell[][] labels;
  //force-directed variables
  float kinetic_energy;
  ntxNode(ArrayList<String> names1, ArrayList<String> links) {
    kinetic_energy = 0;
    external_connections = new HashMap<String, ntxExtLink>();
    cell_width = 10;
    process_names(names1);
    process_links(links);
    populate_matrix();
  }
  boolean within() {
    if ((posx <= mouseX) && (mouseX <= posx + w)) {
      if ((posy <= mouseY) && (mouseY <= posy + w)) {
        return true;
      }
    }
    return false;
  }
  void initialize_matrix() {
      //names: array of names with order the same as input
      //connections: { from: { to: strength} }
      matrix = new Cell[names.size()][names.size()];
      labels = new Cell[NDIMENSIONS][names.size()];
      w = cell_width * names.size();
      posx = (float)Math.random() * (width - (2*w + cell_width));  // -w is so it doesn't go off screen.
      posy = (float)Math.random() * (height - (2*w + cell_width)); // might have to be readjusted to account
  }                                                                // for width of axis labels
  
  void update() {
    for (int i=0; i<names.size(); i++) {
      String from = names.get(i);
      for (int j=0; j<names.size(); j++) {
        matrix[i][j].display_heat();
      }
    }
    for (int i=0; i<NDIMENSIONS; i++) {
      for (int j=0; j < names.size(); j++) {
        labels[i][j].display_heat();
      }
    }
    //draw_external_links();
  }
  void process_names(ArrayList<String> names1) {
    names = new ArrayList<String>(names1);
    
    //and initialize hash maps with names as keys
    connections = new HashMap<String, HashMap<String, Integer>>();
    for (int i=0; i<names.size(); i++) {
      HashMap<String, Integer> new_row = new HashMap<String, Integer>();
      for (int j=0; j< names.size(); j++) {
        new_row.put(names.get(j), 0); // initialized to a strength of 0
      }  
      connections.put(names.get(i), new_row);
    }
  }
  void process_links(ArrayList<String> links) {
    for (int i=0; i< (2 * links.size()); i++) {
      String[] new_connection = splitTokens(links.get(i/2), ",");
      String from = new_connection[(i % 2)];
      String to = new_connection[1 - (i % 2)];
      Integer strength = Integer.parseInt(new_connection[STRENGTH]);
      //get current adjacency array for this name
      HashMap<String, Integer> curr_connection = connections.get(from);
      
      curr_connection.put(to, strength);
      // re-insert connection with added link
      connections.put(from, curr_connection);
    }
  }
  void populate_matrix(){
    initialize_matrix();
    // cells with data
    for (int i=0; i<names.size(); i++) {
      String from = names.get(i);
      for (int j=0; j<names.size(); j++) {
        String to = names.get(j);
        HashMap<String, Integer> to_info = connections.get(from);
        Integer strength = to_info.get(to);
        matrix[i][j] = new Cell(posx+(i*cell_width), posy+(j*cell_width),
                                cell_width, cell_width, "", strength);
      }
    }
    // x labels
    for (int j=0; j<NDIMENSIONS; j++) {
      for (int i=0; i < names.size(); i++) {
          labels[NLEFT][i] = new Cell(posx-cell_width, posy + (i*cell_width),
                                 cell_width, cell_width, names.get(i).substring(0,2), 0);
          labels[NTOP][i] = new Cell(posx+(i*cell_width), posy-cell_width,
                                  cell_width, cell_width, names.get(i).substring(0,2), 0);
          labels[NRIGHT][i] = new Cell(posx+w, posy + (i*cell_width),
                                  cell_width, cell_width, names.get(i).substring(0,2), 0);
          labels[NBOTTOM][i] = new Cell(posx+(i*cell_width), posy+w,
                                  cell_width, cell_width, names.get(i).substring(0,2), 0);
      }
    }
  }
  
  /* FILL THIS SHIT OUT ***************************************************
   ************************************************************************
   */
  void add_external_link(String from_name, Integer to_id, String to_name){
    external_connections.put(from_name, new ntxExtLink(to_id, to_name));
  }
  void update_forces() {
  }
  void update_velocity() {
  }
  void update_kinetic_energy() {
  }
  void update_positions(float drift_x, float drift_y) {
  }
  void reset_velocities() {
  } 
   
}
