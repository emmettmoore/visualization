//This class is for the four vertical lines that contain the data points
// TODO:
//  - chop off some of the decimals on the numbers label
float TEXTDIST = 20;  //distance for the numerical labels to appear away from vertical line
class vertical_line {
   String label;  //The label at the bottom of the line
   float[] values;
    float posx;  //Top of line
    float posy;  //Top of line
    float lineHeight;  
    //TODO: put an instance of label class here also
    float min;
    float max;
    float floorVal;
    float ceilVal;
    int num_of_intervals;
    float[] classes;
    LineLabel numberLabel;
    vertical_line (String label1, float[]values1, float posx1, float posy1, float lineHeight1, float[] classes1) {
      label = label1;  //title for this vertical bar
      values = new float[values1.length];
      values = values1; //150 values to be plotted
      posx = posx1;
      posy = posy1;
      lineHeight = lineHeight1;
      classes = new float[classes1.length];
      classes = classes1;
      num_of_intervals = 10;  
      find_max_min();
      numberLabel = new LineLabel(values, posx - TEXTDIST, posy, lineHeight, floorVal, ceilVal, num_of_intervals);
      fill(0);
      textSize(16);
      textAlign(CENTER);
      text(label, posx, posy - BUFFER/2);
    } 
    
    //takes no arguments but just draws the chart again with its own variables
    void Display(){

        line(posx,posy, posx,posy+lineHeight);  //this was for my testing purposes!
        numberLabel.Display();
        miniCircles();
              fill(0);      //To print the labels --> 
      textSize(16);
      textAlign(CENTER);
      text(label, posx, posy - BUFFER/2);

    }
    void miniCircles() {
      Circle circ;
      //multiply by: height / difference of floor and cieling
      //max value - the one thats being put *  ^^ratio
      float ratio = lineHeight / (ceilVal - floorVal);
      color c = color(0, 0, 0);
      for (int i = 0; i < values.length; i++) {
        circ = new Circle(posx, posy + (ceilVal - values[i]) * ratio, .005, c);
        circ.Display();
        //    Circle(float centerX1, float centerY1, float radius1, color originalColor1){

      }
    }
    
    //should also take in a color........
    void connect_to_line(vertical_line next_line){
      float ratioThis = lineHeight / (ceilVal - floorVal);
      float ratioThat = next_line.lineHeight / (next_line.ceilVal - next_line.floorVal);
      for (int i = 0; i < values.length; i++) {
        stroke(COLORS[(int)classes[i]]);
        line(posx, posy + (ceilVal - values[i]) * ratioThis, next_line.posx, next_line.posy + (next_line.ceilVal - next_line.values[i]) * ratioThat);
      }  
 //    next_line.numberLabel.Display();
    }
    
    //finds and sets the max and min of the values array
    void find_max_min(){
     min = values[0];    //values must have >= 1 value in it
     max = values[0];
     for (int i = 0; i < values.length; i++) {
       if (values[i] < min ) {
          min = values[i];
       } 
       if (values[i] > max) {
         max  = values[i];
       }
     }
     floorVal = (float)Math.floor(min);
     if ((floorVal + 0.5) <= min) {
       floorVal = floorVal + 0.5;
     }
     ceilVal = (float)Math.ceil(max);
     if ((ceilVal - 0.5) >= max) {
       ceilVal = ceilVal - 0.5;
     }
     print("Min: " + min + ", Minfloor: " + floorVal + ", Max: " + max + ", Maxfloor: " + ceilVal + "\n");
     
    }
    
    
    
//should also take in a color........
//    void connect_to_line(vertical_line next_line){
//    }
    
//connects points from this line to the next line of the same index
//    void connect_to_line(vertical_line next_line){
      
//    }
}
