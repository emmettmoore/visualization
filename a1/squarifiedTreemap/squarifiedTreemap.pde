import java.util.*;

// Information on Java's LinkedList and HashMap:
// http://www.tutorialspoint.com/java/java_linkedlist_class.htm
// http://docs.oracle.com/javase/7/docs/api/java/util/HashMap.html

String[] lines;
Map leafInfo;
int[] parent_keys;  //For data in file below from num_relationships. Contains repeat parents. e.g. [7, 7, 7, 7]
int[] child_keys;   //For data in file below num_relationships.
int num_leaves;
int num_relationships;
int root;
//boolean[] visited;

//Map ParentChildMap;    //HASHMAP- Key   =  integer (parent ID),
                      //          Value =  List_Node LinkedList (list of parent's child nodes)
                      
Map ParentChildMap;                      
 
void setup() {
  lines = loadStrings("hierarchy2.shf");//("hierarchy2.shf");
  num_leaves = Integer.parseInt(lines[0]);
  num_relationships = Integer.parseInt(lines[num_leaves + 1]);
  leafInfo = new HashMap<Integer,Integer>();
  parent_keys = new int[num_relationships];
  child_keys = new int[num_relationships];

  ParentChildMap = new HashMap<Integer, Node>();
  parse_data();
  Populate_Hashmap();
  int root = find_root();
  sample_test2();
  
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
      /*int value = 0;
      if(leafInfo.containsKey(child_keys[i])){
          value = (Integer)leafInfo.get(child_keys[i]);   //initializes leaf value 
      }*/
      Node temp;
      if(ParentChildMap.containsKey(parent_keys[i])){
          temp = (Node)ParentChildMap.get(parent_keys[i]);  
      }
      else{ 
          temp = new Node(parent_keys[i]);
      }
      /*if(value != 0){
         temp.total = temp.total + value;                //initalizes leaf value 
      }*/                                            //but recursion deals with that
      temp.children.add(child_keys[i]);      
      ParentChildMap.put(parent_keys[i],temp);
  }
}

int populate_values(Node current_root) {
  if (current_root.children.size() != 0) {
    current_root.total = (Integer) leafInfo.get(current_root.id);
    return current_root.total;
  }
  Iterator itr = current_root.children.iterator();
  int sum_of_children = 0;
  while (itr.hasNext()) {
    int element = (Integer)itr.next();
    sum_of_children += populate_values((Node)ParentChildMap.get(element));
  }
  current_root.total = sum_of_children;
  return sum_of_children;
}
// Overview:  Will use parent_keys and child_keys arrays to find
//            the node which does not have a parent. Returns the
//            key of this node. Return value of -1 indicates failure
int find_root() {
  for (int i = 0; i < num_relationships; i ++) {
    for (int j = 0; j < num_relationships; j ++) {
      if (parent_keys[i] == child_keys[j]) {
          break;
      }
      if (j == num_relationships - 1) {
        return parent_keys[i];
      }
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
