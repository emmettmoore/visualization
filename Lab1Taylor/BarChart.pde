
//let the user specify the color of the hovered bar color
// TO DO:
//    - change labels to L1 and L2

int BUFFER = 10;

int NUM_INTERVALS = 10;
class BarChart{
  boolean lineGraph = true;
  Rectangle GraphOutline;
  float range;
  float w, h, posx, posy;
  String[] keys,labels;
  float[] values;
  color barColor;
  color backgroundColor, hoverColor;
  float maxOfValues;
  float minOfValues;
  int startingPoint;                  //TAYLOR -- need to be accessable to multiple functions
  int endingPoint;                    //TAYLOR
  Rectangle[] bars;
  Circle[] circles;
  BarChart(float w1, float h1, float posx1, float posy1, String[] keys1, float[] values1, String[]labels1, color barColor1, color backgroundColor1, color hoverColor1){
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
  void Display(){
    GraphOutline = new Rectangle(w, h, posx,posy, "", backgroundColor);

    drawLabels();
    if(lineGraph){
      drawLineGraph();
    }
    else{
      drawBarGraph();
    }
  }
  
  void drawLineGraph(){
     drawCircles(); 
     drawConnectingLines(); 

     checkCircleHover();
  }
  void drawBarGraph(){
    drawBars();
    checkBarHover();
  }
  void drawCircles(){
     float xInterval = w/keys.length;
     for (int i = 0; i< keys.length; i++){
        float centerX = posx + xInterval * i + xInterval/2;

          float centerY = posy + h - ((values[i]-startingPoint)/range * h);     //TAYLOR
//        float centerY = posy + h - ((values[i]-minOfValues)/range * h);     //ORIGINAL
//        NOTE: the above is wrong because the minOfValues isn't always the lowest interval value
//              for the graph. In the case that all values on the graph are positive, then the lowest
//              interval point on the graph will be 0. So this original definition of
//              centerY did not work in the case that all input values are positive.

        circles[i] = new Circle(centerX, centerY, (float)width/80, barColor);  
     } 
  }
  void drawConnectingLines(){
     for (int i = 0; i<circles.length-1; i++){
        line(circles[i].centerX, circles[i].centerY, circles[i+1].centerX, circles[i+1].centerY);
     } 
  }
  
    void checkBarHover(){
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
  void checkCircleHover(){
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
  void drawLabels(){
    fill(0, 102, 153);
    textAlign(LEFT);
          textSize(12);

    text(labels[1],BUFFER, posy + h/2);
        textAlign(CENTER); 
    text(labels[0],posx + w/2, height - BUFFER);     
   
    labelAxes();
    
  }
  void drawBars(){
    int xInterval = (int)w/keys.length;
    int intervalBuffer = xInterval*1/8;
    Rectangle temp;
     for(int i = 0; i < keys.length; i++){
      float barHeight = ((values[i]-startingPoint)/range * h);     //TAYLOR

      // float barHeight = ((values[i]-minOfValues)/range * h);    //ORIGINAL
        temp = new Rectangle(xInterval-intervalBuffer,barHeight,posx + i*xInterval + intervalBuffer/2, posy + h - barHeight,"",barColor);
        bars[i] = temp;        
     } 
  }

  
  //displays the x value and y value when hovered over
  void displayAdditionalInfo(int index){
        String info = "(" + keys[index] + ", " + Float.toString(values[index]) + ")";
        textAlign(CENTER);
        textSize(17);
        fill(color (0,0,0));
        text(info, mouseX, mouseY-20);
  }
  
  void labelAxes(){                    
    findMaxMin();               
    labelYAxis();                
    labelXAxis();

  }
  
  void labelYAxis(){
//       int startingPoint;        //ORIGINAL
                                   // Taylor Pulled this up to be a global variable instead. 
    if(minOfValues > 0){          
      startingPoint = 0;
    }
    else{
      startingPoint = (int)minOfValues;
    }
//    range = (abs(maxOfValues) + abs(startingPoint));     //ORIGINAL

    if (maxOfValues < 0){                                  //TAYLOR
        endingPoint = 0;                                   //TAYLOR
    }                                                      //TAYLOR
    else {                                                 //TAYLOR
      endingPoint = (int)maxOfValues;                      //TAYLOR
    }                                                      //TAYLOR
    range = endingPoint - startingPoint;                   //TAYLOR    
          //NOTE: creating second for loop to find the endingPoint value
          //      will prevent a range of 0 in the case that all of the input
          //      values are the exact same negative integer. E.g. if they are all -3


//    int interval = (int)range/10;                      //ORIGINAL
  int interval = 1;                                        //TAYLOR
  if (range > 10) {                                        //TAYLOR
    interval = (int)range/10;                              //TAYLOR
  } 
    int currInterval = 0;
//    for(int i = 0; i <= NUM_INTERVALS; i++){           //ORIGINAL
  for (int i = 0; i <= (range/interval); i++) {          //TAYLOR
      currInterval = startingPoint + i*interval;
      String currText = Float.toString(currInterval);
      textSize(12);
//       text(currText, posx - BUFFER, posy + h - h/10*i);  //ORIGINAL
       text(currText, posx - BUFFER, posy + h - h/(range/interval)*i);    //TAYLOR

    }

//    range = currInterval - minOfValues;                 //ORIGINAL
//        I have no idea why this above line was in here.

  }
  void labelXAxis(){
     int interval = (int)w/keys.length;
     for(int i = 0; i < keys.length; i++){
        textAlign(CENTER);
        textSize(10);
        text(keys[i],i*interval + posx, posy+h+BUFFER,interval, posy+h+BUFFER + 1/10*height);
     } 
  }
  
  void findMaxMin(){
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
  void switchState(){
    if(lineGraph){
      lineGraph = false;
    }
    else{
      lineGraph = true;
    }
  }
}
