// Do we want it to display the percentage instead?

class PieGraph{
  float[] values;
  float[] angles;
  String[] keys;
  float w, h, posx, posy;
  float[] valuesCopy;
  int currWedge;
  int preAnimFrames;
  float fillPieIncrement;
  float total;
  float diameter;    
  float horizFrac;
  float maxOfValues;
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
    currWedge = 0;
    fillPieIncrement = 1;
    keys = keys1;
    angles = new float[values.length];
    pie_key_labels = new PieLabel[angles.length];
    pie_value_labels = new PieLabel[angles.length];
    origWidths = new float[values.length];    //to hold the post-animation heights of the bars/lines 
    total = 0;
    diameter = w1;      //taylor
    if (h1 < w1) { diameter = h1; }
    preAnimFrames = 0;      
    //calculate the sum of the values, AND correctly populate maxOfValues: 
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
 
 //returns true if still animating, false when done
 boolean animateToLine() {
  if(firstValueWhite == false){  
        float[] temp = values;
        values = new float[temp.length +1];
        int i;
        for(i = 0; i<values.length-1;i++){
           values[i] = temp[i];
        }
        values[i] = 0;
        
        String[] temp1 = keys;
        keys = new String[keys.length + 1];
        for(i = 0; i<keys.length-1;i++){
            keys[i] = temp1[i];
        }
        keys[i] = ""; 
        firstValueWhite = true;
        Update();
    }
    
    if (preAnimFrames < 100) {
      Update();
      preAnimFrames++;
      return true;
    } 
    else if (preAnimFrames==100) {      /* taylor start */
      currAnimating = true;
      float interval = 6/8f*height/(line_graph.circles.length);  //space between each circle on line graph
      print(line_graph.circles.length + "\n");
      line_graph.drawCircles();
      for(int i = 0; i<line_graph.circles.length;i++){
         //move circles to left side
         print("center of x before: ");
         print(line_graph.circles[i].centerX + "\n");
         print("center of y before: ");
         print(line_graph.circles[i].centerY + "\n");
         line_graph.circles[i].centerX = 0;
         line_graph.circles[i].centerY = 10 + i*interval; 
         line_graph.circles[i].Display();
         line_graph.drawConnectingLines(); 
        }
        preAnimFrames++;
        
        for(int i = 0; i<line_graph.circles.length; i++){
          origWidths[i] = line_graph.circles[i].origY; 
          print(origWidths[i] + "\n");
        }
        return true;
    
    }      /* taylor end */
    else if (currWedge < values.length - 1){
      line_graph.drawConnectingLines();               //taylor
      print(currWedge + "\n");
      if(values[currWedge]>0){
        values[currWedge] -= fillPieIncrement * total/360;
        values[values.length-1] += fillPieIncrement * total/360;
        Update();
        
        
       /* taylor adding: */
       
        line_graph.circles[currWedge].centerX += origWidths[currWedge] * fillPieIncrement;  //centerX feels dirty
 
        for (int i = 0; i<line_graph.circles.length; i++){
            line_graph.circles[i].Display();  
        }
          /* taylor adding ^ */
      }
      else{
        values[currWedge] = 0;
        keys[currWedge] = "";
        currWedge++;
      }
      return true;
    }
    print("test");
    currWedge = 0;
    preAnimFrames = 0;
    return false;
  }


  
  //returns true if still animating, false when done
  boolean animateToBar() {
    if(firstValueWhite == false){  
      print("HEHALKSFDKALSD");
        float[] temp = values;
        values = new float[temp.length +1];
        int i;
        for(i = 0; i<values.length-1;i++){
           values[i] = temp[i];
        }
        values[i] = 0;
        
        String[] temp1 = keys;
        keys = new String[keys.length + 1];
        for(i = 0; i<keys.length-1;i++){
            keys[i] = temp1[i];
        }
        keys[i] = ""; 
        firstValueWhite = true;
        Update();
    }
    
    if (preAnimFrames < 100) {
      Update();
      preAnimFrames++;
      return true;
    } 
    else if (currWedge < values.length - 1){
      print(currWedge + "\n");
      if(values[currWedge]>0){
        values[currWedge] -= fillPieIncrement * total/360;
        values[values.length-1] += fillPieIncrement * total/360;
        Update();
      }
      else{
        values[currWedge] = 0;
        keys[currWedge] = "";
        currWedge++;
      }
      return true;
    }
    print("test");
    currWedge = 0;
    preAnimFrames = 0;
    return false;
  }
  
    //Calculates the fractional value by which a rectangles original height
  //  must be multiplied in order that the graph of rectangles can be displayed
  //  so that the longest one runs to the midpoint of the graph.
    void calculateShrinkFactor() {
//      horizFrac = width / (2* circles[indexOfMax].origY);  

  }
}

