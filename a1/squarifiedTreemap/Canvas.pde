class Canvas{
  int id;
  int value;
  Row currentRow; 
  float heightRemaining;
  float widthRemaining;
  float posx = 0;
  float posy = 0;
  float areaRemaining;
  float VA_ratio;
  int[] childrenByTotal;
  Canvas (int id1, float canvasHeight, float canvasWidth) {
    id = id1;
    value = 0;
    heightRemaining = canvasHeight;
    widthRemaining = canvasWidth;
    areaRemaining = heightRemaining * widthRemaining;
    currentRow = new Row();                      
  }
  

 void canvasInfo(int canvasId) {               //Populates canvas information
   sortChildrenByTotal();                      //Get childrenByTotal array populated & ordered
   float shortSide, longSide;                  //Find data to pass into Row constructor:
    boolean rowIsVertical = true;
   if (heightRemaining < widthRemaining) {    //(Defaults to vertical row if h==w)
     shortSide = heightRemaining;
     longSide = widthRemaining;
     rowIsVertical = true;
   } else {
     shortSide = widthRemaining;
     longSide = heightRemaining;
     rowIsVertical = false;
   }
   //Set member variable information:
   currentRow = new Row(posx, posy, shortSide, longSide, rowIsVertical);
   value = ((Node)ParentChildMap.get(id)).total;
   VA_ratio = value / (heightRemaining * widthRemaining);
 }
 



  //Function: sortChildrenByTotal()
  //Summary:  Will create temporary array tempArray[], and set sizes of childrenByTotal
  //          and tempArray both to be the number of children of the Canvas's ID as a node.
  //          childrenByTotal to hold IDs of children, tempArray to be populated with the
  //          values of the IDs in each respective elem of childrenByTotal array.
  //          Will then use Bubble sort algorithm from this page:
  //          https://www.cs.cmu.edu/~adamchik/15-121/lectures/Sorting%20Algorithms/sorting.html
  //          to sort both arrays at the same time, based on the size of the values in tempArray.
void sortChildrenByTotal() {    //Populate childrenByTotal array usng ParentChildMap
     int arraySize= ((Node)ParentChildMap.get(id)).children.size();
     childrenByTotal = new int[arraySize];
    // Populate ChildrenByTotal array with ID values listed as children for this Node.
    Iterator itr = ((Node)ParentChildMap.get(id)).children.iterator();
    int curr_index = 0;
    while (itr.hasNext()) {
      childrenByTotal[curr_index] = (Integer)itr.next();
      curr_index++;
    }
    int tempArray[] = new int[arraySize];    //TempArray will hold the values for each element                
    for (int i = 0; i < arraySize; i++) {  //     of the ID in childrenByTotal, indices matching.
      tempArray[i] = ((Node)ParentChildMap.get(childrenByTotal[i])).total;
    }
    //Perform bubble Sort in order to organize arrays so that their indices still match
    //    and childrenByTotal holds the IDs sorted by order according to the nodes "total value".
    for (int i = (arraySize - 1); i >= 0; i--) {
      for (int j = 1; j <=i; j++) {
        if (tempArray[j-1] < tempArray[j]){
          int tempVal = tempArray[j-1];
          tempArray[j-1] = tempArray[j];
          tempArray[j] = tempVal;
          int tempId = childrenByTotal[j-1]; //Three calls to match above three calls, for IDs array-- 
          childrenByTotal[j-1] = childrenByTotal[j];
          childrenByTotal[j] = tempId;
        }}}
}
  
   // Function:    nextRect()
   // Summary:     Returns the node (rectangle) with all pre-populated
   //              data in it. This rect will be the next one in the
   //              childrenByTotal[] array's list of children
   //              which has not yet been placed on a canvas. 
 Node nextRect() {
     for (int i = 0; i < ((Node)ParentChildMap.get(id)).children.size(); i++){
      Node newRect = (Node)ParentChildMap.get(childrenByTotal[i]);
      if (newRect.isPlaced == false) {
        newRect.populateRectInfo(VA_ratio);
        return newRect;
      }

    }
    return null;
 }

// Requires that the canvas already have an existing row on it.
//    uses member values stored in current row to update new dimensional info
//    for canvas.
//  Precondition: This row cannot be the 1st row being placed in the rectangle. There must have been
//                rows already in before it.
void newRow() {
                                                 //If the row is NOT empty and therefor it is NOT being
    if (currentRow.rowIsVertical) {              //    populated for the first time:
      widthRemaining = widthRemaining - currentRow.rowShortSide;
      posx = posx + currentRow.rowShortSide;
    } else {
      heightRemaining = heightRemaining - currentRow.rowShortSide;
      posy = posy + currentRow.rowShortSide;
    }
    areaRemaining = heightRemaining * widthRemaining;
  // Now calculate info for new Row, given updated Canvas size info:
  float shortSide, longSide;
  boolean rowIsVertical = false;
   if (heightRemaining < widthRemaining) {    //(Defaults to vertical row if h==w)
     shortSide = heightRemaining;
     longSide = widthRemaining;
     rowIsVertical = true;
   } else {
     shortSide = widthRemaining;
     longSide = heightRemaining;
     rowIsVertical = false;
   }
     //Set member variable information:
    currentRow = new Row(posx, posy, shortSide, longSide, rowIsVertical);
}
  
  
  
  
  // Function:  addToCurrRow()
  // Summary:   Will place rectToAdd on canvas in the current row, and resize
  //            all other rectangles currently in the row as necessary.
  // MUST:      add rect ID to rowRects array. increase the rowRects counter.
  void addToCurrRow(Node rectToAdd) {
    float currY = currentRow.rowposy; 
    float currX = currentRow.rowposx; 
    float areaSum = currentRow.rowArea + rectToAdd.rectArea;
    float newRowShortSide = areaSum / currentRow.rowCanvasSide; 
    for (int i = 0; i < currentRow.numElems; i++) {      //Resize the current rectangles:
      Node nodeToResize = (Node)ParentChildMap.get(currentRow.rowRects[i]);
      resizeRect(nodeToResize, newRowShortSide, currY, currX);
      if (currentRow.rowIsVertical) {
        currY = currY + nodeToResize.rectHeight; 
      } else {
          currX = currX + nodeToResize.rectWidth;           
      }
    }
    currentRow.addToArray(rectToAdd.id); 
    rectToAdd.isPlaced = true;
    resizeRect(rectToAdd, newRowShortSide, currY, currX);
    currentRow.rowShortSide = newRowShortSide;
    currentRow.rowAspectRatio = currentRow.rowShortSide / currentRow.rowCanvasSide;
    currentRow.rowArea = currentRow.rowShortSide * currentRow.rowCanvasSide;    
  }





  //Preconditions:    currY and currX hold the positionx and positiony at which the new
  //                  rectangle would need to be placed.
void resizeRect(Node nodeToResize, float newRowShortSide, float currY, float currX){
    if (currentRow.rowIsVertical) {
       nodeToResize.rectHeight = nodeToResize.rectArea / newRowShortSide;
       nodeToResize.rectWidth = newRowShortSide;
       nodeToResize.posy = currY;
       nodeToResize.posx = currX;   
     } else {
        nodeToResize.rectHeight = newRowShortSide;          
        nodeToResize.rectWidth = nodeToResize.rectArea / newRowShortSide;
        nodeToResize.posx = currX;
        nodeToResize.posy = currY;                            
      }
}
  
  
  
  //tells the Aspect Ratio for the rectToPlace node as it would be were it to be
  //  added onto the current row.
float aspectRatioOntoRow (Node rectToPlace) {
  float areaSum = currentRow.rowArea + rectToPlace.rectArea;
  float newRowShortSide = areaSum / currentRow.rowCanvasSide;
  float c2Height = rectToPlace.rectArea / newRowShortSide;
  float c2AspectRatio = c2Height / newRowShortSide;
  return c2AspectRatio;
}
}



  

  
