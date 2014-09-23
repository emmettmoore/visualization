import java.util.*;
// TO DO:
//    - programmatically-defined order (order array global)


// Information on Java's LinkedList and HashMap:
// http://www.tutorialspoint.com/java/java_linkedlist_class.htm
// http://docs.oracle.com/javase/7/docs/api/java/util/HashMap.html

String[] lines;
LinkedList<LinkedList<String>> funds = new LinkedList<LinkedList<String>>();  //CSV file
String[] fields = ["department", "sponsor", "year", "amount"];
int[] order = [0, 1, 2];    //TODO: Programmatically-defined order


Map ParentChildMap;
int SCREENWIDTH = 600;  
int SCREENHEIGHT = 400;  

void setup() {
  lines = loadStrings("soe.csv");//("hierarchy2.shf");
  for (int i=0; i<lines.length; i++){

  }
}
