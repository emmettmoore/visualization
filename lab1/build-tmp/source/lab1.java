import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class lab1 extends PApplet {

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

public void setup() {
  lines = loadStrings("lab1-data.csv");
  keys = new String[lines.length-1];
  values = new float[lines.length-1];
  parse_data();
  
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  frame.setResizable(true);
  
  BarLineButton = new Rectangle(width/10,height/10,width - 9/10*width,9/10*height, "switch", color(100,100,20));
  chart = new BarChart(width*7/10, height * 7/10, width * 2/10, height * 1/10, keys,values,labels, color(255,255,105), color(250,250,250), color(116,250,255));
}

public void parse_data() {
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


public void draw() {
  size(width, height);
  background(250,250,250);
  redrawChart();
  chart.Display();
  redrawButton();
}

public void mouseClicked() {
  if (BarLineButton.within()) {
    chart.switchState();
  }
}

public void redrawChart(){
   chart.w = width*7/10;
   chart.h = height*7/10;
   chart.posx = width* 2/10;
   chart.posy = height*1/10;
   chart.Display();
}
public void redrawButton(){
  BarLineButton.draw_me(width/10,height/10,width - width/10, 0, "switch", color(100,100,20));

}

//doesn't work with negatives as of now
//let the user specify the color of the hovered bar color

int BUFFER = 10;

int NUM_INTERVALS = 10;
class BarChart{
  boolean lineGraph = true;
  Rectangle GraphOutline;
  float range;
  float w, h, posx, posy;
  String[] keys,labels;
  float[] values;
  int barColor;
  int backgroundColor, hoverColor;
  float maxOfValues;
  float minOfValues;
  Rectangle[] bars;
  Circle[] circles;
  BarChart(float w1, float h1, float posx1, float posy1, String[] keys1, float[] values1, String[]labels1, int barColor1, int backgroundColor1, int hoverColor1){
    //data initialization; 
    w = w1;
     h = h1;
     posx = posx1;
     posy = posy1;
     keys = keys1;
     labels = labels1;
     values = values1;
     barColor = barColor1;
     backgroundColor = backgroundColor1;
     hoverColor = hoverColor1;
     bars = new Rectangle[keys.length];
     circles = new Circle[keys.length];
     Display();
  }
  
  //where everything is called - basically this class' draw function
  public void Display(){
    GraphOutline = new Rectangle(w, h, posx,posy, "", backgroundColor);
    drawLabels();
        
    if(lineGraph){
      drawLineGraph();
    }
    else{
      drawBarGraph();
    }
  }
  
  public void drawLineGraph(){
     drawCircles(); 
     drawConnectingLines(); 

     checkCircleHover();
  }
  public void drawBarGraph(){
    drawBars();
    checkBarHover();
  }
  public void drawCircles(){
     float xInterval = w/keys.length;
     for (int i = 0; i< keys.length; i++){
        float centerX = posx + xInterval * i + xInterval/2;
        float centerY = posy + h - ((values[i]-minOfValues)/range * h); 
        circles[i] = new Circle(centerX, centerY, (float)width/80, barColor);  
     } 
  }
  public void drawConnectingLines(){
     for (int i = 0; i<circles.length-1; i++){
        line(circles[i].centerX, circles[i].centerY, circles[i+1].centerX, circles[i+1].centerY);
     } 
  }
  
    public void checkBarHover(){
     int toolTipIndex = -1;
     for(int i = 0; i<keys.length;i++){
        if(bars[i].within()){
           bars[i].C1 = hoverColor;
           bars[i].Display();
           toolTipIndex = i;
        }
        else{
           bars[i].C1 = barColor;
            bars[i].Display();       
        }
     } 
     if(toolTipIndex!=-1){
       displayAdditionalInfo(toolTipIndex);
     }
  }
  public void checkCircleHover(){
    int toolTipIndex = -1;
     for(int i = 0; i<keys.length; i++){
        if(circles[i].within()){
           circles[i].C1 = hoverColor;
           circles[i].Display();
           toolTipIndex = i;
        }
        else{
          circles[i].C1 = barColor;
          circles[i].Display();
        }

     } 
     if(toolTipIndex!=-1){
           displayAdditionalInfo(toolTipIndex);
     }
  }
  public void drawLabels(){
    fill(0, 102, 153);
    textAlign(LEFT);
          textSize(12);

    text(labels[1],BUFFER, posy + h/2);
        textAlign(CENTER); 
    text(labels[0],posx + w/2, height - BUFFER);
    labelAxes();
    
  }
  public void drawBars(){
    int xInterval = (int)w/keys.length;
    int intervalBuffer = xInterval*1/8;
    Rectangle temp;
     for(int i = 0; i < keys.length; i++){
       float barHeight = ((values[i]-minOfValues)/range * h);
        temp = new Rectangle(xInterval-intervalBuffer,barHeight,posx + i*xInterval + intervalBuffer/2, posy + h - barHeight,"",barColor);
        bars[i] = temp;        
     } 
  }

  
  //displays the x value and y value when hovered over
  public void displayAdditionalInfo(int index){
        String info = "(" + keys[index] + ", " + Float.toString(values[index]) + ")";
        textAlign(CENTER);
        textSize(17);
        fill(color (0,0,0));
        text(info, mouseX, mouseY-20);
  }
  
  public void labelAxes(){
    findMaxMin(); 
    labelYAxis();
    labelXAxis();
  }
  
  public void labelYAxis(){
       int startingPoint;
    if(minOfValues > 0){
      startingPoint = 0;
    }
    else{
      startingPoint = (int)minOfValues;
    }
    range = (abs(maxOfValues) + abs(startingPoint));
    int interval = (int)range/10;
    int currInterval = 0;
    for(int i = 0; i <= NUM_INTERVALS; i++){
      currInterval = startingPoint + i*interval;
      String currText = Float.toString(currInterval);
      textSize(12);
       text(currText, posx - BUFFER, posy + h - h/10*i);
    }
    range = currInterval - minOfValues; 
  }
  public void labelXAxis(){
     int interval = (int)w/keys.length;
     for(int i = 0; i < keys.length; i++){
        textAlign(CENTER);
        textSize(10);
        text(keys[i],i*interval + posx, posy+h+BUFFER,interval, posy+h+BUFFER + 1/10*height);
     } 
  }
  
  public void findMaxMin(){
    maxOfValues = values[0];
    minOfValues = values[0];
    for(int i = 1; i<values.length;i++){
       if(maxOfValues < values[i]){
         maxOfValues = values[i]; 
       }
       if(minOfValues > values[i]){
         minOfValues = values[i];
       }
    }
  }
  
  //switches to a linegraph if currently bargraph and vice versa
  public void switchState(){
    if(lineGraph){
      lineGraph = false;
    }
    else{
      lineGraph = true;
    }
  }
}
class Circle{
   float centerX;
   float centerY;
   float radius;
   int C1;
    Circle(float centerX1, float centerY1, float radius1, int originalColor1){
        centerX = centerX1;
        centerY = centerY1;
        radius = radius1;
        C1 = originalColor1;
        Display();
    }
    public void Display(){
        fill(C1);
        ellipse(centerX, centerY, radius*2,radius*2);
    }
    public boolean within(){
      double squareX = Math.pow(mouseX - centerX,2);
      double squareY = Math.pow(mouseY - centerY,2);
       if(squareX + squareY <= Math.pow(radius,2)){
          return true;   
       } 
       return false;
    }   
}

class Rectangle {
  float orig_w;
  float orig_h;
  float curr_w;
  float curr_h;  
  float rect_posx, rect_posy; //top left corner
  String T1;
  int C1;
  Rectangle(float w, float h, float posx, float posy,String txt, int coluh) {
    draw_me(w,h,posx,posy,txt,coluh);
  }
  
  public boolean within() {
    if ((rect_posx <= mouseX) && (mouseX <= rect_posx + curr_w)) {
      if ((rect_posy <= mouseY) && (mouseY <= rect_posy + curr_h)) {
        return true;
      }
    }
    return false;
  }
  public void draw_me(float w, float h, float posx, float posy,String txt, int coluh){
    orig_w = w;
    orig_h = h;
    curr_w = orig_w;
    curr_h = orig_h;        
    rect_posx = posx;
    rect_posy = posy;
    T1 = txt;
    C1 = coluh;
     fill(C1);
     rect(rect_posx, rect_posy, curr_w, curr_h);
     fill(50);
     textAlign(CENTER);
     text(T1, rect_posx + curr_w /2 , rect_posy + curr_h/2);
  }
  public void Display(){
     fill(C1);
     rect(rect_posx, rect_posy, curr_w, curr_h);
     fill(50);
     textAlign(CENTER);
     text(T1, rect_posx + curr_w /2 , rect_posy + curr_h/2);
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "lab1" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
