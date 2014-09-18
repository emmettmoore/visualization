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

