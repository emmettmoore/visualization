class ntxSystem {
  ArrayList<ntxNode> nodes;
  int curr_index = 0;
  ntxSystem(int num_nodes) {
    nodes = new ArrayList<ntxNode>(num_nodes);
  }
  void init_put(ntxNode curr_node){
    nodes.add(curr_index++, curr_node);
  }
  void update() {
    for (int i=0; i<nodes.size(); i++) {
      ntxNode curr_node = nodes.get(i);
      curr_node.update();
    }
  }
}
