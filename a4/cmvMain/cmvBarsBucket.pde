class Bucket{
 String category;
 int count;
 float posx;
 float posy;
 float w;
 float h;
 color col;
 color origCol;
 int highlight_total;
 Rectangle rect;
  //hashmap:
 //for each distinct IP: # of instances of IP
 HashMap<String, Integer> ips;
 HashMap<String, ArrayList<String>> time_port;
  //another hashmap:
  //      key -- distinct time
 //      value --- arraylist of source ports. contains duplicates
 
 Bucket(String category1, HashMap<String, Integer> ips1, HashMap<String, ArrayList<String>> time_port1, int count1) {
   category = category1;
   ips = ips1;
   time_port = time_port1;
   count = count1;
   highlight_total = 0;
//   col = color(175, 100, 220);

 }
 
 void populateRect() {
   rect = new Rectangle(posx, posy, w, h, category, col);
 }
 void Display() {
   rect.Display();
   if (highlight_total != 0) {
     highlightRect();
     
   }
 }
 
 void highlightRect() {
   float newHeight = (((float)highlight_total) / ((float)count)) * h;
 //  color hlight = color(255, 255, 0);
   Rectangle rect2 = new Rectangle(posx, posy, w, newHeight, "", highlight_color);
   rect2.Display();
 }
 
}



