class cmvTreeNode{
   float posx;  //center
   float posy;  //center
   String IP;
   color hoverColor;
   color origColor; 
   HashMap<String, cmvTreeEdge> neighbor_edges;   
   cmvTreeNode(){
     neighbor_edges = new HashMap<String,cmvTreeEdge>();
     
   }
}
