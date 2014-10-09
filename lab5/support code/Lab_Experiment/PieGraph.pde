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
    diameter = w1;  
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
} 





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
  
}


