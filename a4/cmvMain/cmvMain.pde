String fn = "data.csv"; //"ex2.csv"; 
import java.util.*;
cmvSystem system;

void setup() {
  size(1200,800);
  background(250,250,250);
  frame.setResizable(true);
  textFont(createFont("Arial",12));
  
  already_pressed = false;
  pressed = false;
  
  system = new fdtSystem();
  parse_data();
  time_step = 1.0/60.0 * 1.3; // MAYBE NOT?
}

void draw() {
   background(250,250,250);
   system.watch();
   system.draw_all_edges();
   system.checkHover();

}
void mousePressed(){
   pressed = true; 
}
void mouseReleased() {
  pressed = false;
  already_pressed = false;
  system.frames_since_equilibrium = 0;
}
void mouseDragged(){
    if (already_pressed){
       draggedNode.posx = mouseX - xOffset;
       draggedNode.posy = mouseY - yOffset; 
       draggedNode.point.C1 = color(0, 100,250);
    } 
}

void parse_data() {
  lines = loadStrings(fn);
  NUM_NODES = Integer.parseInt(lines[0]);
  num_edges = Integer.parseInt(lines[NUM_NODES + 1]);
  ke_threshold = 200.0*(float(NUM_NODES)/10.0); // fiddle with this to find appropriate value 
  coulombK = 1000.0;
  int index = 1;
  for (int i=0; i<NUM_NODES; i++) {
    String[] temp = splitTokens(lines[index], ",");
    Integer curr_id = Integer.parseInt(temp[0]); 
    Integer curr_mass = Integer.parseInt(temp[1]);
    fdt_nodes.put(curr_id, new fdtNode(curr_id, curr_mass));
    index++;
  }
  index++;
  for (int i=0; i<(2 * num_edges); i++) {
    String[] temp = splitTokens(lines[index], ",");
    Integer from = Integer.parseInt(temp[(i % 2)]); 
    Integer to = Integer.parseInt(temp[1 - (i % 2)]);
    Integer len = Integer.parseInt(temp[2]);
    fdtNode currNode = fdt_nodes.get(from);
    if(currNode != null){
         currNode.neighbors.add(new neighborData(to, len));
         fdt_nodes.put(currNode.id, currNode);
    }
    if (i % 2 == 1) { index++; } //increment every other line
  }
}





