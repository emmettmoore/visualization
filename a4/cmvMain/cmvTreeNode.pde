class cmvTreeNode{
   boolean udp, tcp, info, teardown, built, deny;
   HashSet<String> categories;
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
     categories = new HashSet<String>();
     posx = x;
     posy = y;
     neighbor_edges = new HashMap<String,cmvTreeEdge>();
     ip = ip_address;
     origColor = c;
     circle = new Circle(x,y,radius,origColor);
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
   //when highlight = true or false
   void Update(boolean highlight){
      if(highlight){
         circle.C1 = hoverColor;
         circle.Display(); 
      }
      else{
         circle.C1 = origColor;
         circle.Display(); 
      }
   }
   boolean check_hover(){
       return circle.within();
   }
}
