// Do we want it to display the percentage instead?

class PieGraph{
  PieLabel[] horizBarKeys;      //to hold the labels that will appear for the horizontal bars
  PieLabel[] horizBarValues;
  float[] values;
  float[] angles;
  String[] keys;
  float w, h, posx, posy;
  float[] valuesCopy;
  int currWedge;
  int preAnimFrames;
  boolean origWidthInit;
  float fillPieIncrement;
  float total;
  float diameter;    
  float horizFrac;
  float interval;
  float maxOfValues;
  float switchAxisDist;
  boolean currAnimating;
  float[] origWidths;           //to hold the post-animation heights of the bars/lines 
  boolean firstValueWhite;      //if the very first value of values[] is to be printed as a white wedge
  PieLabel[] pie_key_labels;    //to hold the keys & their screen positions, i.e. "apple", "pear", "orange"
  PieLabel[] pie_value_labels;  //to hold the values of each key and its screen position, i.e. "6", "5"
  PieGraph(float posx1, float posy1, float w1, float h1, String[] keys1, float[] values1) {
    
    firstValueWhite = false;
    posx = posx1; 
    posy= posy1;
    w = w1;
    h = h1;
    int i;
    values = values1;
    keys = keys1;
    origWidthInit = false;
    currWedge = 0;
    fillPieIncrement = .05;
    switchAxisDist = 0;
    keys = keys1;
    angles = new float[values.length];
    pie_key_labels = new PieLabel[angles.length];
    pie_value_labels = new PieLabel[angles.length];
    origWidths = new float[values.length];    //to hold the post-animation heights of the bars/lines 
    horizBarKeys = new PieLabel[values.length];
    horizBarValues = new PieLabel[values.length];
    total = 0;
    diameter = w1;      //taylor
    if (h1 < w1) { diameter = h1; }
    preAnimFrames = 0;      
    //calculate the sum of the values, AND correctly populate maxOfValues & index of max: 
    maxOfValues = values[0];    
    for (i = 0; i < values.length; i++) {
      total = total + values[i];
      if (values[i] > maxOfValues) {
        maxOfValues = values[i];
      }
    }
    //populate the angles array:
    for (i = 0; i < values.length; i++) {
      angles[i] = ((values[i]/ total) * 360);
    }
  }
  
  void calculateDiameter() {
    diameter = height/2;
    if (width < height) {
        diameter = width/2;
     }
  }
 
 //Taylor likes this
 void Update() {
   drawPie();
 }

void drawPie(){ 
//   pushMatrix();        //to push the stroke setting so that it can be removed @ end of function
//   stroke(255);          //TO MAKE THIS WHITE
    //calculate the sum of the values:
    total = 0;
    for (int i = 0; i < values.length; i++) {
      total = total + values[i];
    }
    //populate the angles array:
    angles = new float[values.length];
    for (int i = 0; i < values.length; i++) {
      angles[i] = ((values[i]/ total) * 360);
    }
    pie_key_labels = new PieLabel[angles.length];
    pie_value_labels = new PieLabel[angles.length];

    String messageToStore = null;
    float lastAngle = 0;
    for (int i = angles.length -1; i >=0; --i) {
      messageToStore = null;
      float shade = map (i+1, 0, angles.length, 60, 255);  //converting it to a shade of green
      fill(0, shade, 0);
      if ((i==values.length -1) && (firstValueWhite == true)) {    //to fill the first value wedge as white
        fill(255, 255, 255);
      }

      arc(posx , posy, diameter, diameter, lastAngle, lastAngle+radians(angles[i]));

      outlineWedge(posx,posy, lastAngle, lastAngle+radians(angles[i]));

      if (radians(angles[i]) > 0) {
        messageToStore = keys[i];
      }
      storeLabel(posx, posy, lastAngle + (radians(angles[i]))/2, messageToStore, i);

      lastAngle += radians(angles[i]);

    }
    printLabels();
//    popMatrix();    //to return to previous stroke setting
} 





//void storeLabel(float originx, float originy, float diameter, float angle, String message, int position) {
void storeLabel(float originx, float originy, float angle, String message, int position) {
  int rotationDeg = 0;
  float radius = diameter/2;
  float textX = originx + radius *cos(angle);
  float textY = originy + radius *sin(angle);
  
  if (textX > originx) {
    rotationDeg = (int)(-80 * (abs((float)(sin(angle)))));
    if (textY > originy) {
      rotationDeg = (int)(80 * (float)(sin(angle)));
    }
  } else {
    rotationDeg = (int)(-80 * (float)(sin(angle)));
    if (textY > originy) {
      rotationDeg = (int)(-80 * (abs((float)(sin(angle)))));
    }
  }
  pie_key_labels[position] = new PieLabel(textX, textY, message, angle, rotationDeg, 0);
  
  
  rotationDeg = 0;
  String numerical = Float.toString(values[position]);
  if (values[position] == (int)values[position]) {
    numerical = Integer.toString((int)(values[position]));
  }
  if (message == null) {
    numerical = null;
  }
  float numericalX = originx + (2*(radius/3)) * cos(angle);
  float numericalY = originy + (2*(radius/3)) * sin(angle);
  pie_value_labels[position] = new PieLabel(numericalX, numericalY, numerical, angle, rotationDeg, 255);

}

void printLabels() {
  for (int i = 0; i < pie_key_labels.length; i++) {
    pie_key_labels[i].printWord();
    pie_value_labels[i].printWord();
  }
}

 void outlineWedge(float originx, float originy, float angleStart, float angleEnd) {
    float radius = diameter/2;
    float arcBeginX = originx + radius *cos(angleStart);
    float arcBeginY = originy + radius *sin(angleStart);
    float arcEndX = originx + radius * cos(angleEnd);
    float arcEndY = originy + radius * sin(angleEnd);
    line(originx, originy, arcBeginX, arcBeginY);
 }
 
//returns true if still animating, false when done.
boolean animateToLine() {
  drawCirclesAndLines();
      if (preAnimFrames < 100) {
      Update();
      preAnimFrames++;
      return true;
    } 
        else if (currWedge < values.length - 1){
      if(values[currWedge]>0){
        values[currWedge] -= valuesCopy[currWedge] * fillPieIncrement;
        values[values.length-1] += valuesCopy[currWedge] * fillPieIncrement;
        if(line_graph.circles[currWedge].centerX < (origWidths[currWedge] + 10)){  
            line_graph.circles[currWedge].centerX += origWidths[currWedge] * fillPieIncrement;
        }
        for(int i = 0; i<line_graph.circles.length;i++){
           line_graph.circles[i].Display(); 
        }
        line_graph.drawConnectingLines();

       horizBarValues[currWedge].posx = (line_graph.circles[currWedge].centerX + line_graph.circles[currWedge].radius * 2 + BUFFER);  //move value's position in
        if (horizBarValues[currWedge].posx < (BUFFER*4)){    //minimum value for value's position to come towards left edge
        horizBarValues[currWedge].posx = BUFFER*4;
        }
         float newMessage = (line_graph.values[currWedge] - values[currWedge]);
         if (newMessage >= line_graph.values[currWedge]) {
           newMessage = line_graph.values[currWedge];
           horizBarValues[currWedge].message = String.valueOf(newMessage);
         }
         else {
            horizBarValues[currWedge].message = Integer.toString(int(newMessage));
         }
         displayHorizBarLabels();
        Update();
      }
      else{
        values[currWedge] = 0;
        keys[currWedge] = "";
        currWedge++;
      }

      return true;
    }
     else if(switchAxisDist <1){
        for(int i = 0; i<line_graph.circles.length;i++){
         //move dots to left side
         line_graph.circles[i].centerX = lerp(10 + origWidths[i],line_graph.circles[i].origX,switchAxisDist); 
         line_graph.circles[i].centerY = lerp(10 + i*interval,line_graph.circles[i].origY,switchAxisDist); 
         line_graph.circles[i].Display();
        }
        line_graph.drawConnectingLines();
        switchAxisDist += .01;
        return true;
    }
    switchAxisDist = 0;
    currWedge = 0;
    origWidthInit = false;
    preAnimFrames = 0;
    return false;
  }
  
  //returns true if still animating, false when done
  boolean animateToBar() {
          drawBars();

    if (preAnimFrames < 100) {
      Update();
      preAnimFrames++;
      return true;
    } 
    else if (currWedge < values.length - 1){
      if(values[currWedge]>0){
        values[currWedge] -= valuesCopy[currWedge] * fillPieIncrement;
        values[values.length-1] += valuesCopy[currWedge] * fillPieIncrement;
        if(bar_graph.bars[currWedge].w < origWidths[currWedge]){
          bar_graph.bars[currWedge].w += origWidths[currWedge] * fillPieIncrement;
        }
        for(int i = 0; i<bar_graph.bars.length;i++){
           bar_graph.bars[i].Display(); 
        }
        
 
         float newMessage = (bar_graph.values[currWedge] - values[currWedge]);    //For bar labels
         if (newMessage >= bar_graph.values[currWedge]) {
           newMessage = bar_graph.values[currWedge];
           horizBarValues[currWedge].message = String.valueOf(newMessage);
         }
         else {
            horizBarValues[currWedge].message = Integer.toString(int(newMessage));
         }
         displayHorizBarLabels();
      
        Update();
      }
      else{
        values[currWedge] = 0;
        keys[currWedge] = "";
        currWedge++;
      }

      return true;
    }
    else if(switchAxisDist <1){
        for(int i = 0; i<bar_graph.bars.length;i++){
         //move bars to left side
         bar_graph.bars[i].posx = lerp(10,bar_graph.bars[i].origPosx,switchAxisDist); 
         bar_graph.bars[i].posy = lerp(10 + i*interval,bar_graph.bars[i].origPosy,switchAxisDist); 
         //twist the bars
         bar_graph.bars[i].w = lerp(bar_graph.bars[i].origH*horizFrac,bar_graph.bars[i].origW, switchAxisDist);    //taylor likes this
         bar_graph.bars[i].h = lerp(interval,bar_graph.bars[i].origH, switchAxisDist);
         bar_graph.bars[i].Display();
         //add label to array of labels:
        }
        switchAxisDist += .01;
        return true;
    }
    switchAxisDist = 0;
    currWedge = 0;
    origWidthInit = false;
    preAnimFrames = 0;
    return false;
  }

  // Arguments: The originalY height of the largest value in the array of circles/ array of rects
  // Calculates the fractional value by which a rectangles (graph dot's) original height
  //  must be multiplied in order that the graph of rectangles (circles) can be displayed
  //  so that the longest one runs to the midpoint of the graph.
    void calculateShrinkFactor(float maxValueHeight) {
      horizFrac = width / (2* maxValueHeight);  
    }
    
  void checkValueSizes(){
    if(firstValueWhite == false){ 
 
      valuesCopy = values;
      values = new float[valuesCopy.length +1];
      int i;
      for(i = 0; i<values.length-1;i++){
         values[i] = valuesCopy[i];
      }
      values[i] = 0;

      valuesCopy = new float[values.length +1];
      for(i = 0; i<values.length-1;i++){
         valuesCopy[i] = values[i];
      }
      valuesCopy[i] = 0;
      
      String[] temp1 = keys;
      keys = new String[keys.length + 1];
      for(i = 0; i<keys.length-1;i++){
          keys[i] = temp1[i];
      }
      keys[i] = ""; 
      firstValueWhite = true;
      Update();
    }
  }
  
  //equivalent of drawBars, but for line graph
  void drawCirclesAndLines() {
    if(!origWidthInit){
        checkValueSizes();

        line_graph.Update();
        fill(250,250,250);
        rect(0,0,width,height*7/8f);


       calculateShrinkFactor(line_graph.values[line_graph.indexOfMax] / line_graph.range * line_graph.h);
       interval = 6/8f*height/line_graph.circles.length;
  
       for(int i = 0; i<line_graph.circles.length;i++){
         //move dots to left side
         line_graph.circles[i].centerX = 10; 
         line_graph.circles[i].centerY = 10 + i*interval; 
         
         //         horizBarValues[i] = new PieLabel(circles[i].centerX + circles[i].radius * 2 + BUFFER, (circles[i].centerY + (values[i]/ (range * h))/2), Float.toString(values[i]), 0f, 0f, 0f);
         horizBarValues[i] = new PieLabel((line_graph.circles[i].centerX + line_graph.circles[i].radius * 2 + BUFFER*4), (line_graph.circles[i].centerY + (line_graph.values[i]/ (line_graph.range * line_graph.h))/2), Float.toString(0f), 0f, 0f, 0f);

//         horizBarValues[i] = new PieLabel((line_graph.circles[i].centerX + (BUFFER*4)), (line_graph.circles[i].centerY + (line_graph.values[i]/ (line_graph.range * line_graph.h))/2), Float.toString(0f), 0f, 0f, 0f);
         horizBarKeys[i] = new PieLabel((line_graph.circles[i].centerX + (BUFFER)), (line_graph.circles[i].centerY + (line_graph.values[i]/ (line_graph.range * line_graph.h))/2), line_graph.keys[i], 0f, 0f, 0f);
       }
        origWidths = new float[line_graph.circles.length];
        for(int i = 0; i<origWidths.length; i++){
          origWidths[i] = (line_graph.values[i]/ line_graph.range * line_graph.h);
        } 
        origWidthInit = true;

     }
  }
  
  void drawBars(){

     if(!origWidthInit){
        checkValueSizes();

        bar_graph.Update();
        fill(250,250,250);
        rect(0,0,width,height*7/8f);

       
       horizFrac = width / (2* bar_graph.bars[bar_graph.indexOfMax].origH); 
       interval = 6/8f*height/bar_graph.bars.length;
  
       for(int i = 0; i<bar_graph.bars.length;i++){
         //move bars to left side
         bar_graph.bars[i].posx = 10; 
         bar_graph.bars[i].posy = 10 + i*interval; 
         //twist the bars
         bar_graph.bars[i].w = bar_graph.bars[i].origH*horizFrac;    
         bar_graph.bars[i].h = interval;
         horizBarValues[i] = new PieLabel((bar_graph.bars[i].posx + (BUFFER*4)), (bar_graph.bars[i].posy + bar_graph.bars[i].h/2), Float.toString(0f), 0f, 0f, 0f);
         horizBarKeys[i] = new PieLabel((bar_graph.bars[i].posx + (BUFFER)), (bar_graph.bars[i].posy + bar_graph.bars[i].h/2), bar_graph.keys[i], 0f, 0f, 0f);
       }
        origWidths = new float[bar_graph.bars.length];
        for(int i = 0; i<origWidths.length; i++){
           origWidths[i] = bar_graph.bars[i].w;
           bar_graph.bars[i].w = 0;
        } 
        origWidthInit = true;
 //       displayHorizBarLabels();

     }
  }
  
    void displayHorizBarLabels() {
    for (int i = 0; i < horizBarKeys.length; i++) {
      horizBarKeys[i].printWord();
      horizBarValues[i].printWord();
    }
  }
}


