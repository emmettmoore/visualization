/*

class Node{
  int id;  //keyID
  int total;
  SortedSet children;
  float posx;                                       
  float posy;                                       
  float rectHeight;                               
  float rectWidth;                            
  boolean isPlaced;                               
  float rectArea;                               
  float aspectRatio;  
  String idString;               
  boolean wasPrinted;                              //TEMPORARY                              
  int depth;                    
  color printColor;
  Node(int id1) {
    id = id1;
    total = 0;
    isPlaced = false;                             
    children = new TreeSet();
    aspectRatio = 0;       
    wasPrinted = false;                              //TEMPORARY    
    depth = 0;
    printColor = BACKGROUNDCOLOR;
  }
  


void populateRectInfo(float VA_ratio) {                                       
  rectArea = total * (1/ VA_ratio);
 //populates the rect's information (e.g. area) 
  idString = Integer.toString(id);         
}

void display_rect() {                                          
  float printposX = posx + (depth * FRAMESIZE);
  float printposY = posy + (depth * FRAMESIZE);
  float printWidth = rectWidth - (depth * FRAMESIZE * 2);
  float printHeight = rectHeight - (depth * FRAMESIZE * 2);
  printColor = BACKGROUNDCOLOR;
  setColor();
  fill(printColor);
  rect(printposX, printposY, printWidth, printHeight);             
  textAlign(CENTER);                                          
  fill(TEXTCOLOR);
  text(idString, printposX + printWidth /2, printposY + printHeight/2);
  fill(BACKGROUNDCOLOR);
}

    
void setColor(){
  if (within(false)){
    int returnId = findInnermost(id, false);
    if (id == returnId) {
        printColor = color(124, 122, 122);
        return;
    } else {
        printColor = color(255, 255, 255);
        return;             
    }
 }
 printColor = color(255, 255, 255);
}

// The within() property for the currId passed in MUST
//    always be true. (A currId cannot be passed in for which
//    the "within()" would fail.)
// The boolean argument is passed in in order that it can later
//    be passed into the "within()" function.
int findInnermost(int currId, boolean recallMousePositionFromClick) {
    Iterator iter = ((Node)ParentChildMap.get(currId)).children.iterator();
    int next = currId;
    while (iter.hasNext()) {
      Integer nextOne = (Integer)(iter.next());
      if (((Node)(ParentChildMap.get((nextOne)))).within(recallMousePositionFromClick)) {
          next = findInnermost(nextOne, recallMousePositionFromClick);
          return next;
      }
    }
    return next;
}

// The boolean argument is used to indicate the context in which
//  this function is being called. Argument value passed in as
//  "True" would indicate that this
//  is the result of a mouse click, and so the stored mouse position
//  must be used to check if the mouse was within bounds. "False" would
//  indicate that this is being called in order to determine whether
//  the users current mouse position is hovering.
boolean within(boolean recallMousePositionFromClick) {
  float mouseXclick;
  float mouseYclick;
  if (recallMousePositionFromClick) {
    mouseXclick = MOUSEPOSXCLICK;
    mouseYclick = MOUSEPOSYCLICK;
  } else {
    mouseXclick = mouseX;
    mouseYclick = mouseY;
  }
    float printposX = posx + (depth * FRAMESIZE);
    float printposY = posy + (depth * FRAMESIZE);
    float printWidth = rectWidth - (depth * FRAMESIZE * 2);
    float printHeight = rectHeight - (depth * FRAMESIZE * 2);
    if ((printposX <= mouseXclick) && (mouseXclick <= printposX + printWidth)) {
      if ((printposY <= mouseYclick) && (mouseYclick <= printposY + printHeight)) {
        if (ININIT) {        //Only in the case that the user has moved his mouse
          return false;      //  (resulting in an intentional mouse position of 0,0
                             //   as opposed to a preset one) should this actually highlight the cell.
        }
        return true;
      }
    }
    return false;
  }
}
 
 
 */

