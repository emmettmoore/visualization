



String fn = "data_aggregate.csv"; //"ex2.csv";

String[] headers;
Table data;
//an array of arrays of floats: contains the points of each column
String [][] data;
import java.util.*;
cmvSystem system;

void setup() {
  size(1200,800);
  background(250,250,250);
  input = null;
  headers = null;
  read_data();
  test_data();

  frame.setResizable(true);
  textFont(createFont("Arial",12));
  
  
}

void draw() {
  

}

void read_data(){
    input = loadTable(fn,"header");
    
    int num_rows = input.getRowCount();
    headers = input.getColumnTitles();
    int num_col = headers.length;
    data = new String[num_rows][];
    int index = 0;
    for (TableRow row : input.rows()) {
      data[index] = new String[num_col];
      for(int i = 0; i<num_col; i++){
          data[index][i] = row.getString(headers[i]);
      }
      index++;
    }
}

void test_data(){
   for(int i = 0; i<data.length; i++){
      for (int j = 0; j<data[0].length; j++){
        print (data[i][j] + ' ');   
      }
      print('\n');
   }
} 



