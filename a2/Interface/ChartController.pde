//doesn't work with negatives as of now
//let the user specify the color of the hovered bar color
int NUM_INTERVALS = 10;
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
  Rectangle GraphOutline;
  

  int state;
  ChartController(float screenwidth, float screenheight, float w1, float h1,float posx1, float posy1, String[] keys, float[] values, String[]labels, color barColor, color backgroundColor, color hoverColor){
     posx = posx1;
     posy = posy1;
     w = w1;
     h = h1;
     lineGraph = barGraph = pieGraph = false;
     line_graph = new LineGraph(posx,posy,w,h, keys, values, labels, backgroundColor, hoverColor);
     bar_graph = new BarGraph(posx,posy,w,h, keys, values, labels, barColor, backgroundColor, hoverColor);
     pie_graph = new PieGraph(posx, posy, screenwidth/2, screenheight/2, keys, values);
     state = NOCHART;
  }
  
  //where everything is called - basically this class' draw function
  void Update(ArrayList animQueue) {

    updateSizes();
    
    if (animQueue.size() == 0) {
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
     pie_graph.posx = width/2;              //TAYLOR
     pie_graph.posy = height/2 - height/8;  //TAYLOR
     pie_graph.calculateDiameter();
  }
}

