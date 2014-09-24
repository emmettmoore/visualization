import java.util.*;
// TO DO:
//    - programmatically-defined order (order array global)


// Information on Java's LinkedList and HashMap:
// http://www.tutorialspoint.com/java/java_linkedlist_class.htm
// http://docs.oracle.com/javase/7/docs/api/java/util/HashMap.html

String[] lines;
//LinkedList<LinkedList<String>> funds = new LinkedList<LinkedList<String>>();  //CSV file
List<String[]> funds = new LinkedList<String[]>();    //CSV file
String[] fields = new String[] {"department", "sponsor", "year", "amount"};
int AMOUNT = 3;
Node tree = new Node();
ArrayList<Integer> parent_keys;
ArrayList<Integer> child_keys;
Map<Integer,Integer> leaf_info;
Node root;
int count;
int num_leaves;
int num_relationships;

Map ParentChildMap;
int SCREENWIDTH = 600;  
int SCREENHEIGHT = 400;  

// TODO: read in labels
void setup() {
  count = 0;
  ParentChildMap = new HashMap<Integer, Node>();
  parent_keys = new ArrayList<Integer>();
  child_keys = new ArrayList<Integer>();
  leaf_info = new HashMap<Integer,Integer>();
  parseData();
  root = tree;
  num_leaves = leaf_info.size();
  num_relationships = parent_keys.size();
  //order array
}
  
  
  
void parseData(){
  int[] order = new int[] {0, 1, 2};   //TODO: Programmatically-defined order
  boolean firstRow = true;
  lines = loadStrings("soe.csv");//("hierarchy2.shf");
  for (int i=0; i<lines.length; i++){
     if (firstRow) {
         firstRow = false;
         continue;
     }
     String[] temp = splitTokens(lines[i], ",");
     funds.add(temp);
  }
  
  for(int i = 0; i<funds.size(); i++){
    add_node(funds.get(i), order, tree); 
  }
}

// fields[] is global
int add_node(String[] fund, int[] order, Node curr_root) {
  int added_value = 0;
  if (order.length == 0) {        //leaf
      added_value = Integer.parseInt(fund[AMOUNT]);
      curr_root.total += added_value;
      leaf_info.put(curr_root.ID,curr_root.total); 
      return added_value;
  }
  else{
      if(curr_root.children.get(fund[order[0]]) == null){
          curr_root.children.put(fund[order[0]], new Node(count,fund[order[0]]));
          parent_keys.add(curr_root.ID);
          child_keys.add(count);
          count++;
      }
      int[] newArr = Arrays.copyOfRange(order, 1, order.length);
      added_value = add_node(fund, newArr, curr_root.children.get(fund[order[0]]));
      curr_root.total += added_value;
      return added_value;
  }
}






  
