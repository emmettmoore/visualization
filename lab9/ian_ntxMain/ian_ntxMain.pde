import java.util.*;
int EDGE_LENGTH = 200;

String fn = "data2.csv"; 
int NUM_NODES;
//node_info 
int ID = 0;
int NAMES = 1;
int LINKS = 2;
boolean pressed;
boolean already_pressed;
String[] lines;
Integer num_nodes;
Integer num_edges;
float time_step;
import java.util.*;
fdtSystem system;

void setup() {
  size(1200,800);
  background(250,250,250);
  frame.setResizable(true);
  textFont(createFont("Arial",12));
  
  already_pressed = false;
  pressed = false;
  system = new fdtSystem();
  parse_data();
  time_step = 1.0/60.0 * 1.3; // MAYBE NOT?
}

void draw() {
   background(250,250,250);
   system.watch();
   fdtNode temp = fdt_nodes.get(0);
   system.draw_all_edges();
   system.checkHover();
   
   //ntx_system.update();
}
void mousePressed(){
   pressed = true; 
}
void mouseReleased() {
  pressed = false;
  already_pressed = false;
  system.frames_since_equilibrium = 0;
}
void mouseDragged(){
    if (already_pressed){
       draggedNode.posx = mouseX - xOffset;
       draggedNode.posy = mouseY - yOffset;
       draggedNode.adj_matrix.display_border();
       draggedNode.update_adj_matrix();
       //draggedNode.point.C1 = color(0, 100,250);
    } 
}

//new
void parse_data() {
  
  
  String lines[] = loadStrings(fn);
  int index = 0;
  NUM_NODES = Integer.parseInt(lines[index++]);
  ke_threshold = 200.0*(float(NUM_NODES)/10.0); // fiddle with this to find appropriate value 
  coulombK = 1000;
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
    print (curr_id);
    ntxNode temp = new ntxNode(curr_names, curr_links);
    fdt_nodes.put(curr_id, new fdtNode(curr_id, curr_names.size(),temp));

    //ntx_system.init_put(curr_id, new ntxNode(curr_names, curr_links));
  }
  
  while (index < lines.length) {
    String[] curr_ext_link = splitTokens(lines[index++], ",");
    String from_name = new String(curr_ext_link[0]);
    int from_id = Integer.parseInt(curr_ext_link[1]);
    String to_name = new String(curr_ext_link[2]);
    int to_id = Integer.parseInt(curr_ext_link[3]);
    fdtNode currNode = fdt_nodes.get(from_id);
    if(currNode != null){
         currNode.specific_neighbors.add(new node_name_link(from_name,to_id,to_name));
         currNode.neighbors.add(new neighborData(to_id, EDGE_LENGTH));
         fdt_nodes.put(currNode.id, currNode);
    }
  }
} 
