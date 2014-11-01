class cmvTreeNode{
   float posx;  //center
   float posy;  //center
   String ip;
   color hoverColor;
   color origColor; 
   HashMap<String, cmvTreeEdge> neighbor_edges;   
   cmvTreeNode(String ip_address){
     neighbor_edges = new HashMap<String,cmvTreeEdge>();
     
   }
}
