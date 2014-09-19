class Canvas{
  int id;
  int value;
  Row currentRow;        //NEED TO WRITE THIs class
  double heightRemaining;
  double widthRemaining;
//  double posx;
//  double posy;
  int[] childrenByTotal;
  //double initialHeight;
  //double initialWidth;
  //double initialArea;
  //double initialposx;
  //double initialposy;
  Canvas (int id1, double canvasHeight, double canvasWidth) {
    id = id1;
    value = 0;
    heightRemaining = canvasHeight;
    widthRemaining = canvasWidth;
  }
  

 
 // do i need to pass in parentchildmap?
 void canvasInfo(int canvasId) {               //Populates canvas information
 sortChildrenByTotal();
 }
 
// Node nextRect() {            //retruns the next rect to be made into a rectangle
// }


//Bubble sort algorithm from this page:
//   https://www.cs.cmu.edu/~adamchik/15-121/lectures/Sorting%20Algorithms/sorting.html
void sortChildrenByTotal() {    //Populate childrenByTotal array usng ParentChildMap
   int arraySize= ((Node)ParentChildMap.get(id)).children.size();
   childrenByTotal = new int[arraySize];

//  int[] array = (int[])((Node)ParentChildMap.get(id)).children.toArray();
  Arrays.sort(array);
//   for (int i = arraySize - 1; i >= 0; i--) {
//      for (int j = 1; j <= i; j++ ) {
//        if (
}
  
}
  
