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
   cmvTreeNode(String ip_address, float x, float y, float radius, color c1, color c2){
     time_stamps = new HashSet<String>();
     ports = new HashSet<String>();
     categories = new HashSet<String>();
     posx = x;
     posy = y;
     neighbor_edges = new HashMap<String,cmvTreeEdge>();
     ip = ip_address;
     origColor = c1;
     hoverColor = c2;
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
          neighbor_edges.put(dest.ip,new cmvTreeEdge(ip, dest.ip, posx,posy, dest.posx, dest.posy,hoverColor,origColor));
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
       boolean within = circle.within();
       return within;
   }
   void draw_neighbor_edges(boolean highlight){
    Set set = neighbor_edges.entrySet();
    Iterator i = set.iterator();
    // Display elements
    while(i.hasNext()) {
      Map.Entry temp = (Map.Entry)i.next();
      cmvTreeEdge curr_edge = (cmvTreeEdge)temp.getValue();
      curr_edge.Update();
    }
    i = set.iterator();
    // Display elements
    while(i.hasNext()) {
      Map.Entry temp = (Map.Entry)i.next();
      cmvTreeEdge curr_edge = (cmvTreeEdge)temp.getValue();
      if(highlight){
        curr_edge.hover_color();
      }
    }   
  }
  void draw_tooltip(){
            textAlign(CENTER);
         textSize(20);
         String str = "IP: " + ip; 
         float x1,y1,wt,ht;
         x1 = mouseX-80;
         y1 = mouseY-40;
         wt = 160;
         ht = 30;
         fill(250,250,250);
         rect(x1,y1,wt,ht);
         fill(0,0,0);
         text(str, x1,y1,wt,ht); 
  }
}
