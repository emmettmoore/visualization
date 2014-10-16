int canvasWidth = MIN_INT; // this would be initialized in setup

LineGraph scatterPlot;
void draw() {
    clearCanvas();

//ALL THINGS TEMPORARY --------------  
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
//------- ALL THINGS TEMPORARY
  /**
   ** Finish this:
   **
   ** you should draw your scatterplot here, on rect(0, 0, canvasWidth,canvasWidth) (CORNER)
   ** axes and labels on axes are required
   ** the hovering is optional
   **/
}
