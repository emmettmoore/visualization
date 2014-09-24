class Node2 {
 int total;
 String field;
 int ID;
 Map<String, Node2> children = new HashMap<String, Node2>();
  
  Node2() {
    total = 0;
    ID = -1;
    field = "";
  }
  Node2(int ID1, String field1) {
    ID = ID1;
    field = field1;
    total = 0;
  }
}
