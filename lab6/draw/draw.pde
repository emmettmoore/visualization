int canvasWidth = MIN_INT; // this would be initialized in setup

LineGraph scatterPlot;
void draw() {
    clearCanvas();
if ((keysX != null) && (valuesY != null)) {
if ((keysX.length > 0) && (valuesY.length > 0)) {
  scatterPlot = new LineGraph(canvasWidth * 1/10, height* 1/20, canvasWidth - (canvasWidth*1/10) - 10, height - (height*1/10), keysX, valuesY, color(250,250,250), color(255,255,105));
scatterPlot.Update();
  } }
  /**
   ** Finish this:
   **
   ** you should draw your scatterplot here, on rect(0, 0, canvasWidth,canvasWidth) (CORNER)
   ** axes and labels on axes are required
   ** the hovering is optional
   **/
}
