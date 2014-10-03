class LineGraph{
    float posx, posy, w, h;
    float maxOfValues;
    float minOfValues;
    float range;
    color barColor;
    color backgroundColor, hoverColor;
    String[] keys,labels;
    float[] values;
    Circle[] circles;
    LineGraph(float posx1, float posy1,float w1, float h1, String[] keys1, float[] values1, String[]labels1, color backgroundColor1, color hoverColor1){
      posx = posx1;
      posy = posy1;
      w = w1;
      h = h1;
      keys = keys1;
      values = values1;
      labels = labels1;
      backgroundColor = backgroundColor1;
      hoverColor = hoverColor1;
      circles = new Circle[keys.length];
      Update();
    }
    
    void Update(){
      GraphOutline = new Rectangle(posx,posy,w, h,  "", backgroundColor);
      labelAxes();

      drawCircles(); 
      drawConnectingLines(); 
      checkCircleHover(); 
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
}
