import java.util.*;

Integer SCREENWIDTH = 600;
Integer SCREENHEIGHT = 600;

String[] labels;
List<String[]> days = new LinkedList<String[]>();
String[] lines;


void setup() {
  parseData();
  size(SCREENWIDTH, SCREENHEIGHT); 
}

void parseData(){
  boolean firstRow = true;
  lines = loadStrings("Dataset1.csv");
  for (Integer i=0; i<lines.length; i++){
     if (firstRow) {
         labels = splitTokens(lines[i], ",");
         firstRow = false;
         continue;
     }
     String[] temp = splitTokens(lines[i], ",");
     days.add(temp);
  }
  
  print(labels);
  print('\n');
  for(Integer i = 0; i<days.size(); i++){
       print(days.get(i));
       print('\n');
  }
  
}
