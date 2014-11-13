import java.util.*;

String fn = "data1.csv"; 
int NUM_NODES;
// node_info fields
int ID = 0;
int NAMES = 1;
int LINKS = 2;
//curr_link fields
int STRENGTH = 2;

class nxtLink {
  String name;
  int strength;
  nxtLink(String n, int s) {
    name = n;
    strength = s;
  }
}
class ntxNode {
  int id;
  ArrayList<String> names;
  HashMap<String, HashMap<String, Integer>> connections;
  Cell[][] matrix;
  ntxNode(int id1, ArrayList<String> names1, ArrayList<String> links) {
    id = id1;
    process_names(names1);
    process_links(links);
    populate_matrix();
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
    
  }
}

class ntxSystem {

  ArrayList<ntxNode> nodes;
  int curr_index = 0;
  ntxSystem(int num_nodes) {
    nodes = new ArrayList<ntxNode>(num_nodes);
  }
  void init_put(ntxNode curr_node){
    nodes.add(curr_index++, curr_node);
  }
}

ntxSystem system;

void setup() {
  size(1200,800);
  background(250,250,250);
  parse_data();
}

void draw() {
   background(250,250,250);

}

void parse_data() {
  String lines[] = loadStrings(fn);
  int index = 0;
  NUM_NODES = Integer.parseInt(lines[index++]);
  system = new ntxSystem(NUM_NODES);
  for (int i=0; i< NUM_NODES; i++) {
    String[] node_info = splitTokens(lines[index++], ",");
    Integer curr_id = Integer.parseInt(node_info[ID]);
    Integer num_names = Integer.parseInt(node_info[NAMES]);
    Integer num_links = Integer.parseInt(node_info[LINKS]);
    //populate list of names for this node
    ArrayList<String> curr_names = new ArrayList<String>(num_names);
    for (int j=0; j< num_names; j++) {
      curr_names.add(j,lines[index]);
      index++;
    }
    //populate list of links for this node, where two link names are separated by commas
    ArrayList<String> curr_links = new ArrayList<String>(num_names);
    for (int j=0; j<num_links; j++) {
      curr_links.add(j,lines[index]);
      index++;
    }
    system.init_put(new ntxNode(curr_id, curr_names, curr_links));
  }
} 
