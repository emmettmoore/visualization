// Rectangle class uses these.... this is fugly
int SCREEN_WIDTH = 900;
int SCREEN_HEIGHT = 500;

String[] lines;
String[] keys;
float[] values;
String[] labels;

Rectangle BarLineButton;
Rectangle GraphOutline;
BarChart chart;

void setup() {
  lines = loadStrings("lab1-data.csv");
  keys = new String[lines.length-1];
  values = new float[lines.length-1];
  parse_data();
  
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  frame.setResizable(true);
  
  BarLineButton = new Rectangle(width/10,height/10,width - 9/10*width,9/10*height, "switch", color(100,100,20));
  chart = new BarChart(width*7/10, height * 7/10, width * 2/10, height * 1/10, keys,values,labels, color(255,255,105), color(250,250,250), color(116,250,255));
}

void parse_data() {
  //sloppy but sets the maxVal super low so that we can't
  //get name/number
  labels = splitTokens(lines[0], ", ");
  //get that data boy
  for (int i=1; i < lines.length; i++) {
    String[] temp = splitTokens(lines[i], ", ");
    keys[i-1] = temp[0];
    values[i-1] = Float.parseFloat(temp[1]);
  }  
}


void draw() {
  size(width, height);
  background(250,250,250);
  redrawChart();
  chart.Display();
  redrawButton();
}

void mouseClicked() {
  if (BarLineButton.within()) {
    chart.switchState();
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
  BarLineButton.update(width - width/10, 0,width/10,height/10, "switch", color(100,100,20));

}

