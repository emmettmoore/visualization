String fn = "ex1.csv";
String[] lines;
Integer num_nodes;
Integer num_edges;
HashMap<Integer,fdtNode> fdt_nodes;
import java.util.*;

void setup() {
  size(600,600);
  background(250,250,250);
  frame.setResizable(true);
  parse_data();
  connectNodes();
  testing();
}

void draw() {
  
}




void parse_data() {
  lines = loadStrings(fn);
  num_nodes = Integer.parseInt(lines[0]);
  num_edges = Integer.parseInt(lines[num_nodes + 1]);
  fdt_nodes = new HashMap<Integer,fdtNode>();
  
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

void connectNodes(){
    Set set = fdt_nodes.entrySet();
    Iterator i = set.iterator();
    // Display elements
    while(i.hasNext()) {
      Map.Entry temp = (Map.Entry)i.next();
      print("--------------------------- " + temp.getKey() + "\n"); 
      fdtNode currNode = (fdtNode)temp.getValue();
      connectToNeighbors(currNode);
    }
}

  void connectToNeighbors(fdtNode currNode){
     for(int i = 0; i<currNode.neighbors.size();i++){
        neighborData neighbor = currNode.neighbors.get(i);
        fdtNode neighborNode = (fdtNode)fdt_nodes.get(neighbor.id);
        line(currNode.posx, currNode.posy, neighborNode.posx,neighborNode.posy);
     }
  }

void testing(){
  
    Set set = fdt_nodes.entrySet();
    Iterator i = set.iterator();
    // Display elements
    while(i.hasNext()) {
      Map.Entry temp = (Map.Entry)i.next();
      print("--------------------------- " + temp.getKey() + "\n"); 
      fdtNode bla = (fdtNode)temp.getValue();
      bla.printNeighbors();  
 }   
}

