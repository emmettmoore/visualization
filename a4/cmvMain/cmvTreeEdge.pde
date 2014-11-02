class cmvTreeEdge{
   float thickness;
   float x1,y1,x2,y2; 
   String nodeID1;
   String nodeID2;
   color hoverColor;
   color origColor;
   float edge_width;  

   cmvTreeEdge(String a,String b, float x1_, float y1_, float x2_, float y2_){
     nodeID1 = a;
     nodeID2 = b;
     x1 = x1_;
     x2 = x2_;
     y1 = y1_;
     y2 = y2_;
     edge_width = 0;
     increase_width();
   }   
   void increase_width(){
     edge_width += .01;
     strokeWeight(edge_width);  
     line(x1,y1,x2,y2);
   }
}
