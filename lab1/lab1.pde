// Rectangle class uses these.... this is fugly
int SCREEN_WIDTH = 400;
int SCREEN_HEIGHT = 300;



//loadStrings(String s)
//splitTokens(String s)
//trim(String s)

String[] lines;
String[][] data;
String[] labels;

Rectangle r;

void setup() {
  lines = loadStrings("lab1-data.csv");
  data = new String[lines.length][2];
  parse_data();
  
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  frame.setResizable(true);
  
}

void parse_data() {
  //get name/number
  labels = splitTokens(lines[0], ", ");
  //get that data boy
  for (int i=1; i < lines.length; i++) {
    String[] temp = splitTokens(lines[i], ", ");
    for (int j=0; j < 2; j++) {
      data[i][j] = temp[j];
      print(data[i][j] + "\n");
    }
  }  
}


void draw() {
  size(width, height);
}

void mouseClicked() {
  /*
  if (r.within()) {
    r.new_size();
  }
  */
}


