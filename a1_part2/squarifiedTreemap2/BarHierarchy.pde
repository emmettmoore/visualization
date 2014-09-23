import java.util.*;

int SCREENWIDTH = 600;
int SCREENHEIGHT = 400;


String[] lines;
String[] departments;
String[] sponsors;
//int[] years;
String[] years;
String[] totals;
//int[] totals;
String[] categories;    //to have four elements-- PI Department, Sponsor, Year, Total
Map<Integer, String> intsToDepts;
Map<Integer, String> intsToSpons;
Map<Integer, String> intsToCats;    // 0 ==> categories[0] ==> Pi Department
                                     // 1 ==> categories[1] ==> Sponsor ...etc



void setup() {
  lines = loadStrings("soe-funding.csv");
    size(SCREENWIDTH, SCREENHEIGHT); 
    print(lines.length);
//parse_data();
//  populateArraysTest();                      //TEMPORARY
  
//  intsToDepts = new HashMap<Integer, String>();
//  intsToSpons = new HashMap<Integer, String>();
//  intsToCats = new HashMap<Integer, String>();
//  populateIntMappings();

//  createTree(2, 1, 0, 3);
  
}



/*
void parse_data () {
  int curr_lines_index = 1;
  for (int i = 0; i < num_leaves; i++) {
    String[] temp = splitTokens(lines[curr_lines_index], " ");
    leafInfo.put(Integer.parseInt(temp[0]),Integer.parseInt(temp[1]));
    curr_lines_index++;
  }
  curr_lines_index = num_leaves+2;  // now sitting on first parent-child line
  for (int i = 0; i < num_relationships; i++) {
    String[] temp = splitTokens(lines[curr_lines_index], " ");
    parent_keys[i] = Integer.parseInt(temp[0]);
    child_keys[i] = Integer.parseInt(temp[1]);
    curr_lines_index++;
  }

}
*/



void populateIntMappings(){
  for (int i = 0; i < departments.length; i++) {
    intsToDepts.put(i, departments[i]);
  }
  int integer = departments.length;
  for (int i = 0; i < sponsors.length; i++) {
    intsToSpons.put(integer, sponsors[i]);
    integer++;
  }
//  integer = departments.length;
  for (int i = 0; i < categories.length; i++) {
    intsToCats.put(i, categories[i]);
  }
}

//Year, Sponsor, PI Department, Total
/*
void createTree(int level1, int level2, int level3, int level4) {
  string title1 = categories[1];
  for (int i = 0; i < title1.length; i ++ ) {
    Node NewNode = new Node(title1[i]);
    NewNode.Children
    SortedSet childrenList = NewNode.Children
  
  
}
*/

/*
void populateArraysTest() {
  departments = new String[10];
  sponsors = new String[10];
  years = new int[10];
  totals = new int[10];
  categories = new String[4];
  categories[0] = "PI Department";
  categories[1] = "Sponsor";
  categories[2] = "Year";
  categories[3] = "Total";
  departments[0] = "Biomedical Engineering";
  departments[1] = "Biology";
  departments[2] = "Chemical Engineering";
  departments[3] = "Chemical Engineering";
  departments[4] = "Civil & Envir Engineering";
  departments[5] = "Comp Sci";
  departments[6] = "Comp Sci";
  departments[7] = "Mechanical Engineering";
  departments[8] = "Mechanical Engineering";
  departments[9] = "Mechanical Engineering";
  sponsors[0] = "NSF";
  sponsors[1]= "NSF";
  sponsors[2]= "NSF";
  sponsors[3] = "NIH";
  sponsors[4]= "NIH";
  sponsors[5]= "NIH";
  sponsors[6] = "Draper Labs";
  sponsors[7]= "NASA";
  sponsors[8]= "NASA";
  sponsors[9] = "Draper Labs";
  years[0] = 2011;
  years[1] = 2011;
  years[2] = 2007;
  years[3] = 2010;
  years[4] = 2007;
  years[5] = 2011;
  years[6] = 2012;
  years[7] = 2009;
  years[8] = 2008;
  years[9] = 2012;
  totals[0] = 553902;
  totals[1] = 1723;
  totals[2] = 435609;
  totals[3] = 412858;
  totals[4] = 75724;
  totals[5] = 1099187;
  totals[6] = 132000;
  totals[7] = 1134882;
  totals[8] = 1252981;
  totals[9] = 114000;

}
  */
            
