import java.util.*;
Table data; 
String path = "data/iris.csv";

//contains the header of each column from the data file
String[] headers;

//an array of arrays of floats: contains the points of each column
float [][] columns;

void setup(){
  read_data();
  data = null;
  headers = null;
}
void draw(){
  
}
void read_data(){
    data = loadTable(path,"header");
    
    int num_rows = data.getRowCount();
    headers = data.getColumnTitles();
    columns = new float[headers.length][];
    for (int i = 0; i<headers.length; i++){
        columns[i] = new float[num_rows];
        String [] temp = data.getStringColumn(headers[i]); 
        for(int j = 0; j<num_rows; j++){
          columns[i]
        }
    }
}
