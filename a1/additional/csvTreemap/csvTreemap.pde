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
int[] order = new int[] {0, 1, 2};   //TODO: Programmatically-defined order
int AMOUNT = 3;


Map ParentChildMap;
int SCREENWIDTH = 600;  
int SCREENHEIGHT = 400;  

// TODO: read in labels
void setup() {
  parseData();
  //order array
}
  
  
  
void parseData(){
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
}

// fields[] is global
int add_node(String[] fund, int[] order, Node curr_root) {
  if (order.length == 0) {        //leaf
      curr_root.total += Integer.parseInt(fund[AMOUNT]);
  }
  
}

  
