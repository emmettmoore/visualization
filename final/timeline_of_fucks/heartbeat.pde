//this is the class for the line and the dot for the line
  int BASELINEX = 30;
  int BASELINEY = 150;
  int ARRAYSIZE = 100;
  int NUMCYCLES = 3;//number of full heartbeat cycles to display on the line
  int MAXARRAYINDEX= 80;  //highest index of the array. This is calculated based largely on the 
  int SCALEAMOUNT = 2;
  int WAITTIME = 0;
  
class heartbeat{
  int[] xSteps;
  int[] ySteps;

  int LightCurrIndex = 0;// current index of the light, index applies to xSteps and ySteps array
  int LightCurrCycle = 0;// current cycle number
  int currWaitTime = 0;
  
  Circle light;
  
  
  heartbeat() {

    light = new Circle(BASELINEX, BASELINEY, 3, color(0, 0, 0)); 
    xSteps = new int[ARRAYSIZE];
    ySteps = new int[ARRAYSIZE];
    populateXSteps(); 
    populateYSteps();
  }


void update() {
  createHeartBeat();
}


void createHeartBeat(){
  updateLightVariables();
  light.Display();
      stroke(30);
    int xCurrBaseline = BASELINEX;
    for(int cycleCount = 0; cycleCount < NUMCYCLES; cycleCount++) {
      int i;
      for (i = 0; i < MAXARRAYINDEX; i++) {
//        line(BASELINEX + (xSteps[i]*SCALEAMOUNT), BASELINEY + (ySteps[i]*SCALEAMOUNT), BASELINEX + (xSteps[i+1]*SCALEAMOUNT), BASELINEY + (ySteps[i+ 1]*SCALEAMOUNT));
        line(xCurrBaseline + (xSteps[i]*SCALEAMOUNT), BASELINEY + (ySteps[i]*SCALEAMOUNT), xCurrBaseline + (xSteps[i+1]*SCALEAMOUNT), BASELINEY + (ySteps[i+ 1]*SCALEAMOUNT));
        if ((i == LightCurrIndex)&&(cycleCount == LightCurrCycle)&&(currWaitTime == WAITTIME)) {//make light shine
            //ellipse((xCurrBaseline + xSteps[i]*SCALEAMOUNT), (BASELINEY + ySteps[i]*SCALEAMOUNT), 3, 3);
            light = new Circle((xCurrBaseline + xSteps[i]*SCALEAMOUNT), (BASELINEY + ySteps[i]*SCALEAMOUNT), 3, color(0, 0, 0));
        }
  
      }
        xCurrBaseline = xCurrBaseline + xSteps[i]*SCALEAMOUNT;
    }

}



void updateLightVariables(){
  if (currWaitTime < WAITTIME) {
      currWaitTime++;
  }else {
      currWaitTime = 0;
  //}
      if (LightCurrIndex < MAXARRAYINDEX -1) {
        LightCurrIndex++;
      } else {
        LightCurrIndex = 0;
//                if (LightCurrCycle < NUMCYCLES) {

        if (LightCurrCycle < (NUMCYCLES - 1)) {
          LightCurrCycle++;
      } else {
        LightCurrCycle = 0;
    }
    
  }
}//
}
void populateYSteps(){
 ySteps[0] = 0;  //Small lump before heartbeat
 ySteps[1] = -1;
 ySteps[2] = -3;
 ySteps[3] = -4;
 ySteps[4] = -5;
 ySteps[5] = -6;
 ySteps[6] = -6;
 ySteps[7] = -5;
 ySteps[8] = -4;  
 ySteps[9] = -2;//-3;
 ySteps[10] = -1;
 ySteps[11] = 0;//-1;
 ySteps[12] = 0;//end of small lump
 
 ySteps[13] = 0;//jump forwards to the first heart beat
 ySteps[14] = -61;//-55;//peak of heartbeat
 ySteps[15] = 23;//lowest point of heartbeat
 ySteps[16] = 0;//back to baseline
 
 ySteps[17] = 0;//jump forward to large lump after heartbeat
 ySteps[18] = 0;
 ySteps[19] = -1;
 ySteps[20] = -2;
 ySteps[21] = -3;
 ySteps[22] = -5;
 ySteps[23] = -6;
 ySteps[24] = -6;
 ySteps[25] = -7;
 ySteps[26] = -8;
 ySteps[27] = -9;
 ySteps[28] = -9;
 ySteps[29] = -10;
 ySteps[30] = -10;
 ySteps[31] = -9;
 ySteps[32] = -8;
 ySteps[33] = -4;
 ySteps[34] = -3;
 ySteps[35] = -2;
 ySteps[36] = -1;
 ySteps[37] = 0;
 ySteps[38] = 0;//jump forward to the start of next sequence
 ySteps[39] = 0;
for (int i = 40; i< MAXARRAYINDEX; i++) {
  ySteps[i] = 0;
}
ySteps[MAXARRAYINDEX] = 0;

}

void populateXSteps(){
  xSteps[0] = 0;//Start of small lump before heart beat
   xSteps[1] = 1;
  xSteps[2] = 2;
  xSteps[3] = 3;
  xSteps[4] = 4;
  xSteps[5] = 5;
  xSteps[6] = 6;
  xSteps[7] = 7;
  xSteps[8] = 8;
  xSteps[9] = 9;
  xSteps[10] = 10;
  xSteps[11] = 11;
  xSteps[12] = 12;//End of small lump
  
  xSteps[13] = 20;//jump forwards to first heart beat. TODO: multiply this by fraction of real heart beat?
  xSteps[14] = 23;//peak of heartbeat
  xSteps[15] = 26;//lowest point of heartbeat
  xSteps[16] = 29;//back to baseline
  
  xSteps[17] = 40;//43;//jump forward to large lump after heartbeat
    xSteps[18] = 41;
 xSteps[19] = 42;
 xSteps[20] = 43;
 xSteps[21] = 44;
 xSteps[22] = 45;
 xSteps[23] = 46;
 xSteps[24] = 46;
 xSteps[25] = 47;
 xSteps[26] = 48;
 xSteps[27] = 49;
 xSteps[28] = 49;
 xSteps[29] = 51;
 xSteps[30] = 52;
 xSteps[31] = 53;
 xSteps[32] = 54;
 xSteps[33] = 55;
 xSteps[34] = 56;
 xSteps[35] = 57;
 xSteps[36] = 58;
 xSteps[37] = 59;
 xSteps[38] = 60;
 for (int i = 39; i<MAXARRAYINDEX; i++) {
   xSteps[i] = 22 + i;
 }
// xSteps[39] = 85;
xSteps[MAXARRAYINDEX] = 101;


}


}
