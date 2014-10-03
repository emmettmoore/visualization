int SCREEN_WIDTH = 900;
int SCREEN_HEIGHT = 500;
String[] lines;
String[] keys;
float[] values;
String[] labels;
Rectangle BarLineButton;
Rectangle GraphOutline;
BarChart chart;

animInterface buttonInterface;

void setup(){
  size(600,600);
  background(250,250,250);
  frame.setResizable(true);
  drawGraphs();
  buttonInterface = new animInterface(); 
}

void draw(){
  background(250,250,250);
  size(width, height);
  buttonInterface.update();
  redrawChart();
  chart.Display();
}
void mouseClicked(){
  buttonInterface.checkButtons(); 

}

void drawGraphs(){
  lines = loadStrings("lab1-data.csv");
  keys = new String[lines.length-1];
  values = new float[lines.length-1];
  parse_data();
  
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  frame.setResizable(true);
  chart = new BarChart(width*7/10, height * 6/10, width * 1/10, height * 1/10, keys,values,labels, color(255,255,105), color(250,250,250), color(116,250,255));
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
void redrawChart(){
   chart.w = width*6/10;
   chart.h = height*6/10;
   chart.posx = width* 2/10;
   chart.posy = height*1/10;
   chart.Display();
}

