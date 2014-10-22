int canvasWidth = MIN_INT; // this would be initialized in setup

LineGraph scatterPlot;
void draw() {
    clearCanvas();

//ALL THINGS TEMPORARY --------------  
//organize keys before putting in
  String[] keysTEMPORARY = new String[3];
  keysTEMPORARY[0] = "4.15";
  keysTEMPORARY[1] = "4.17";
  keysTEMPORARY[2] = "4.9";
    float[] valuesTEMPORARY = new float[3];
  valuesTEMPORARY[0] = 6.2;
  valuesTEMPORARY[1] = 8.1;
  valuesTEMPORARY[2] = 7.3;
  if (keysX != null) {
  scatterPlot = new LineGraph(canvasWidth * 1/10, height* 1/20, canvasWidth - (canvasWidth*1/10), height - (height*1/10), keysX, valuesY, color(250,250,250), color(255,255,105));
scatterPlot.Update();
  }
  //FIND where the fill is messing up so chart is black
//scatterPlot = new LineGraph(canvasWidth * 1/10, height* 1/20, canvasWidth - (canvasWidth*1/10), height - (height*1/10), keysTEMPORARY, valuesTEMPORARY, color(250,250,250), color(255,255,105));
//scatterPlot.Update();
/*
  String[] keysTEMPORARY = new String[3];
  keysTEMPORARY[0] = "cow";
  keysTEMPORARY[1] = "horse";
  keysTEMPORARY[2] = "cat";
  float[] valuesTEMPORARY = new float[3];
  valuesTEMPORARY[0] = 6;
  valuesTEMPORARY[1] = 7;
  valuesTEMPORARY[2] = 8;
  String[] labelsTEMPORARY = new String[2];
  labelsTEMPORARY[0] = "animals";
  labelsTEMPORARY[1] = "age";

rect(0, 0, canvasWidth, canvasWidth);
scatterPlot = new LineGraph(0, 0, canvasWidth, canvasWidth, keysTEMPORARY, valuesTEMPORARY, labelsTEMPORARY, 0, 100);
scatterPlot.Update();
*/
//------- ALL THINGS TEMPORARY
  /**
   ** Finish this:
   **
   ** you should draw your scatterplot here, on rect(0, 0, canvasWidth,canvasWidth) (CORNER)
   ** axes and labels on axes are required
   ** the hovering is optional
   **/
}
