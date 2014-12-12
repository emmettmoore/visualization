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
int BUFFER = 20;

class freq_graph{
 float [] timestamps;
 float posx,posy,w,h;
 float duration = 30;
 boolean playing;
 float time_interval;
 int index;
 float curr_time;
 float momentum_factor; //comes into play when doing heatmap style stuff
 
 freq_graph(float [] timestamps1, float x,float y,float w1,float h1){
     playing = false;
     index = 0;
     curr_time = 0;
    posx = x;
    posy = y;
    w = w1;
    h = h1;
    timestamps = timestamps1;
    Rectangle rect = new Rectangle(posx,posy,w,h,"", color(250,0,0));
    print (timestamps[timestamps.length-1]);
    time_interval = (timestamps[timestamps.length-1]/60)/ duration;
    print(time_interval);
 } 
  void update(){
    if (playing && index < timestamps.length){
       print(timestamps[index] + "\n");
       if (timestamps[index] < curr_time){
          index++;
          print("fuck");
       } 
       curr_time+=time_interval;
    }
  }
  void Play(){
     playing = true; 
  }
}

class Rectangle {
  float posx;
  float posy;
  float w;
  float h;
  float origH, origW, origPosx, origPosy;
  String T1;
  color C1;
  Rectangle(float posx1, float posy1, float w1, float h1, String txt, color color1) {
    origH = h1;
    origW = w1;
    origPosx = posx1;
    origPosy = posy1;
    update( posx1,  posy1,  w1,  h1, txt, color1);
    
  }
  
  boolean within() {
    if ((posx <= mouseX) && (mouseX <= posx + w)) {
      if ((posy <= mouseY) && (mouseY <= posy + h)) {
        return true;
      }
    }
    return false;
  }
  void update(float posx1, float posy1, float w1, float h1, String txt, color color1){
    posx = posx1;
    posy = posy1;
    w = w1;
    h = h1;
    T1 = txt;
    C1 = color1;
    fill(color1); 
    rect(posx,posy,w,h);
    fill(color(0,0,0));
    textSize(7);
    textAlign(CENTER,CENTER);
    text(T1, posx + w /2 , posy + h/2);
  }
  void Display(){
      fill(C1);
      rect(posx,posy,w,h);
      fill(color(0,0,0));
      textSize(7);
      textAlign(CENTER, CENTER);
      text(T1, posx + w /2 , posy + h/2);
  }
}

