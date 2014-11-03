int TIME_STAMP = 0;
int SRC_IP = 1;
int SRC_PORT = 2;
int DEST_IP = 3;
int DEST_PORT = 4;
int SYSLOG = 5;
int OP = 6;
int PROTOCOL = 7;

int CATEGORY = 0;
int NETWORK = 1;
int HEAT = 2;

String fn = "data_aggregate.csv"; //"ex2.csv";
import java.util.*;
String[] headers;

cmvSystem system;

void setup() {
  //frame.setResizable(true);
  size(1200,800);
  background(100,250,250);
  //frame.setResizable(true);
  headers = null;
  String[][] data = read_data();  
  textFont(createFont("Arial",12));
  system = new cmvSystem(read_data(), headers);
  textFont(createFont("Arial",12));
}

void draw() {
  //system.update();
}

String[][] read_data(){
    Table input;input = null;
    String [][] data;
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
    return data;
}
