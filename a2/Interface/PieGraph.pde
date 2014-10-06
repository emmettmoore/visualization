// Do we want it to display the percentage instead?

class PieGraph{
  float[] values;
  float[] angles;
  String[] keys;
  float w, h, posx, posy;
  int preAnimFrames;
  float total;
  float diameter;    
  boolean currAnimating;
  boolean firstValueWhite;      //if the very first value of values[] is to be printed as a white wedge
  PieLabel[] pie_key_labels;    //to hold the keys & their screen positions, i.e. "apple", "pear", "orange"
  PieLabel[] pie_value_labels;  //to hold the values of each key and its screen position, i.e. "6", "5"
  PieGraph(float posx1, float posy1, float w1, float h1, String[] keys1, float[] values1) {
    firstValueWhite = false;
    posx = posx1; 
    posy= posy1;
    w = w1;
    h = h1;
    values = values1;

    
    
    keys = keys1;
    angles = new float[values.length];
    pie_key_labels = new PieLabel[angles.length];
    pie_value_labels = new PieLabel[angles.length];
    total = 0;
    diameter = w1;      //taylor
    if (h1 < w1) { diameter = h1; }
    preAnimFrames = 0;
    //calculate the sum of the values:
    for (int i = 0; i < values.length; i++) {
      total = total + values[i];
    }
    
    //populate the angles array:
    for (int i = 0; i < values.length; i++) {
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
    String messageToStore = null;
    float lastAngle = 0;
    for (int i = angles.length -1; i >=0; --i) {
      messageToStore = null;
      float shade = map (i+1, 0, angles.length, 60, 255);  //converting it to a shade of green
      fill(0, shade, 0);
//      if ((i==0) && (firstValueWhite == true)) {    //to fill the first value wedge as white
//        fill(255, 255, 255);
//      }
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
  
  //returns true if still animating, false when done
  boolean animateToBar() {
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

