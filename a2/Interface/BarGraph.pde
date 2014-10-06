class BarGraph{
    boolean currAnimating;
    float posx, posy, w, h;
    float maxOfValues;
    float minOfValues;
    float range;
    color barColor;
    color backgroundColor, hoverColor;
    int preAnimFrames;
    int animatingFrames;
    String[] keys,labels;
    float[] values;
    Rectangle[] bars;
    String[] pieKeys;    //used in bar to pie transition
    float[] pieValues;   //used in bar to pie transition 
    //lerp factor for shrinking bars
    float barDist;
    //lerp factor for making circles bigger
    float circleDist;
    float switchAxisDist;
    float fillPieIncrement;
    int numWedges;
    int indexOfMax;          //TAYLOR SCREEN
    float horizFrac;        //TAYLOR SCREEN
    float pieRemain;
    int curr_slice;
    float total;
    float[] origWidths;
    BarGraph(float posx1, float posy1,float w1, float h1, String[] keys1, float[] values1, String[]labels1, color barColor1, color backgroundColor1, color hoverColor1){
      posx = posx1;
      posy = posy1;
      w = w1;
      h = h1;
      indexOfMax = 0;        //TAYLOR SCREEN
      keys = keys1;
      values = values1;
      preAnimFrames = 0;
      currAnimating = false;
      barDist = 0;
      circleDist =0;
      switchAxisDist = 0;
      fillPieIncrement = 0.05;
      numWedges = 0;
      curr_slice = 0;
      origWidths = new float[values.length];
      
      total = 0;
      for (int i = 0;i<values.length;i++){
          total += values[i];
      }
      //for pie transition
      pieKeys = new String[values.length + 1];
      pieValues = new float[values.length + 1];

      
      
      for(int i = 1; i<pieValues.length; i++){
           pieValues[i] = 0;
           pieKeys[i] = "";           
      }
      pieKeys[pieKeys.length - 1] = "";
      pieRemain = total;
      pieValues[pieValues.length - 1] = pieRemain;
      
      labels = labels1;
      barColor = barColor1;
      backgroundColor = backgroundColor1;
      hoverColor = hoverColor1;
      bars = new Rectangle[keys.length];
    }
  
  
    
  void Update(){
    drawLabels();

    if(!currAnimating){
      GraphOutline = new Rectangle(posx,posy,w, h,  "", backgroundColor);
      drawBars();
      checkBarHover();
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
  void drawLabels(){
    fill(0, 102, 153);
    labelAxes();
  }
  void drawBars(){
    int xInterval = (int)w/keys.length;
    int intervalBuffer = xInterval*1/8;
    Rectangle temp;
     for(int i = 0; i < keys.length; i++){
       float barHeight = (values[i]/range * h);
        temp = new Rectangle(posx + i*xInterval + intervalBuffer/2, posy + h - barHeight,xInterval-intervalBuffer,barHeight,"",barColor);
        bars[i] = temp;        
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
    startingPoint = 0;
    range = (float) maxOfValues;
    float interval = (float)range/10.0;
    float currInterval = 0;
    for(int i = 0; i <= NUM_INTERVALS; i++){
      currInterval = i*interval;
      String currText = Float.toString(currInterval);
      textSize(12);

       text(currText, posx - BUFFER, posy + h - h/10*i);
    }
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
    indexOfMax = 0;                        //TAYLOR SCREEN
    for(int i = 1; i<values.length;i++){
       if(maxOfValues < values[i]){
         maxOfValues = values[i]; 
         indexOfMax = i;                  //TAYLOR SCREEN
       }
       if(minOfValues > values[i]){
         minOfValues = values[i];
       }
    }
  }
  //Calculates the fractional value by which a rectangles original height
  //  must be multiplied in order that the graph of rectangles can be displayed
  //  so that the longest one runs to the midpoint of the graph.
  void calculateShrinkFactor() {
      horizFrac = width / (2* bars[indexOfMax].origH);        //TAYLOR SCREEN

  }
    //returns true if still animating, false when done
  boolean animateToLine() {
    if (preAnimFrames < 100) {
      Update();
      preAnimFrames++;
      return true;
    } else {
      currAnimating = true;
      GraphOutline = new Rectangle(posx,posy,w, h,  "", backgroundColor);

      if(barDist < 1){
        for(int i = 0; i<bars.length; i++){
           bars[i].h = lerp(bars[i].origH,0, barDist);
           bars[i].w = lerp(bars[i].origW,0,barDist);
           bars[i].posx = lerp(bars[i].origPosx, bars[i].origPosx +bars[i].origW/2,barDist);
           bars[i].Display();
        }
        barDist+=.01; 
        Update();
        return true; 
      }
      else if(circleDist<1){    //begin phase 2
         line_graph.currAnimating = true;
         line_graph.Update();
        GraphOutline = new Rectangle(posx,posy,w, h,  "", backgroundColor);

         for(int i = 0; i<line_graph.circles.length; i++){
           line_graph.circles[i].radius = lerp(0, line_graph.circles[i].origRadius, circleDist);
           line_graph.circles[i].Display();
         }
         for(int i = 0; i<line_graph.circles.length-1;i++){
           Circle circ1 = line_graph.circles[i]; 
           Circle circ2 = line_graph.circles[i+1];
           line(circ1.centerX,circ1.centerY,lerp(circ1.centerX,circ2.centerX,circleDist),lerp(circ1.centerY,circ2.centerY,circleDist)); 
         }
         circleDist+=.01;
         return true;
      }
      line_graph.currAnimating = false;
      currAnimating = false;
      preAnimFrames = 0;
      barDist = 0;
      circleDist = 0;
      switchAxisDist = 0;
      fillPieIncrement = 0;
      numWedges = 0;
      return false;                  //TEMPORARY
    }
  }
  
  //returns true if still animating, false when done
  boolean animateToPie() {
    if (preAnimFrames < 100) {
      Update();
      preAnimFrames++;
      return true;
    }
      currAnimating = true;
      if (switchAxisDist < 1){
                   float interval = 6/8f*height/bars.length;

        calculateShrinkFactor();      //taylor likes this
        for(int i = 0; i<bars.length;i++){
         //move bars to left side
         bars[i].posx = lerp(bars[i].origPosx,10,switchAxisDist); 
         bars[i].posy = lerp(bars[i].origPosy,10 + i*interval,switchAxisDist); 
         //twist the bars
         bars[i].w = lerp(bars[i].origW, bars[i].origH*horizFrac,switchAxisDist);    //taylor likes this
         bars[i].h = lerp(bars[i].origH, interval,switchAxisDist);
         bars[i].Display();
         
        }
        switchAxisDist+=.007;
        for(int i = 0; i<bars.length; i++){
          origWidths[i] = bars[i].w; 
        }
        return true;
      }
      else if(curr_slice < values.length){
         if (pieValues[curr_slice] < values[curr_slice]) { // still filling in this slice (curr_slice)
         pieValues[curr_slice] += values[curr_slice] * fillPieIncrement;
         pieKeys[curr_slice] = keys[curr_slice];
         pieRemain -= values[curr_slice] * fillPieIncrement;
         pieValues[pieValues.length - 1] = pieRemain;
         PieGraph temp = new PieGraph(pie_graph.posx,pie_graph.posy, pie_graph.w, pie_graph.h,pieKeys,pieValues);
         temp.firstValueWhite = true;
         temp.Update();
         
         bars[curr_slice].w -= origWidths[curr_slice] * fillPieIncrement;
         if (bars[curr_slice].w < 0) {
           bars[curr_slice].w = 0; // emmett
         }
           
         for (int i = 0; i<bars.length; i++){
           bars[i].Display();  
         }
         }        
         else {
         curr_slice++;
         } 
         return true;
      }
      switchAxisDist = 0;
      preAnimFrames = 0;
      pie_graph.currAnimating = false;
      currAnimating = true;
      return false;
  }
  float max( float f1, float f2) {
    if (f1 > f2) {
     return f1;
    }
    return f2; 
  }
}

