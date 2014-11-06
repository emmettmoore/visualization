float BUFFER = 30; 
//color[] COLORS = new color[color(50, 55, 100), color(246, 41, 157), color(48, 246, 41)];
color[] COLORS = new color[] {color(50, 55, 100), color(246, 41, 157), color(48, 246, 41), color(50, 55, 100), color(246, 41, 157), color(48, 246, 41)};

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
//  color x = color(50, 55, 100);
//  color y = color(246, 41, 157);
//  color z = 
//  COLORS = new color[color(50, 55, 100), color(246, 41, 157), color(48, 246, 41)];

  data = null;
  headers = null;
  read_data();
  lines = new vertical_line[headers.length];
//  float interval = width/lines.length;        //taylor comment out
float interval = width/(lines.length -1);
//  for(int i = 0; i<lines.length; i++){        //CHANGE TO: lines.length - 1.
 for(int i = 0; i<lines.length -1; i++){        //CHANGE TO: lines.length - 1.    TAYLOR
    lines[i] = new vertical_line(headers[i],columns[i],interval/2 + interval*i, BUFFER, height-BUFFER*2, columns[lines.length -1]);
  }  
  drawTemp(); // so that the real draw function (drawTemp) only executes once
}
void draw() {  //so that the real draw function (drawTemp) only executes once
}
void drawTemp(){
  int i;
  for(i = 0; i<lines.length-2;i++){
     lines[i].Display(); 
     lines[i].connect_to_line(lines[i+1]);  //uncomment this when ready to connect lines
  }
  lines[i].Display();      //TAYLOR COMMENTED OUT
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
//       print (columns[0][i]); 
    }
}
