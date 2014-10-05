// Do we want it to display the percentage instead?

class PieGraph{
  float[] values;
  float[] angles;
  String[] keys;
  float w, h, posx, posy;
  int preAnimFrames;
  float total;
  boolean currAnimating;
  PieLabel[] pie_key_labels;    //to hold the keys & their screen positions, i.e. "apple", "pear", "orange"
  PieLabel[] pie_value_labels;  //to hold the values of each key and its screen position, i.e. "6", "5"
  PieGraph(float posx1, float posy1, float w1, float h1, String[] keys1, float[] values1) {
    currAnimating = false;
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
    preAnimFrames = 0;
 //   int nonzeroTotal = 0;  //to be used to create size of PieLabels array
    //calculate the sum of the values:
    for (int i = 0; i < values.length; i++) {
      total = total + values[i];
    }
    
    //populate the angles array:
    for (int i = 0; i < values.length; i++) {
      angles[i] = ((values[i]/ total) * 360);
    }
  }
 //TO DO : add arguments x, y, width, height
 void Update() {
   if(!currAnimating){
     float smallerEdge = height;
     if (width < height) {
        smallerEdge = width;
     }
     drawPie(smallerEdge/2);
   }
 }
 
void drawPie(float diameter) {
//   pushMatrix();        //to push the stroke setting so that it can be removed @ end of function
//   stroke(255);          //TO MAKE THIS WHITE
    String messageToStore = null;
    float lastAngle = 0;
    for (int i = 0; i < angles.length; i++) {
      messageToStore = null;
      float shade = map (i+1, 0, angles.length, 60, 255);  //converting it to a shade of green
      fill(0, shade, 0);
      posx = width/2;
      posy = height/2 - height/8;
      arc(posx , posy, diameter, diameter, lastAngle, lastAngle+radians(angles[i]));
      outlineWedge(posx,posy, diameter, lastAngle, lastAngle+radians(angles[i]));

      if (radians(angles[i]) > 0) {
        messageToStore = keys[i];
      }
      storeLabel(width/2, height/2 - height/8, diameter, lastAngle + (radians(angles[i]))/2, messageToStore, i);
      lastAngle += radians(angles[i]);
    }
    printLabels();
//    popMatrix();    //to return to previous stroke setting
}  

void storeLabel(float originx, float originy, float diameter, float angle, String message, int position) {
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

 void outlineWedge(float originx, float originy, float diameter, float angleStart, float angleEnd) {
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

