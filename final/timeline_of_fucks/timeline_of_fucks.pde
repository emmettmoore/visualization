import java.util.*;

String fi = "wowFuckInstances.csv";
String rf = "recordedFucks.csv";

String [] fuck_strings;
String [] fuck_timestamps;
void setup(){
 parse_data(); 
 
  
}
void draw(){
  
}

void parse_data(){
  
  Table table = loadTable(fi);
  int index = 0;
  fuck_timestamps = new String[table.getRowCount()];
  for (TableRow row : table.rows()) {
      fuck_timestamps[index] = row.getString(0);
      index++;
  }
  table = loadTable (rf);
  index = 0;
  fuck_strings = new String[table.getRowCount()];
  for (TableRow row : table.rows()) {
      fuck_strings[index] = row.getString(0);
      index++;
  }
}
