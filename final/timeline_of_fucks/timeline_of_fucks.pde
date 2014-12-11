import java.util.*;

String fi = "wowFuckInstances.csv";
String rf = "recordedFucks.csv";

String [] fuck_strings;
float [] fuck_timestamps;
freq_graph bot;
void setup(){
 
 size(800,600);
 parse_data();
 setGradient(0,0,width,.75*height, color(0,0,0), color(250,250,250));
 bot = new freq_graph(fuck_timestamps, 0.0,.75*height, (float)width, .25*height); 
 bot.Play();
  
}
void draw(){
  bot.update();
}

void parse_data(){
  
  Table table = loadTable(fi);
  int index = 0;
  fuck_timestamps = new float[table.getRowCount()];
  for (TableRow row : table.rows()) {
      fuck_timestamps[index] = Float.parseFloat(row.getString(0));
      index++;
  }
  table = loadTable (rf);
  index = 0;
  fuck_strings = new String[table.getRowCount()];
  for (TableRow row : table.rows()) {
      fuck_strings[index] = row.getString(0);
      index++;
  }
}


void setGradient(int x, int y, float w, float h, color c1, color c2){
  // calculate differences between color components 
  float deltaR = red(c2)-red(c1);
  float deltaG = green(c2)-green(c1);
  float deltaB = blue(c2)-blue(c1);
    /*nested for loops set pixels
     in a basic table structure */
    for (int i=x; i<=(x+w); i++){
      // row
      for (int j = y; j<=(y+h); j++){
        color c = color(
        (red(c1)+(j-y)*(deltaR/h)),
        (green(c1)+(j-y)*(deltaG/h)),
        (blue(c1)+(j-y)*(deltaB/h)) 
          );
        set(i, j, c);
      }
    }  
  }
