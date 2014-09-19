class Row{
  int rowRects[];    //IDs of children already in current row
  int rowposy;        //previously: currentRowYPos. Top left corner position of row
  int rowposx;        //prevoiusly: currentRowXPos. Top left corner position of row
  boolean rowIsVertical;//Tells whether alignment of current row is vertical or horizontal
  float rowShortSide;
  float rowCanvasSide;  //The length of the side of the canvas
                          // against which the row is being placed. (The "short side"
                          //    that was found to place row against)
  float rowAspectRatio;  //Aspect Ratio for the entire row
  float rowArea;          //Total area for entire row
//  Row() {
//  }
  
}
