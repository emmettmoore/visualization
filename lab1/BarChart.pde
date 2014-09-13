int BUFFER = 10;
class BarChart{
  Rectangle GraphOutline;
  float w, h, posx, posy;
  String[] keys,labels;
  float[] values;
  color barColor;
  color backgroundColor;
  float maxOfValues;
  float minOfValues;
  BarChart(float w1, float h1, float posx1, float posy1, String[] keys1, float[] values1, String[]labels1, color barColor1, color backgroundColor1){
    //data initialization; 
    w = w1;
     h = h1;
     posx = posx1;
     posy = posy1;
     keys = keys1;
     labels = labels1;
     values = values1;
     barColor = barColor1;
     backgroundColor = backgroundColor1;
     Display();
  }
  
  void Display(){
    GraphOutline = new Rectangle(w, h, posx,posy, "", backgroundColor);
    drawLabels();
  }
  void drawLabels(){
    fill(0, 102, 153);
    textAlign(LEFT);
    text(labels[1],BUFFER, posy + h/2);
        textAlign(CENTER); 
    text(labels[0],posx + w/2, height - BUFFER);
    labelAxes();
    
  }
  void labelAxes(){
    findMaxMin(); 
    //print(maxOfValues + " " + minOfValues + "\n");
  }
  
  void findMaxMin(){
    maxOfValues = values[0];
    minOfValues = values[0];
    for(int i = 1; i<values.length;i++){
      print(values[i] + "\n");
       if(maxOfValues < values[i]){
         maxOfValues = values[i]; 
       }
       if(minOfValues > values[i]){
         print(minOfValues + "\n");
         minOfValues = values[i];
       }
    }
  }
}
