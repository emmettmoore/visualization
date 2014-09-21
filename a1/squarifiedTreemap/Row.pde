class Row{
  int rowRects[];       //IDs of children already in current row
  float rowposy;          //Top left corner position of row
  float rowposx;          //Top left corner position of row
  boolean rowIsVertical;//Tells whether alignment of current row is vertical or horizontal
  float rowShortSide;   //If the row is tall and vertical, then the short side is the width of the row.
                        //  NOTE: this can sometimes be the OPPOSITE of the side that is shortSide for the canvas. 
  float rowCanvasSide;  //The length of the side of the canvas
                        //   against which the row is being placed. (The "short side"
                        //   that was found to place row against)
                        //   Note that the canvas is being placed up against the SHORTER side.
  float rowAspectRatio; //Aspect Ratio for the entire row
  float rowArea;        //Total area for entire row
  int numElems;           //Number of elements in rowRects[];
  
  
  Row(float posx, float posy, float shortSide, float longSide, boolean isVertical) {
    rowRects = new int[0];
    rowposx = posx;
    rowposy = posy;
    rowCanvasSide = shortSide;
    rowShortSide = 0;
    rowIsVertical = isVertical;
    
    rowAspectRatio = 0;            //Initializing extra values to 0
    rowArea = 0;      
    numElems = 0;    
  }
  Row() {
    rowRects = new int[0];
    rowposx = 0;
    rowposy = 0;
    rowCanvasSide = 0;
    rowShortSide = 0;
    rowIsVertical = true;
    rowAspectRatio = 0;
    rowArea = 0;
    numElems = 0;
  }

// Adds the passed-in ID value to the array 
// Iterates up the numElems variable
void addToArray(int newId) {
  int[] newArray;
  newArray = new int[numElems + 1];
  for (int i = 0; i < numElems; i++) {
    newArray[i] = rowRects[i];
  }
  newArray[numElems] = newId;
  rowRects = new int[numElems + 1];
  for (int i = 0; i <= numElems; i++) {
    rowRects[i] = newArray[i];
  }
  numElems = numElems + 1;
}

  
}
