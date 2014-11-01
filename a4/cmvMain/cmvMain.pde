String fn = "data_aggregate.csv"; //"ex2.csv";

String[] headers;
Table data;
//an array of arrays of floats: contains the points of each column
String [][] rows;
import java.util.*;
cmvSystem system;

void setup() {
  size(1200,800);
  background(250,250,250);  
  data = null;
  headers = null;
  read_data();
  test_data();

  frame.setResizable(true);
  textFont(createFont("Arial",12));
  
  
}

void draw() {
  

}

void read_data(){
    data = loadTable(fn,"header");
    
    int num_rows = data.getRowCount();
    headers = data.getColumnTitles();
    int num_col = headers.length;
    rows = new String[num_rows][];
    int index = 0;
    for (TableRow row : data.rows()) {
      rows[index] = new String[num_col];
      for(int i = 0; i<num_col; i++){
          rows[index][i] = row.getString(headers[i]);
      }
      index++;
    }
}

void test_data(){
   for(int i = 0; i<rows.length; i++){
      for (int j = 0; j<rows[0].length; j++){
        print (rows[i][j] + ' ');   
      }
      print('\n');
   }
} 



