import java.util.*;
Table data; 
String path = "data/iris.csv";
String[] header;
void setup(){
  read_data();
  data = null;
  header = null;
}
void draw(){
  
}
void read_data(){
    data = loadTable(path,"header");
    header = data.getColumnTitles();
    /*for (int i = 0; i<header.length; i++){
        print(header[i]); 
    }*/
}
