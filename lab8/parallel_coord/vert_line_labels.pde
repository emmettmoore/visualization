//this class is for the labels of the vertical lines
//TO DO:
//  - put hashes next to the numbers on the numberline
//  - move the numbers further away from the line.
class LineLabel {
  float posx;  //top number's position (max's)
  float posy;  // top number's position (max's)
  float h;
  float min;  //min value for display (will be floor value of lowest value of real data)
  float max;  //max value for display (will be ceiling value of largest value of real data)
  float[] values;
  float numIntervals;
  float[] printValues;
  LineLabel (float[] values1, float posx1, float posy1, float h1, float min1, float max1, float num_intvls) {
    values = new float[values1.length];
    values = values1;
    posx = posx1;
    posy = posy1;
    h = h1;
    min = min1;
    max = max1;
    numIntervals = num_intvls;
    printValues = new float[(int)numIntervals + 1];
    populate_Print_Values();
  //  printNums();
  }
  
  void Display() {
    printNums();
  }
  
  void populate_Print_Values(){
    float diff = max - min;
    float dist = diff / numIntervals;    
    for (int i = 0; i < printValues.length; i++) {
      printValues[i] = max - dist * i;
    }
  }
  
  void printNums() {
    final DecimalFormat flo = new DecimalFormat("0.##");  //to control the number of decimal places that appear
    fill(0);
    textAlign(CENTER);
    textSize(12);
    float dist = h / numIntervals;
    for (int i = 0; i < printValues.length; i++) {
      text(flo.format(printValues[i]), posx, posy + dist * i);
    }
  }
  
}
