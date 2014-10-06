//doesn't work with negatives as of now
//let the user specify the color of the hovered bar color
int NUM_INTERVALS = 10;
float SMALLEST_Y_AXIS_LABEL = 0;  //y axis value for the graph to start at.
//chart states
int NOCHART = 0;
int ONECHART = 1;
int ANIMATING = 2;

  BarGraph bar_graph;
  LineGraph line_graph;
  PieGraph pie_graph;
  boolean lineGraph;
  boolean pieGraph;
  boolean barGraph;
class ChartController{   
  float posx, posy, w, h;
  color backgroundColor;
  color hoverColor;
  color barColor;
  float screenwidth, screenheight;
  String[] keys;
  float[] values;
  float[] labels1;
  

  Rectangle GraphOutline;
  

  int state;
  ChartController(float screenwidth1, float screenheight1, float w1, float h1,float posx1, float posy1, String[] keys1, float[] values1, String[]labels1, color barColor1, color backgroundColor1, color hoverColor1){ //taylor likes this
     posx = posx1;
     posy = posy1;
     w = w1;
     h = h1;
     backgroundColor = backgroundColor1;
     hoverColor = hoverColor1;
     barColor = barColor1;
     screenwidth = screenwidth1;
     screenheight = screenheight1;
     keys = keys1.clone();
     values = values1.clone();
     labels = labels1.clone();
     lineGraph = barGraph = pieGraph = false;

     state = NOCHART;
  }
  
  //where everything is called - basically this class' draw function
  void Update(ArrayList animQueue) {
    if (animQueue.size() == 0) {
      line_graph = new LineGraph(posx,posy,w,h, keys, values, labels, backgroundColor, hoverColor);
      bar_graph = new BarGraph(posx,posy,w,h, keys, values, labels, barColor, backgroundColor, hoverColor);
      pie_graph = new PieGraph((screenwidth* (3/4f)), (screenheight * (1/2f)), screenwidth/2, screenheight/2, keys, values);
      state = NOCHART;
      return;
    } 
    else if (animQueue.size() == 1) {
      state = ONECHART;
      if ((Integer)animQueue.get(0) == LINECHART) {
        line_graph.Update();
      } else if ((Integer)animQueue.get(0) == BARCHART) {
         bar_graph.Update();
      } else if ((Integer)animQueue.get(0) == PIECHART) {
        pie_graph.Update();
      }
    } 
    else if (animQueue.size() > 1) {
      state = ANIMATING;
      if ((Integer)animQueue.get(0) == LINECHART) {
        if ((Integer)animQueue.get(1) == BARCHART) {
          
          if (line_graph.animateToBar() == false) {
            animQueue.remove(0);
          }
        } else if ((Integer)animQueue.get(1) == PIECHART) {
          if (line_graph.animateToPie() == false) {
            animQueue.remove(0);
          }
        }
      } else if ((Integer)animQueue.get(0) == BARCHART) {
          if ((Integer)animQueue.get(1) == LINECHART) {
            if (bar_graph.animateToLine() == false) {
            animQueue.remove(0);
            }
          } else if ((Integer)animQueue.get(1) == PIECHART) {
            if (bar_graph.animateToPie() == false) {
            animQueue.remove(0);
            }  
          }
      } else if ((Integer)animQueue.get(0) == PIECHART) {
         if ((Integer)animQueue.get(1) == LINECHART) {
           if (pie_graph.animateToLine() == false) {
           animQueue.remove(0);
           }
          } else if ((Integer)animQueue.get(1) == BARCHART) {
            if (pie_graph.animateToBar() == false) {
            animQueue.remove(0);
            } 
          }
      }
    }
        updateSizes();

      
  }
  void updateSizes(){
     bar_graph.w = width*6/10;
     bar_graph.h = height*6/10;
     bar_graph.posx = width* 2/10;
     bar_graph.posy = height*1/10;
     line_graph.w = width*6/10;
     line_graph.h = height*6/10;
     line_graph.posx = width* 2/10;
     line_graph.posy = height*1/10;
          pie_graph.posx = width * (3/4f);              //TAYLOR likes this
     pie_graph.posy = height * (1/2f); 
//     pie_graph.posx = width/2;              //TAYLOR likes this
//     pie_graph.posy = height/2;  //TAYLOR likes this
     pie_graph.calculateDiameter();
  }
}

