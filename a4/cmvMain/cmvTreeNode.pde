class cmvTreeNode{
   boolean udp, tcp, info, teardown, built, deny;
   HashSet<String> time_stamps;
   HashSet<String> ports;

   float posx;  //center
   float posy;  //center
   String ip;
   color hoverColor;
   color origColor; 
   Circle circle;
   HashMap<String, cmvTreeEdge> neighbor_edges;   
   cmvTreeNode(String ip_address, float x, float y, float radius, color c){
     time_stamps = new HashSet<String>();
     ports = new HashSet<String>();
     posx = x;
     posy = y;
     neighbor_edges = new HashMap<String,cmvTreeEdge>();
     ip = ip_address;
     circle = new Circle(x,y,radius,c);
     
     
   }
   //adds an edge from the current node to the destination
   void add_edge(cmvTreeNode dest){
       cmvTreeEdge curr_edge; 
       if(neighbor_edges.containsKey(dest.ip)){
          curr_edge = neighbor_edges.get(dest.ip);
          curr_edge.increase_width();
          neighbor_edges.put(dest.ip,curr_edge);
       } 
       else{
          neighbor_edges.put(dest.ip,new cmvTreeEdge(ip, dest.ip, posx,posy, dest.posx, dest.posy));
       }
       
   }
}
