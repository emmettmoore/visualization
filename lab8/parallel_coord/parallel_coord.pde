float BUFFER = 30;

import java.util.*;
Table data; 
String path = "data/iris.csv";

//contains the header of each column from the data file
String[] headers;
vertical_line [] lines;

//an array of arrays of floats: contains the points of each column
float [][] columns;

void setup(){
  size(600,400);
  background(250,250,250);
  data = null;
  headers = null;
  read_data();
  lines = new vertical_line[headers.length];
  float interval = width/lines.length;
  for(int i = 0; i<lines.length; i++){
    lines[i] = new vertical_line(headers[i],columns[i],interval/2 + interval*i, BUFFER, height-BUFFER*2);
  }  
}
void draw(){
  int i;
  for(i = 0; i<lines.length-1;i++){
     lines[i].Display(); 
     //lines[i].connect_to_line(line[i+1]);  //uncomment this when ready to connect lines
  }
  lines[i].Display();
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
          columns[i][j] = Float.parseFloat(temp[j]);
        }
    }
    for(int i = 0; i<num_rows; i++){
       print (columns[0][i]); 
    }
}
