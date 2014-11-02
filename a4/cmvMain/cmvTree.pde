class cmvTree {
    float posx,posy,w,h;
    HashMap<String,cmvTreeNode> Nodes;
    
    cmvTree(String[][] raw_data){
       Nodes = new HashMap<String,cmvTreeNode>();
       int num_nodes = get_num_sources(raw_data, SRC_IP);   // XXX IF you want/need this funciton; its modulah (num_nodes = 19 for this dataset)
       init_nodes(raw_data);
    }
    //set up the data structure that holds nodes
    //so we have a map of source_ips to nodes
    //each node contains all of the edges
    void init_nodes(String[][] raw_data){
       //first create all nodes
       for(int i = 0; i<raw_data.length;i++){
          String [] row = raw_data[i];
          //check to see whether there is a node with the current ip in the hashmap
          cmvTreeNode curr_node;
          String curr_ip = row[SRC_IP];
          if(Nodes.containsKey(curr_ip)){
             curr_node = Nodes.get(curr_ip);
             curr_node = check_all_fields(row,curr_node);
             //mod data
             Nodes.put(curr_ip,curr_node);
          }
          else{
             posx = (float)Math.random() * width;
             posy = (float)Math.random() * height;
             curr_node = new cmvTreeNode(curr_ip,posx,posy,10,color(0,250,100));
             curr_node = check_all_fields(row,curr_node);
             Nodes.put(curr_ip,curr_node);
          } 
       }
       create_all_edges(raw_data);
    }
    void create_all_edges(String[][] raw_data){       
       for(int i = 0; i<raw_data.length;i++){
          String [] row = raw_data[i];
          if(row[SRC_IP] != row[DEST_IP]){
            cmvTreeNode src_node = Nodes.get(row[SRC_IP]);
            cmvTreeNode dest_node = Nodes.get(row[DEST_IP]);
            src_node.add_edge(dest_node);
            dest_node.add_edge(src_node);
            Nodes.put(row[SRC_IP],src_node);
            Nodes.put(row[DEST_IP],dest_node); 
          }
       } 
    }
    cmvTreeNode check_all_fields(String [] curr_element, cmvTreeNode curr_node){
      //protocol      
      if (curr_element[PROTOCOL] == "TCP") { curr_node.tcp = true; }
      else if (curr_element[PROTOCOL] == "UPD") { curr_node.udp = true; }
      
      //operation
      if (curr_element[OP] == "Teardown") { curr_node.teardown = true; }
      else if (curr_element[OP] == "Deny") { curr_node.deny = true; }
      else if (curr_element[OP] == "Built") { curr_node.built = true; }
      
      //priority
      if (curr_element[OP] == "Info") { curr_node.info = true; }
      return curr_node;
    }
    
    int get_num_sources(String[][] raw_data, int field) {
      Set<String> uniqTimes = new TreeSet<String>();
      for (int i=0; i < raw_data.length; i++) {
        uniqTimes.add(raw_data[i][field]);
      }
      return uniqTimes.size();
    }
    
    cmvFilter check_hover() {
      //check if hover is over something in heatmap. if it is, return valuable info, otherwise return null.
      return null;
    }
    void update(cmvFilter curr_filter) {
    
    }
}

