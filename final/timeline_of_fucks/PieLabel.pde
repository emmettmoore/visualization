//One instance of this class will be a single label for a slice of a pie graph.
class PieLabel{
  String message;
  float posx;
  float posy;
  PFont tFont;
//  float rotationDegree;  
  color textColor;
  float Opacity;
  float opacityIncreaseFactor;
  float opacityDecreaseFactor;
  PieLabel(float pos_x, float pos_y, String message1, float degree, float rotation_degree, color fillColor, PFont fontUse, float initOpacity, float opacIncrFac, float opacDecrFac) {
    posx= pos_x;
    posy = pos_y;
    message = message1;
//    textFont = createFont("Tahoma", 15, true);
//    rotationDegree = rotation_degree; 
    textColor = fillColor;
    tFont = fontUse;
    Opacity = initOpacity;
    opacityIncreaseFactor = opacIncrFac;
    opacityDecreaseFactor = opacDecrFac;
  }
  
  void printWord() {
    if (message == null) {
      return;
    }
    //textFont = createFont("Tahoma", width/75, true);
    //tFont = createFont("monoscript", 10);              //JUST COMMENTED OUT 16
    pushStyle();
    textFont(tFont);
    //textAlign(CENTER);
    //smooth();
    pushStyle();      //JUST ADDED TAYLORRRRRRR
//    pushMatrix();           //push the next "translate" so that it can be undone afterwards
//    translate(posx, posy);  //Set the pivot axis
//    textAlign(CENTER, CENTER);
//    float radianRotation = rotationDegree;
//    pushMatrix();           //push the next "rotate" so that it can be undone afterwards                
//    rotate(radians(radianRotation));
//fill(color(255, 255, 255));
fill(textColor, Opacity);
    text(message, posx, posy);
//    popMatrix();            //pop the "rotate" from above, to undo it for future prints
//    popMatrix();            //pop the "translate" from above, to undo it for future prints
popStyle();
popStyle();
if (Opacity > 0) {
  Opacity = Opacity - opacityDecreaseFactor;
}
if (Opacity < 255) {
  Opacity = Opacity + opacityIncreaseFactor;
}
  }
}
