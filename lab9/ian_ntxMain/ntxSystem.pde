class ntxSystem {
  int frames_since_equilibrium;
  ArrayList<ntxNode> nodes;
  ntxSystem(int num_nodes) {
    nodes = new ArrayList<ntxNode>(num_nodes);
  }
  void init_put(Integer curr_id, ntxNode curr_node){
    nodes.add(curr_id, curr_node);
  }
  void update() {
    for (int i=0; i<nodes.size(); i++) {
      ntxNode curr_node = nodes.get(i);
      
      //this draws a new node - important
      curr_node.update();
    }
  }
  void add_external_link(String from_name, String from_id, String to_name, String to_id){
    ntxNode from_node = nodes.get(Integer.parseInt(from_id));
    from_node.add_external_link(from_name, Integer.parseInt(to_id), to_name);
    //COMMENTING this out because it will probs be cleaner to do it one way only.
    //ntxNode to_node = nodes.get(Integer.parseInt(to_id));
    //to_node.add_external_link(to_name, from_id, from_name);
  }
}
