class cmvTree {
    float posx,posy,w,h;
    HashMap<String,cmvTreeNode> Nodes;
    cmvTree(String[][] raw_data, float posx_,float posy_, float w_, float h_){
       posx = posx_;
       posy = posy_;
       w = w_;
       h = h_;
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
             float x = posx + (float)Math.random() * w;
             float y = posy + (float)Math.random() * h;
             curr_node = new cmvTreeNode(curr_ip,x,y,10,color(0,250,100),highlight_color);
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
      if (curr_element[PROTOCOL].equals("TCP")) { curr_node.categories.add("tcp"); }
      else if (curr_element[PROTOCOL].equals("UDP")) { curr_node.categories.add("udp"); }
      
      //operation
      if (curr_element[OP].equals("Teardown")) { curr_node.categories.add("teardown");}
      else if (curr_element[OP].equals("Deny")) { curr_node.categories.add("deny"); }
      else if (curr_element[OP].equals("Built")) { curr_node.categories.add("built"); }
      
      //priority
      if (curr_element[SYSLOG].equals( "Info")) { curr_node.categories.add("info"); }
      //port range and time stamp
      curr_node.time_stamps.add(curr_element[TIME_STAMP]);
      curr_node.ports.add(curr_element[DEST_PORT]);
      curr_node.ports.add(curr_element[SRC_PORT]);
      
      return curr_node;
    }
    
    int get_num_sources(String[][] raw_data, int field) {
      Set<String> uniqTimes = new TreeSet<String>();
      for (int i=0; i < raw_data.length; i++) {
        uniqTimes.add(raw_data[i][field]);
      }
      return uniqTimes.size();
    }
    void update(cmvFilter curr_filter) {
      fill(250); 
      stroke(250);
      rect(0,0,0.75*width,0.68*height);
      stroke(0);
       draw_all_edges();
       Iterator it = Nodes.entrySet().iterator();
       while (it.hasNext()) {
         Map.Entry pairs = (Map.Entry)it.next();
         cmvTreeNode curr_node = (cmvTreeNode)pairs.getValue();
         apply_filter(curr_node, curr_filter);
       }
       check_hover();
    }
    cmvFilter check_hover() {
      //check if hover is over something in heatmap. if it is, return valuable info, otherwise return null.
       Iterator it = Nodes.entrySet().iterator();
       boolean highlight;
       while (it.hasNext()) {
         highlight = false;
         Map.Entry pairs = (Map.Entry)it.next();
         cmvTreeNode curr_node = (cmvTreeNode)pairs.getValue();
         highlight = curr_node.check_hover();
         if(highlight){
           curr_node.Update(highlight);
           curr_node.draw_neighbor_edges(highlight);
           return new cmvFilter(NETWORK,"",curr_node.ip,"",""); 
         }
       }
      return null;
    }

    void apply_filter(cmvTreeNode curr_node, cmvFilter f){
        boolean highlight = false;
        if(f!=null){      
          //if filter matches with this node, color different color
          if (f.magic_chart == CATEGORY){
            if (curr_node.categories.contains(f.category)){
               highlight = true;
            }
          }
          else if (f.magic_chart == HEAT){
             if(curr_node.time_stamps.contains(f.time_range) && curr_node.ports.contains(f.port_range)){
                highlight = true;
             }
          }
        }
        curr_node.Update(highlight); 
    }

  void draw_all_edges(){
    Set set = Nodes.entrySet();
    Iterator i = set.iterator();
    // Display elements
    while(i.hasNext()) {
      Map.Entry temp = (Map.Entry)i.next();
      cmvTreeNode curr_node = (cmvTreeNode)temp.getValue();
      curr_node.draw_neighbor_edges(false); //0 means don't highlight
    }
  }
}
