// connection fields
int STRENGTH = 2;
class ntxNode {
  int id;
  int w;
  int cell_width;
  float posx, posy;
  ArrayList<String> names;
  HashMap<String, HashMap<String, Integer>> connections;
  Cell[][] matrix;
  ntxNode(int id1, ArrayList<String> names1, ArrayList<String> links) {
    id = id1;
    cell_width = 20;
    process_names(names1);
    process_links(links);
    populate_matrix();
  }
  void initialize_matrices() {
      w = cell_width * names.size();
      posx = (float)Math.random() * (width - w);  // -w is so it doesn't go off screen.
      posy = (float)Math.random() * (height - w); // might have to be readjusted to account
  }                                               // for width of axis labels
  
  void update() {
    for (int i=0; i<names.size() - 1; i++) {
      String from = names.get(i);
      for (int j=0; j<names.size() - 1; j++) {
        matrix[i][j].display_heat();
      }
    }
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
    initialize_matrices();

    //names: array of names with order the same as input
    //connections: { from: { to: strength} }
    matrix = new Cell[names.size() + 1][names.size() + 1];
    for (int i=0; i<names.size() - 1; i++) {
      String from = names.get(i);
      for (int j=0; j<names.size() - 1; j++) {
        String to = names.get(j);
        HashMap<String, Integer> to_info = connections.get(from);
        Integer strength = to_info.get(to);
        matrix[i][j] = new Cell(posx+(i*cell_width), posy+(j*cell_width),
                                cell_width, cell_width, "", from, to, strength);
      }
    }
  }
}
