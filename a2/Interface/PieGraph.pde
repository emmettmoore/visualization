class PieGraph{
  float[] values;
  float[] angles;
  String[] keys;
  float w, h, posx, posy;
  float total;
  PieGraph(float posx1, float posy1, float w1, float h1, float[] values1, String[] keys1) {
    posx = posx1; 
    posy= posy1;
    w = w1;
    h = h1;
    values = values1;
    keys = keys1;
    angles = new float[values.length];
    total = 0;
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
 void update() {
   float smallerEdge = height;
   if (width < height) {
      smallerEdge = width;
   }
   drawPie(smallerEdge/2);
 }
 
 void drawPie(float diameter) {
    float lastAngle = 0;
    for (int i = 0; i < angles.length; i++) {
      float shade = map(i, 0, angles.length, 0, 255);      //converting it to a shade of gray
      fill(shade);
//      arc(posx + w/2, posy + h/2, diameter, diameter, lastAngle, lastAngle+radians(angles[i]));
      arc(width/2 , height/2 - height/8, diameter, diameter, lastAngle, lastAngle+radians(angles[i]));
//      printWord(diameter, lastAngle, lastAngle+radians(angles[i]), keys[i]);                //NEW STUFF -- TEMP COMMENT OUT
      lastAngle += radians(angles[i]);
    }
 /*   drawText(diameter); */                 //TEMP
  }  
  //NEW STUFF--- TEMP COMMENT OUT
  /*
  void printWord(float diameter, float lastAngle, float endPoint, String stringMessage) {
    char[] message = stringMessage.toCharArray();
    newFont = createFont("Tahoma", 20, true);
   textFont(newFont);
   textAlign(CENTER);
   smooth();
   translate(width/2, height/2);
   noFill();
   stroke(0);
   ellipse(0, 0, diameter, diameter);
  
  float arclength = lastAngle; 

  for (int i = 0; i < message.length(); i++)
  if (arclength < endPoint) {
    char currentChar = message.charAt(i);
    float w = textWidth(currentChar);
    */
    
    
    //OLD STUFF
/* void drawText(float diameter) {
   radius = diameter/2;
   newFont = createFont("Tahoma", 20, true);
   textFont(newFont);
   textAlign(CENTER);
   smooth();
   translate(width/2, height/2);
   noFill();
   stroke(0);
   ellipse(0, 0, diameter, diameter);
  
  float arclength = 0; 
  for (int  i = 0; i < 
  
 } 
 */
 
 
}

