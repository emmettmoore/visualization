// Rectangle class uses these.... this is fugly
int SCREEN_WIDTH = 400;
int SCREEN_HEIGHT = 300;

String[] lines;
String[] keys;
float[] values;
String[] labels;

Rectangle BarLineButton;
Rectangle GraphOutline;
BarChart chart;

void setup() {
  lines = loadStrings("lab1-data.csv");
  keys = new String[lines.length];
  values = new float[lines.length];
  parse_data();
  
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  frame.setResizable(true);
  
  BarLineButton = new Rectangle(width/10,height/10,width - 9/10*width,9/10*height, "switch", color(100,100,20));
  chart = new BarChart(width*7/10, height * 7/10, width * 2/10, height * 1/10, keys,values,labels, color(250,250,250), color(250,250,250));
}

void parse_data() {
  //sloppy but sets the maxVal super low so that we can't
  //get name/number
  labels = splitTokens(lines[0], ", ");
  //get that data boy
  for (int i=1; i < lines.length; i++) {
    String[] temp = splitTokens(lines[i], ", ");
    keys[i] = temp[0];
    values[i] = Float.parseFloat(temp[1]);
  }  
}


void draw() {
  size(width, height);
  redrawChart();
  chart.Display();
  redrawButton();
}

void mouseClicked() {
  if (BarLineButton.within()) {
    print("switch state now");
  }
}

void redrawChart(){
   chart.w = width*7/10;
   chart.h = height*7/10;
   chart.posx = width* 2/10;
   chart.posy = height*1/10;
   chart.Display();
}
void redrawButton(){
  BarLineButton.draw_me(width/10,height/10,width - width/10, 0, "switch", color(100,100,20));

}

