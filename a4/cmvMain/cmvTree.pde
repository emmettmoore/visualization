class cmvTree {
    float posx,posy,w,h;
    HashMap<String,cmvTreeNode> Nodes;
    
    cmvTree(String[][] raw_data){
       Nodes = new HashMap<String,cmvTreeNode>();
       int num_nodes = get_num_sources(raw_data, PROTOCOL);   // XXX IF you want/need this funciton; its modulah (num_nodes = 19 for this dataset)
       init_nodes(raw_data);
    }
    void init_nodes(String[][] data){
       for(int i = 0; i<data.length;i++){
          String [] row = data[i];
          //check to see whether there is a node with the current ip in the hashmap
          cmvTreeNode curr_node;
          if(Nodes.containsKey(row[SRC_IP])){
             curr_node = Nodes.get(row[SRC_IP]);
             //modify curr_node
          }
          else{
             curr_node = new cmvTreeNode("");
          } 
       }          
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

