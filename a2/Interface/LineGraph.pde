class LineGraph{
    float posx, posy, w, h;
    boolean currAnimating;
    float maxOfValues;
    float minOfValues;
    float range;
    color barColor;
    color backgroundColor, hoverColor;
    int preAnimFrames;
    String[] keys,labels;
    float[] values;
    Circle[] circles;
    float circleDist;
    float barDist;
    LineGraph(float posx1, float posy1,float w1, float h1, String[] keys1, float[] values1, String[]labels1, color backgroundColor1, color hoverColor1){
      currAnimating = false;
      posx = posx1;
      posy = posy1;
      circleDist = 0;
      barDist= 0;
      w = w1;
      h = h1;
      keys = keys1;
      values = values1;
      labels = labels1;
      backgroundColor = backgroundColor1;
      hoverColor = hoverColor1;
      circles = new Circle[keys.length];
      preAnimFrames = 0;
      Update();
    }
    
    void Update(){
      labelAxes();
      drawCircles(); 

      if(!currAnimating){
          GraphOutline = new Rectangle(posx,posy,w, h,  "", backgroundColor);
          drawConnectingLines(); 
          checkCircleHover(); 
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
    //fill(160,160,160);
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
      fill(0,0,0);
      textAlign(CENTER,CENTER);
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
  //returns true if still animating, false when done
  boolean animateToBar() {
    if (preAnimFrames < 100) {
      Update();
      preAnimFrames++;
      return true;
    } else {
      currAnimating = true;
      GraphOutline = new Rectangle(posx,posy,w, h,  "", backgroundColor);

      if(circleDist < 1){
          for(int i = 0;i<circles.length;i++){
             circles[i].radius = lerp(circles[i].origRadius,0,circleDist); 
             circles[i].Display();
          }
          for(int i = 0; i<line_graph.circles.length-1;i++){
            Circle circ1 = line_graph.circles[i]; 
            Circle circ2 = line_graph.circles[i+1];
            line(circ1.centerX,circ1.centerY,lerp(circ2.centerX,circ1.centerX,circleDist),lerp(circ2.centerY,circ1.centerY,circleDist)); 
         }
          Update();
          circleDist+=.01;
          return true;
      }
      else if(barDist < 1){
        //bar_graph.currAnimating = true;
        bar_graph.Update();
        GraphOutline = new Rectangle(posx,posy,w, h,  "", backgroundColor);
        
        for(int i = 0; i<bar_graph.bars.length; i++){
           bar_graph.bars[i].h = lerp(0,bar_graph.bars[i].origH, barDist);
           bar_graph.bars[i].w = lerp(0,bar_graph.bars[i].origW,barDist);
           bar_graph.bars[i].posx = lerp(bar_graph.bars[i].origPosx +bar_graph.bars[i].origW/2, bar_graph.bars[i].origPosx,barDist);
           bar_graph.bars[i].Display();
        }
        barDist+=.01; 
        return true;
      }
      //do transition.
      // once finished with entire transition: preAnimFrames = 0, and return false.
      preAnimFrames = 0;
      circleDist = 0;
      barDist= 0;
      currAnimating = false;
      return false;                  
    }
  }
  
  //returns true if still animating, false when done
  boolean animateToPie() {
    if (preAnimFrames < 100) {
      Update();
      preAnimFrames++;
      return true;
    } else {
      //do transition.
      // once finished with entire transition: preAnimFrames = 0, and return false.
      return false;                  //TEMPORARY
    }
  }
}
