//doesn't work with negatives as of now
//let the user specify the color of the hovered bar color
int NUM_INTERVALS = 10;
class ChartController{
  boolean lineGraph = false;
    boolean pieGraph = true;  
  boolean barGraph = false;   
  Rectangle GraphOutline;
  float range;
  float w, h, posx, posy;
  String[] keys,labels;
  float[] values;
  color barColor;
  color backgroundColor, hoverColor;
  float maxOfValues;
  float minOfValues;
  Rectangle[] bars;
  Circle[] circles;
  ChartController(float posx1, float posy1,float w1, float h1, String[] keys1, float[] values1, String[]labels1, color barColor1, color backgroundColor1, color hoverColor1){
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
    GraphOutline = new Rectangle(posx,posy,w, h,  "", backgroundColor);
    drawLabels();
    
    if (lineGraph) {              
      drawLineGraph();
    } else if (barGraph) {
      drawBarGraph();
    } else {
      drawPieGraph();
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
  
    void drawPieGraph() {
    float[] angles = new float[values.length];
    float sum = 0;
    //calculate the sum of the values:
    for (int i = 0; i < values.length; i++) {
      sum = sum + values[i];
    }
    //populate the angles array:
    for (int i = 0; i < values.length; i++) {
      angles[i] = ((values[i]/ sum) * 360);
    }
    float smallerEdge = height;
    if (width < height) {
      smallerEdge = width;
    }
    drawPie(smallerEdge - (smallerEdge/2), angles);
  }
  

  void drawPie(float diameter, float[] angles) {
    float lastAngle = 0;
    for (int i = 0; i < angles.length; i++) {
      float shade = map(i, 0, angles.length, 0, 255);      //converting it to a shade of gray
      fill(shade);
      arc(GraphOutline.posx + GraphOutline.w/2, GraphOutline.posy + GraphOutline.h/2, diameter, diameter, lastAngle, lastAngle+radians(angles[i]));
      lastAngle += radians(angles[i]);
    }
  }
  
  //draws the circles on the points of the graph
  void drawCircles(){
     float xInterval = w/keys.length;
     for (int i = 0; i< keys.length; i++){
        float centerX = posx + xInterval * i + xInterval/2;
        float centerY = posy + h - ((values[i]-minOfValues)/range * h); 
        circles[i] = new Circle(centerX, centerY, (float)width/80, barColor);  
     } 
  }
  
  //connects the circles in the linechart
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
    //textAlign(LEFT);
    //textSize(12);

    //text(labels[1],BUFFER, posy + h/2);
        //textAlign(CENTER); 
    //text(labels[0],posx + w/2, height - BUFFER);
    labelAxes();
    
  }
  void drawBars(){
    int xInterval = (int)w/keys.length;
    int intervalBuffer = xInterval*1/8;
    Rectangle temp;
     for(int i = 0; i < keys.length; i++){
       float barHeight = ((values[i]-minOfValues)/range * h);
        temp = new Rectangle(posx + i*xInterval + intervalBuffer/2, posy + h - barHeight,xInterval-intervalBuffer,barHeight,"",barColor);
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
  // Sequence: linegraph -> bargraph -> piegraph -> linegraph */
  void switchState(){
    if(lineGraph){
      lineGraph = false;
      barGraph = true;
    }
    else if (pieGraph) {
      pieGraph = false;
      lineGraph = true;
    }
    else {
      barGraph = false;
      pieGraph = true;
    }
  }
}
