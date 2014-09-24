class Node {
 int total;
 String field;
 int ID;
 Map<String, Node> children = new HashMap<String, Node>();
  
  Node() {
    total = 0;
    ID = -1;
    field = "";
  }
  Node(int ID1, String field1) {
    ID = ID1;
    field = field1;
    total = 0;
  }
}
