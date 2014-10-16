String fn = "ex1.csv";
String[] lines;
Integer num_nodes;
Integer num_edges;
ArrayList<fdtNode> fdt_nodes;


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
  fdt_nodes = new ArrayList<fdtNode>();
  
  int index = 1;
  for (int i=0; i<num_nodes; i++) {
    String[] temp = splitTokens(lines[index], ",");
    Integer curr_id = Integer.parseInt(temp[0]); 
    Integer curr_mass = Integer.parseInt(temp[1]);
    fdt_nodes.add(new fdtNode(curr_id, curr_mass));
    index++;
  }
  index++;
  for (int i=0; i<(2 * num_edges); i++) {
    String[] temp = splitTokens(lines[index], ",");
    Integer from = Integer.parseInt(temp[(i % 2)]); 
    Integer to = Integer.parseInt(temp[1 - (i % 2)]);
    Integer len = Integer.parseInt(temp[2]);
    for (int j=0; j<fdt_nodes.size(); j++) {
      fdtNode this_node = (fdtNode) fdt_nodes.get(j);
      if (from == this_node.id) {
        this_node.neighbors.add(new neighborData(to, len, this_node.posx, this_node.posy));
        fdt_nodes.set(j, this_node);
        break;
      }
    }
    if (i % 2 == 1) { index++; } //increment every other line
  }
}

void connectNodes(){
   for(int i = 0; i<fdt_nodes.size();i++){
      fdtNode temp = fdt_nodes.get(i);
          for(int j = 0; j<temp.neighbors.size();j++){
          }
      }
}

void testing(){
   for(int i = 0; i<fdt_nodes.size();i++){
      fdtNode temp = fdt_nodes.get(i);
      print("--------------------------- " + temp.id + "\n"); 

      temp.printNeighbors();
   } 
  
}
