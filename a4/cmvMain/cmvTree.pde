class cmvTree {
    float posx,posy,w,h;
    HashMap<String,cmvTreeNode> Nodes;
    
    cmvTree(String[][] data){
       Nodes = new HashMap<String,cmvTreeNode>();
       init_nodes(data);
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
}

