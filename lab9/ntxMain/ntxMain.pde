import java.util.*;

String fn = "data1.csv"; 
int NUM_NODES;
//node_info 
int ID = 0;
int NAMES = 1;
int LINKS = 2;
ntxSystem system;

void setup() {
  size(1200,800);
  background(250,250,250);
  parse_data();
}

void draw() {
   background(250,250,250);
   system.update();
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
    system.init_put(curr_id, new ntxNode(curr_names, curr_links));
  }
  // parse external links
  while (index < lines.length) {
    String[] curr_ext_link = splitTokens(lines[index++], ",");
    print(curr_ext_link);print("\n");
    String from_name = new String(curr_ext_link[0]);
    String from_id = new String(curr_ext_link[1]);
    String to_name = new String(curr_ext_link[2]);
    String to_id = new String(curr_ext_link[3]);
    system.add_external_link(from_name, from_id, to_name, to_id);
  }
} 
