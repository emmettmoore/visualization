// Rectangle class uses these.... this is fugly
int SCREEN_WIDTH = 400;
int SCREEN_HEIGHT = 300;



//loadStrings(String s)
//splitTokens(String s)
//trim(String s)

String[] lines;
String[][] data;
String[] labels;

Rectangle BarLineButton;

void setup() {
  lines = loadStrings("lab1-data.csv");
  data = new String[lines.length][2];
  parse_data();
  
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  frame.setResizable(true);
  
  BarLineButton = new Rectangle(width/10,height/10,width - 9/10*width,9/10*height, "switch", color(100,100,20));
}

void parse_data() {
  //sloppy but sets the maxVal super low so that we can't
  float maxVal = -100000000;
  //get name/number
  labels = splitTokens(lines[0], ", ");
  //get that data boy
  for (int i=1; i < lines.length; i++) {
    String[] temp = splitTokens(lines[i], ", ");
    
    //finds the maximum value that we can use as a range
    if(maxVal < Float.parseFloat(temp[1])){
      maxVal = Float.parseFloat(temp[1]);
    }
      
    for (int j=0; j < 2; j++) {
      data[i][j] = temp[j];
      print(data[i][j] + "\n");
    }
  }  
}


void draw() {
  size(width, height);
  redrawButton();
}

void mouseClicked() {
  if (BarLineButton.within()) {
    print("switch state now");
  }
}

void redrawButton(){
  BarLineButton.draw_me(width/10,height/10,width - width/10, 0, "switch", color(100,100,20));
}

