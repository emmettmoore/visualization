//One instance of this class will be a single label for a slice of a pie graph.
class PieLabel{
  String message;
  float posx;
  float posy;
  PFont textFont;
  float rotationDegree;      //TEMP
  float textColor;
  PieLabel(float pos_x, float pos_y, String message1, float degree, float rotation_degree, float fillColor) {
    posx= pos_x;
    posy = pos_y;
    message = message1;
    textFont = createFont("Tahoma", 15, true);
    rotationDegree = rotation_degree; 
    textColor = fillColor;
  }
  
  void printWord() {
    if (message == null) {
      return;
    }
    textFont = createFont("Tahoma", width/75, true);
    textFont(textFont);
    textAlign(CENTER);
    smooth();
    fill(textColor);
    pushMatrix();           //push the next "translate" so that it can be undone afterwards
    translate(posx, posy);  //Set the pivot axis
    textAlign(CENTER, CENTER);
    float radianRotation = rotationDegree;
    pushMatrix();           //push the next "rotate" so that it can be undone afterwards                
    rotate(radians(radianRotation));
    text(message, 0, 0);
    popMatrix();            //pop the "rotate" from above, to undo it for future prints
    popMatrix();            //pop the "translate" from above, to undo it for future prints
  }
}
