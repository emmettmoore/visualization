import java.util.*;
// Information on Java's LinkedList and HashMap:
// http://www.tutorialspoint.com/java/java_linkedlist_class.htm
// http://docs.oracle.com/javase/7/docs/api/java/util/HashMap.html

//Map<Integer, Integer> leafInfo;
int[] parent_keys;  //For data in file below from num_relationships. Contains repeat parents. e.g. [7, 7, 7, 7]
int[] child_keys;   //For data in file below num_relationships.
int num_leaves;
int num_relationships;
int root;

Map ParentChildMap;
int SCREENWIDTH = 600;  
int SCREENHEIGHT = 400;  

void setup() {
  lines = loadStrings("hierarchy2.shf");//("hierarchy2.shf");
  print(line);
  /*
  num_leaves = Integer.parseInt(lines[0]);
  num_relationships = Integer.parseInt(lines[num_leaves + 1]);
  leafInfo = new HashMap<Integer,Integer>();
  parent_keys = new int[num_relationships];
  child_keys = new int[num_relationships];
  */

  //ParentChildMap = new HashMap<Integer, Node>();

  //size(SCREENWIDTH, SCREENHEIGHT); 
  //NUMCLICKS = 0;  
  //parse_data();

  //root = find_root();
  //Populate_Hashmap();
  //primary(root);    
  //CopyParentChildMap = new HashMap<Integer, Node>(ParentChildMap);    //TAYLOR ADDING FOR ZOOM

}
            
//Function: primary()
// This function is similar to a manager function.          


// Note: this will set the posx and posy for the root node as 0,0.
//        It will also set the height and width of the root rectangle as SCREENHEIGHT and SCREENWIDTH.
void primary(int root) {
//  int root = find_root();
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
  toPrint = (Node)ParentChildMap.get(root);
  toPrint.display_rect();
  printIt(root);
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
          print("root is: ");
          print(root);
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




// Using a pre-populated "lines" array, this function will
//    parse through the "lines" array and populate four arrays:
//    1. An array of leaf_keys, entitied leaf_keys
//    2. An array of leaf_values, entitled leaf_values
//    3. An array of parent ID Keys, entitled parent_keys
//    4. An array of child ID Keys, entitled child_keys
void parse_data () {
  int curr_lines_index = 1;
  for (int i = 0; i < num_leaves; i++) {
    String[] temp = splitTokens(lines[curr_lines_index], " ");
    leafInfo.put(Integer.parseInt(temp[0]),Integer.parseInt(temp[1]));
    curr_lines_index++;
  }
  curr_lines_index = num_leaves+2;  // now sitting on first parent-child line
  for (int i = 0; i < num_relationships; i++) {
    String[] temp = splitTokens(lines[curr_lines_index], " ");
    parent_keys[i] = Integer.parseInt(temp[0]);
    child_keys[i] = Integer.parseInt(temp[1]);
    curr_lines_index++;
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
//    for (int i = 0; i<deepness; i++){
//      print("    ");
//    }
//    print(current_root.id + ": " + current_root.total + "\n");
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



  /*                            //TEMPORARY FUNCTION
void sample_test() {
  List<List_Node> child_list = new LinkedList<List_Node>();
  child_list = (List<List_Node>)ParentChildMap.get(parent_keys[1]);
  List_Node child_node = child_list.get(9);    
  print(child_node.keyID);    //for file 2 should print 13
  print(" ");
  print(child_list.size());  // for file 2 should print 13
  print(" ");
}
*/
/*
void sample_test2() {
  int first, second;
for (int i = 0; i<7; i++) {
//  for (int i = 0; i < num_relationships; i++) {
    Node temp = (Node)ParentChildMap.get(i); 
    first = (Integer)temp.children.first(); 
    print(first);
    print(" ");
    second = (Integer)temp.children.last(); 
    print(second);
    print("\n");
  }

}
*/
