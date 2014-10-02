import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class squarifiedTreemap extends PApplet {



// Information on Java's LinkedList and HashMap:
// http://www.tutorialspoint.com/java/java_linkedlist_class.htm
// http://docs.oracle.com/javase/7/docs/api/java/util/HashMap.html

String[] lines;
Map<Integer, Integer> leafInfo;
int[] parent_keys;  //For data in file below from num_relationships. Contains repeat parents. e.g. [7, 7, 7, 7]
int[] child_keys;   //For data in file below num_relationships.
int num_leaves;
int num_relationships;
int root;
//boolean[] visited;

//Map ParentChildMap;    //HASHMAP- Key   =  integer (parent ID),
                      //          Value =  List_Node LinkedList (list of parent's child nodes)
                      
Map ParentChildMap;
 
public void setup() {
  lines = loadStrings("hierarchy2.shf");//("hierarchy2.shf");
  num_leaves = Integer.parseInt(lines[0]);
  num_relationships = Integer.parseInt(lines[num_leaves + 1]);
  leafInfo = new HashMap<Integer,Integer>();
  parent_keys = new int[num_relationships];
  child_keys = new int[num_relationships];

  ParentChildMap = new HashMap<Integer, Node>();
  parse_data();
  root = find_root();
  Populate_Hashmap();
  
}


// Using a pre-populated "lines" array, this function will
//    parse through the "lines" array and populate four arrays:
//    1. An array of leaf_keys, entitied leaf_keys
//    2. An array of leaf_values, entitled leaf_values
//    3. An array of parent ID Keys, entitled parent_keys
//    4. An array of child ID Keys, entitled child_keys
public void parse_data () {
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

public void Populate_Hashmap() {
  //add all non-leaf nodes
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

public boolean check_leaf(int node_id) {
  if (leafInfo.get(node_id) == null) {
    return false;
  }
  return true;
}

public int populate_values(Node current_root, int deepness) {
  boolean leaf = false;
  if (check_leaf(current_root.id) == true) {
    current_root.total = (Integer) leafInfo.get(current_root.id);
    //print (' ' * deepness) + id + ': ' + total
    for (int i = 0; i<deepness; i++){
      print("    ");
    }
    print(current_root.id + ": "  + current_root.total + "\n");
    return current_root.total;
  }
  
  Iterator itr = current_root.children.iterator();
  int sum_of_children = 0;
  while (itr.hasNext()) {
    int child_id = (Integer)itr.next();
    Node next_child = (Node)ParentChildMap.get(child_id);

    sum_of_children += populate_values(next_child, deepness + 1);
        for (int i = 0; i<deepness; i++){
      print("    ");
    }
    print(current_root.id + "  " + sum_of_children + "\n");
  }

  current_root.total = sum_of_children;
  return sum_of_children;
}
// Overview:  Will use parent_keys and child_keys arrays to find
//            the node which does not have a parent. Returns the
//            key of this node. Return value of -1 indicates failure
public int find_root() {
  for (int i = 0; i < num_relationships; i++) {
    int curr_parent = parent_keys[i];
    boolean matched = false;
    for (int j = 0; j < num_relationships; j++) {
      if (curr_parent == child_keys[j]) {
        matched = true;
      }
    }
    if(!matched){
      return curr_parent;
    }
  }
  return -1;
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
class Node{
  int id;  //keyID
  int total;
  SortedSet children;
  Node(int id1) {
    id = id1;
    total = 0;
    children = new TreeSet();
  }
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "squarifiedTreemap" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
