String fn = "ex1.csv";
String[] lines;
Integer num_nodes;
Integer num_edges;
ArrayList<fdtNode> fdt_nodes;


void setup() {
  lines = loadStrings(fn);
  num_nodes = Integer.parseInt(lines[0]);
  num_edges = Integer.parseInt(lines[num_nodes + 1]);
  fdt_nodes = new ArrayList<fdtNode>();
  parse_data();
  testing();
}

void draw() {
  
}

void parse_data() {
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
        this_node.neighbors.add(new neighborData(to, len));
        fdt_nodes.set(j, this_node);
        break;
      }
    }
    if (i % 2 == 1) { index++; } //increment every other line
  }
}


void testing(){
   for(int i = 0; i<fdt_nodes.size();i++){
      fdtNode temp = fdt_nodes.get(i);
      print("--------------------------- " + temp.id + "\n"); 

      temp.printNeighbors();
   } 
  
}
