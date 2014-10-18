String fn = "ex1.csv";
String[] lines;
Integer num_nodes;
Integer num_edges;
import java.util.*;
fdtSystem system;

void setup() {
  size(600,600);
  background(250,250,250);
  frame.setResizable(true);
  system = new fdtSystem();
  parse_data();
}

void draw() {
   system.watch();
}

void parse_data() {
  lines = loadStrings(fn);
  num_nodes = Integer.parseInt(lines[0]);
  num_edges = Integer.parseInt(lines[num_nodes + 1]);
  
  int index = 1;
  for (int i=0; i<num_nodes; i++) {
    String[] temp = splitTokens(lines[index], ",");
    Integer curr_id = Integer.parseInt(temp[0]); 
    Integer curr_mass = Integer.parseInt(temp[1]);
    fdt_nodes.put(curr_id, new fdtNode(curr_id, curr_mass));
    index++;
  }
  index++;
  for (int i=0; i<(2 * num_edges); i++) {
    String[] temp = splitTokens(lines[index], ",");
    Integer from = Integer.parseInt(temp[(i % 2)]); 
    Integer to = Integer.parseInt(temp[1 - (i % 2)]);
    Integer len = Integer.parseInt(temp[2]);
    fdtNode currNode = fdt_nodes.get(from);
    if(currNode != null){
         currNode.neighbors.add(new neighborData(to, len));
         fdt_nodes.put(currNode.id, currNode);
    }
    if (i % 2 == 1) { index++; } //increment every other line
  }
}




