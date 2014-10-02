import java.util.*;


String[] lines;
//LinkedList<LinkedList<String>> funds = new LinkedList<LinkedList<String>>();  //CSV file
List<String[]> funds = new LinkedList<String[]>();    //CSV file
String[] fields = new String[] {"department", "sponsor", "year", "amount"};
Integer AMOUNT = 3;
Node2 tree = new Node2();
ArrayList<Integer> parent_keys2;
ArrayList<Integer> child_keys2;
ArrayList<String> parent_fields2;        //TAYLOR
ArrayList<String>  child_fields2;          //TAYLOR
Map<Integer,Integer> leafInfo;
//Node2 root;
Integer count = 1;
Integer num_leaves;
Integer num_relationships;

Map ParentChildMap;
Integer SCREENWIDTH = 1200;  
Integer SCREENHEIGHT = 700; 
Integer[] parent_keys;
Integer[] child_keys;
Integer root;
Map CopyParentChildMap;
Integer FRAMESIZE = 2;
Integer NUMCLICKS;                    //Will be used for zooming in and out
float MOUSEPOSXCLICK;              //Will store the position of mouse at time click occurs
float MOUSEPOSYCLICK;              //Will store the position of mouse at time click occurs
color BACKGROUNDCOLOR = color(255, 255, 255);  //White
color HIGHLIGHTCOLOR = color(124, 122, 122);  //Gray
color TEXTCOLOR = color(0, 0, 0);             //Black
boolean ININIT = true;                //used to record once the mouse has moved for prIntegering initial Node2

//TAYLOR ADDING:
float BARSPACING;
float BARWIDTH;
float XAXISLENGTH;
float YAXISLENGTH;
float HIGHESTTOTAL;
float TEMPX;
void setup() {
  TEMPX = 0;  
  count = 0;
  ParentChildMap = new HashMap<Integer, Node>();
  parent_keys2 = new ArrayList<Integer>();
  child_keys2 = new ArrayList<Integer>();
  
  parent_fields2 = new ArrayList<String>();       
  child_fields2 = new ArrayList<String>();            
  
  leafInfo = new HashMap<Integer,Integer>();
  parseData();


  num_leaves = leafInfo.size();
  num_relationships = parent_keys2.size();
  
    copyArrays();
    
 
  size(SCREENWIDTH, SCREENHEIGHT); 
  NUMCLICKS = 0;  
    root = find_root();

  Populate_Hashmap();
  primary(root);    
  CopyParentChildMap = new HashMap<Integer, Node>(ParentChildMap);   
}

 
void parseData(){
  Integer[] order = new Integer[] {2, 0, 1};  
  boolean firstRow = true;
  lines = loadStrings("soe.csv");//("hierarchy2.shf");
  for (Integer i=0; i<lines.length; i++){
     if (firstRow) {
         firstRow = false;
         continue;
     }
     String[] temp = splitTokens(lines[i], ",");
     funds.add(temp);
  }
  
  for(Integer i = 0; i<funds.size(); i++){
    add_Node2(funds.get(i), order, tree); 
  }
  
}

// fields[] is global
Integer add_Node2(String[] fund, Integer[] order, Node2 curr_root) {
  Integer added_value = 0;
  if (order.length == 0) {        //leaf
      added_value = Integer.parseInt(fund[AMOUNT]);
      curr_root.total += added_value;
      leafInfo.put(curr_root.ID,curr_root.total); 
      return added_value;
  }
  else{
      if(curr_root.children.get(fund[order[0]]) == null){
          curr_root.children.put(fund[order[0]], new Node2(count,fund[order[0]]));
          
          parent_keys2.add(curr_root.ID);
          child_keys2.add(count);
          parent_fields2.add(curr_root.field);
          child_fields2.add(fund[order[0]]);
          count++;      //Number of leaves
      }
      Integer[] newArr = Arrays.copyOfRange(order, 1, order.length);
      added_value = add_Node2(fund, newArr, curr_root.children.get(fund[order[0]]));
      curr_root.total += added_value;
      return added_value;
  }
}

void copyArrays(){
  parent_keys = parent_keys2.toArray(new Integer[parent_keys2.size()]);
  child_keys = child_keys2.toArray(new Integer[child_keys2.size()]);
}



// Note: this will set the posx and posy for the root node as 0,0.
//        It will also set the height and width of the root rectangle as SCREENHEIGHT and SCREENWIDTH.
void primary(Integer root) {

  Node temp = (Node)ParentChildMap.get(root);  
  temp.rectHeight = SCREENHEIGHT;
  temp.rectWidth = SCREENWIDTH;
  temp.posx = 0;                                    //NOTE: this is a sketchy place/way to set this.
  temp.posy = 0;                                    //NOTE: this is a sketchy place/way to set this.
  temp.idString = Integer.toString(root);          //NOTE: this is a sketchy place/way to set this.
temp.printColor = BACKGROUNDCOLOR;
  fillAll(root);
  
}


void fillAll(int parentId) {
  if (leafInfo.containsKey(parentId)) {
    return;
  }
  float canvHeight =   ((Node)ParentChildMap.get(parentId)).rectHeight;  
  float canvWidth =   ((Node)ParentChildMap.get(parentId)).rectWidth;
  Canvas currCanvas = new Canvas(parentId, canvHeight, canvWidth); //TEMPORARY
  currCanvas.canvasInfo(parentId);
  putRectsOnCanvas(currCanvas);
  
  
  Iterator itr = ((Node)ParentChildMap.get(parentId)).children.iterator();
  while (itr.hasNext()) {
      fillAll((Integer)itr.next());
    }
}

  




void putRectsOnCanvas(Canvas currCanvas){       
  Node rectToPlace = currCanvas.nextRect();
  while (rectToPlace != null) {
  if (currCanvas.currentRow.numElems != 0) {     //If the row already has elements in it  
      float c2AspectRatio = currCanvas.aspectRatioOntoRow(rectToPlace);
      if (worse(c2AspectRatio, currCanvas.currentRow.rowAspectRatio)) {
        currCanvas.newRow();
      }
      currCanvas.addToCurrRow(rectToPlace);
  } else {                                      //If the current row is already empty  
    currCanvas.addToCurrRow(rectToPlace);   
  }                                                 
    rectToPlace.isPlaced = true;
    rectToPlace = currCanvas.nextRect();
  }
}



// New draw() for zoom:
void draw() {
  size(SCREENWIDTH, SCREENHEIGHT); 
  background(250, 250, 250);
  Node toPrint;
  if (mousePressed) {
    if (mouseButton == LEFT) {
      mousePressed = false;
      MOUSEPOSXCLICK = pmouseX;  //Record the mouse position when the click occurred
      MOUSEPOSYCLICK = pmouseY;
      zoomIn();
    }
    if (mouseButton == RIGHT) {
      mousePressed = false;
      MOUSEPOSXCLICK = pmouseX;  //Record the mouse position when the click occurred
      MOUSEPOSYCLICK = pmouseY;
      zoomOut();
    }
  }
  
  
  
 Iterator iter2 = ((Node)ParentChildMap.get(root)).children.iterator();
  //primary((Integer)iter2.next());                //TEMPORARY
  while (iter2.hasNext()) {
    Integer thisOne = ((Integer)iter2.next());
    toPrint = (Node)ParentChildMap.get(thisOne);
    toPrint.display_rect();
    printIt(thisOne);
  }

}

void printIt(int printId) {
   if (leafInfo.containsKey(printId)) {
    return;
  }
   Iterator itr = ((Node)ParentChildMap.get(printId)).children.iterator();
    while (itr.hasNext()) {
      Node toPrint = (Node)ParentChildMap.get((Integer)itr.next());
      if (toPrint.isPlaced) {
        toPrint.display_rect();
      }
    }
    Iterator iter = ((Node)ParentChildMap.get(printId)).children.iterator();
    while (iter.hasNext()) {
      printIt((Integer)iter.next());
    }
}


//WILL modify the global "root" variable.
void zoomIn() {
  int zoomRoot = root;
  boolean recallMousePositionFromClick = true;
  if (((Node)ParentChildMap.get(zoomRoot)).within(recallMousePositionFromClick)) {

     zoomRoot = ((Node)ParentChildMap.get(zoomRoot)).findInnermost(zoomRoot, recallMousePositionFromClick);
     if (zoomRoot == root) {      //In the case that it was already zoomed to the leafNode, do nothing.
       return;
     }
     root = zoomRoot;
     resetNodesForZoom(zoomRoot);
     primary(zoomRoot);
     NUMCLICKS++;
  }
} 

//The mouse(x,y) position is initialized to (0,0). Thus, in order to
//  keep the root node (the top left corner of which is located at 0,0) from
//  highlighting when the user has not put his mouse over the node, it is necessary
//  to keep track of when the mouse has finally been moved, indicating that the user
//  actually has put his mouse on (0,0).
void mouseMoved() {
  ININIT = false;
}

//WILL modify the global "root" variable
void zoomOut() {
  int zoomOutRoot = root;
  int currRootDepth = ((Node)ParentChildMap.get(zoomOutRoot)).depth;
  if (currRootDepth > 0) {
      ParentChildMap = new HashMap<Integer, Node>(CopyParentChildMap); 
        if (currRootDepth == 1) {
          root = find_root();
          zoomOutRoot = root;

      } else {
          for (int i = 0; i < num_relationships; i++) {
            if (child_keys[i] == root) {
              zoomOutRoot = parent_keys[i];
              break;
            }
          }
          root = zoomOutRoot;
      }
          resetNodesForZoom(zoomOutRoot);
          primary(zoomOutRoot);
          NUMCLICKS--;
  }
}


//Resets the "isPlaced" variable to false.
void resetNodesForZoom(int root){
  ((Node)ParentChildMap.get(root)).isPlaced = false;
  Iterator itr = ((Node)ParentChildMap.get(root)).children.iterator();
  while (itr.hasNext()) {
    int tempRoot = (Integer)itr.next();
    ((Node)ParentChildMap.get(tempRoot)).isPlaced = false;
    resetNodesForZoom(tempRoot);
    }
}


void Populate_Hashmap() {
  for (int i = 0; i < num_relationships; i++){
      Node temp;
      if(ParentChildMap.containsKey(parent_keys[i])){
          temp = (Node)ParentChildMap.get(parent_keys[i]);  
      }
      else{ 
          temp = new Node(parent_keys[i]);
      }
      temp.children.add(child_keys[i]);
      ParentChildMap.put(parent_keys[i],temp);
  }
  //add all leaf nodes
  for (int i = 0; i < num_leaves; i++){
    Node temp;
    for (int key : leafInfo.keySet() ) {
      ParentChildMap.put((Integer)key, new Node((Integer) key));
    }
  }

  populate_values((Node)ParentChildMap.get(root), 0);
}


boolean check_leaf(int node_id) {
  if (leafInfo.get(node_id) == null) {
    return false;
  }
  return true;
}

int populate_values(Node current_root, int deepness) {
    boolean leaf = false;
    if (check_leaf(current_root.id) == true) {
    current_root.total = (Integer) leafInfo.get(current_root.id);
    return current_root.total;
  }
  
  Iterator itr = current_root.children.iterator();
  int sum_of_children = 0;
  while (itr.hasNext()) {
    int child_id = (Integer)itr.next();
    Node next_child = (Node)ParentChildMap.get(child_id);
    next_child.depth = deepness + 1; //This is used to add the frame to the display

    sum_of_children += populate_values(next_child, deepness + 1);
  }
  current_root.total = sum_of_children;
  return sum_of_children;
}



// Overview:  Will use parent_keys and child_keys arrays to find
//            the node which does not have a parent. Returns the
//            key of this node. Return value of -1 indicates failure

int find_root() {
  for (int i = 0; i < num_relationships; i++) {
      int curr_parent = parent_keys[i];
      boolean matched = false;
      for (int j = 0; j < num_relationships; j++) {
        if (curr_parent == child_keys[j]) {
          matched = true;
      }
    }
    if (!matched) {
      return curr_parent;
    }
  }
  return -1;
}


  

//Returns true if the aspect ratio ratioA is further from 1 than the aspect
//    ratio ratioB. Returns false if they are equally as far.
boolean worse(float ratioA, float ratioB) {
  if (abs(1 - ratioA) > abs(1- ratioB)) {        
    return true;
  } else {
    return false;
  }
}






  
