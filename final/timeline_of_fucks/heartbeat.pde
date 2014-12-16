//this is the class for the line and the dot for the line
//TODO: slow down the lines at before and after the biggest peak
//TODO: - incorporate heart rate of 0
//      - srart with putting some line before the small lump
//TODO: - set a minimum allowable heartrate
//- include in updateLightVariables() step to check if the ball has gone outside the bounds of the screen
//CURRENTLY: look at the display, and decide to dark the outer-most two circles that I am displaying
  
    int MIN_ALLOWABLE_INVERSE = 29;//29 cause of color fade-off.  without color fade-off this can be 20
class heartbeat{
  int[] xSteps;
  int[] ySteps;
  boolean isNewCircle = true;
//  float opacity = 255;
float opacity = 0;
  boolean hasBlur = false;
  int BASELINEX = 0;
//  int BASELINEX = 30;
  int BASELINEY = 150;
  int ARRAYSIZE = 401;
  int NUMCYCLES = 1;
  int MIN_ALLOWABLE_INVERSE = 29;//29 cause of color fade-off.  without color fade-off this can be 20
  int MAX_ALLOWABLE_INVERSE = 400;
//  int NUMCYCLES = 3;//number of full heartbeat cycles to display on the line
  int MAXARRAYINDEX= 80;  //highest index of the array. This is calculated based largely on the   //JUST COMMENTED OUT
  int inverseHeartRate = 80;
  int SCALEAMOUNT = 2;
  int WAITTIME = 0;  //LEAVE THIS at 0
  int AVERAGEHEARTRATE = 80;  //THIS IS A CONSTANT. No matter what, the average heart rate is an 80.
  int localHeartRate = 80;
  int gridCounter = 0;
  int GRID_CUBE_LENGTH = 5;
  
  int LightCurrIndex = 0;// current index of the light, index applies to xSteps and ySteps array
  int LightCurrCycle = 0;// current cycle number
  int currWaitTime = 0;
  
  Circle light;
  Circle light2;
  Circle light3;
  Circle light4;  
  Circle light5;
  Circle light6;
  float StrokeAlpha2;
  float StrokeAlpha3;
  float StrokeAlpha4;
  float StrokeAlpha5;
  float StrokeAlpha6;
  //TODO: change this to take in the number of fucks per movie
  heartbeat(int baseLineX, int baseLineY, int BeatsPerMinute) {
    BASELINEX = baseLineX;
    BASELINEY = baseLineY;
    inverseHeartRate = BeatsPerMinute;//TEMPORARY until i add other assignments to AssignHeartData
    //MAXARRAYINDEX = BeatsPerMinute;
    AssignHeartData();  //TODO: change this to take in the argument of number fucks per movie
    
    light = new Circle(BASELINEX, BASELINEY, 3, color(0, 0, 0)); 
    light2 = new Circle(BASELINEX, BASELINEY, 4, color(186, 0, 25, 150));
    light3 = new Circle(BASELINEX, BASELINEY, 5, color(186, 0, 25, 100));
    light4 = new Circle(BASELINEX, BASELINEY, 6, color(186, 0, 25, 50));
    light5 = new Circle(BASELINEX, BASELINEY, 7, color(186, 0, 25, 25));
    light6 = new Circle(BASELINEX, BASELINEY, 8, color(186, 0, 25, 5));
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
      //stroke(30);
    int xCurrBaseline = BASELINEX;
    for(int cycleCount = 0; cycleCount < NUMCYCLES; cycleCount++) {
      int i;
      for (i = 0; i < MAXARRAYINDEX; i++) {
//        strokeWeight(3);
strokeWeight(1);                                //JUST CHANGED THIS
        if (isNewCircle == true) {
//          stroke(color(186, 0, 25), 255/opacity); // 0 to 255, 0 is see-through
        stroke(color(186, 0, 25), opacity - (MAXARRAYINDEX/2f)); 
//        StrokeAlpha2 = (opacity - (MAXARRAYINDEX/2f)) - 50;        //NEW 
//        StrokeAlpha3 = (opacity - (MAXARRAYINDEX/2f)) - 100;        //NEW
//        StrokeAlpha4 = (opacity - (MAXARRAYINDEX/2f)) - 150;      //NEW
        StrokeAlpha5 = (opacity - (MAXARRAYINDEX/2f)) - 180; //(MAXARRAYINDEX/2f)) - 175;        //NEW
//        StrokeAlpha6 = (opacity - (MAXARRAYINDEX/2f)) - 190;      //NEW
        
        
//          opacity = opacity - 1;
            opacity = opacity + 1;
            if (opacity >= 255) {
              opacity = 0;
//          if (opacity <= 1) {
            //opacity = 255;
            isNewCircle = false;
          }
        } else {
          stroke(color(186, 0, 25));
        StrokeAlpha2 = 150;        //NEW 
        StrokeAlpha3 =  100;        //NEW
        StrokeAlpha4 = 50;      //NEW
        StrokeAlpha5 = 40;//25;        //NEW
        StrokeAlpha6 = 30;//5;      //NEW
        }
//        stroke(color(186, 0, 25));
        line(xCurrBaseline + (xSteps[i]*SCALEAMOUNT), BASELINEY + (ySteps[i]*SCALEAMOUNT), xCurrBaseline + (xSteps[i+1]*SCALEAMOUNT), BASELINEY + (ySteps[i+ 1]*SCALEAMOUNT));
/*
        if (gridCounter == GRID_CUBE_LENGTH) {
          stroke(color(186, 0, 25), StrokeAlpha6);
        for (int q = 0; q < 130; q = q + 15) {
                  
          line(xCurrBaseline + (xSteps[i]*SCALEAMOUNT), BASELINEY - 65 + q, xCurrBaseline + (xSteps[i +1]* SCALEAMOUNT) + 30, BASELINEY - 65 + q);
        }
        }
       //drawing lines on background:
       
       if (gridCounter == GRID_CUBE_LENGTH) {
         stroke(color(186, 0, 25), StrokeAlpha6);
         float makeX = (xCurrBaseline + (xSteps[i]*SCALEAMOUNT) + 150) - ((xCurrBaseline + (xSteps[i]*SCALEAMOUNT) + 150)%10);
         line(makeX, BASELINEY - 100, makeX, BASELINEY + 50);
         
         
       //stroke(color(186, 0, 25), StrokeAlpha6);
       //line(xCurrBaseline + (xSteps[i]*SCALEAMOUNT) + 150, BASELINEY - 150, xCurrBaseline + (xSteps[i]*SCALEAMOUNT) + 150, BASELINEY + 50);
       if ((ySteps[i + 1] == -61) || (ySteps[i + 1] == 23) || (i + 4 == (13 + (MAXARRAYINDEX/10)))) {
        // line(xCurrBaseline + (xSteps[i]*SCALEAMOUNT) + 5, BASELINEY - 150, xCurrBaseline + (xSteps[i]*SCALEAMOUNT) + 5, BASELINEY + 50);
       }
       gridCounter = 0;
       } else{
         gridCounter++;
       }
       */
        //NEW STUFF:
        /*
        strokeWeight(2);
        stroke(color(186, 0, 25), StrokeAlpha2);
        line(xCurrBaseline + (xSteps[i]*SCALEAMOUNT), BASELINEY + (ySteps[i]*SCALEAMOUNT), xCurrBaseline + (xSteps[i+1]*SCALEAMOUNT), BASELINEY + (ySteps[i+ 1]*SCALEAMOUNT));
        strokeWeight(3);
        stroke(color(186, 0, 25), StrokeAlpha3);
        line(xCurrBaseline + (xSteps[i]*SCALEAMOUNT), BASELINEY + (ySteps[i]*SCALEAMOUNT), xCurrBaseline + (xSteps[i+1]*SCALEAMOUNT), BASELINEY + (ySteps[i+ 1]*SCALEAMOUNT));

        strokeWeight(4);
        stroke(color(186, 0, 25), StrokeAlpha4);
        line(xCurrBaseline + (xSteps[i]*SCALEAMOUNT), BASELINEY + (ySteps[i]*SCALEAMOUNT), xCurrBaseline + (xSteps[i+1]*SCALEAMOUNT), BASELINEY + (ySteps[i+ 1]*SCALEAMOUNT));
  */
        strokeWeight(5);
        stroke(color(186, 0, 25), StrokeAlpha5);
        line(xCurrBaseline + (xSteps[i]*SCALEAMOUNT), BASELINEY + (ySteps[i]*SCALEAMOUNT), xCurrBaseline + (xSteps[i+1]*SCALEAMOUNT), BASELINEY + (ySteps[i+ 1]*SCALEAMOUNT));
/*
        strokeWeight(6);
        stroke(color(186, 0, 25), StrokeAlpha6);
        line(xCurrBaseline + (xSteps[i]*SCALEAMOUNT), BASELINEY + (ySteps[i]*SCALEAMOUNT), xCurrBaseline + (xSteps[i+1]*SCALEAMOUNT), BASELINEY + (ySteps[i+ 1]*SCALEAMOUNT));
  */      
        

        
        
        
        if ((i == LightCurrIndex)&&(cycleCount == LightCurrCycle)&&(currWaitTime == WAITTIME)) {//make light shine
                //filter(BLUR, 1);
            light = new Circle((xCurrBaseline + xSteps[i]*SCALEAMOUNT), (BASELINEY + ySteps[i]*SCALEAMOUNT), 3, color(186, 0, 25));//ORIGINAL
 /*
            light2 = new Circle((xCurrBaseline + xSteps[i]*SCALEAMOUNT), (BASELINEY + ySteps[i]*SCALEAMOUNT), 4, color(186, 0, 25, 150));
           light3 = new Circle((xCurrBaseline + xSteps[i]*SCALEAMOUNT), (BASELINEY + ySteps[i]*SCALEAMOUNT), 5, color(186, 0, 25, 100));
            light4 = new Circle((xCurrBaseline + xSteps[i]*SCALEAMOUNT), (BASELINEY + ySteps[i]*SCALEAMOUNT), 6, color(186, 0, 25, 50));
            */
            light5 = new Circle((xCurrBaseline + xSteps[i]*SCALEAMOUNT), (BASELINEY + ySteps[i]*SCALEAMOUNT), 5, color(186, 0, 25, 100));//25));
            light6 = new Circle((xCurrBaseline + xSteps[i]*SCALEAMOUNT), (BASELINEY + ySteps[i]*SCALEAMOUNT), 7, color(186, 0, 25, 75));//5));
            
              isNewCircle = true;
              
        }
  
      }
        xCurrBaseline = xCurrBaseline + xSteps[i]*SCALEAMOUNT;
    }
  light.Display();
//  light2.Display();
//  light3.Display();
//  light4.Display();
  light5.Display();
  light6.Display();

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
//        hasBlur = false;
    }
    
  }
}//

}



void populateYSteps(){
  int i;
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
 
  for (i = 13; i < (13 + (MAXARRAYINDEX/10)); i++) {
    ySteps[i] = 0;
  }  //for MAXARRAYINDEX, ySteps[20] will have just been given 0.
// ySteps[13] = 0;//jump forwards to the first heart beat

ySteps[i] = -61;
// ySteps[14] = -61;//-55;//peak of heartbeat
ySteps[i+1] = 23;
// ySteps[15] = 23;//lowest point of heartbeat
ySteps[i+2] = 0;
// ySteps[16] = 0;//back to baseline
 
//ySteps[i+3] = 0;  //there will always be at least 3 ticks after peak heartbeat, before large hump afterwards. this is the first tick
//ySteps[i+4] = 0;  //this is the second tick. (These will be here regardless of heart rate)
//ySteps[i+5] = 0;
 int temp = i + 3;//TRYING THIS
// int temp = i + 6;// the index of the NEXT element to be populated. (for heart rate 80, this will be 27
for (i = temp; i < (temp + (MAXARRAYINDEX/10)); i++) {  //this way, by default, heart rate of 80 will always be exactly 8 ticks here
  ySteps[i] = 0;
}  //for MAXARRAYINDEX of 80, ysteps[27] will have just been given 0
// ySteps[17] = 0;//jump forward to large lump after heartbeat
ySteps[i] = 0;
// ySteps[18] = 0; //large lump after heart beat (this looks like an extra tick)
ySteps[i+1] = -1;
// ySteps[19] = -1;
ySteps[i+2] = -2;
// ySteps[20] = -2;
ySteps[i+3] = -3;
// ySteps[21] = -3;
ySteps[i+4] = -5;
// ySteps[22] = -5;
ySteps[i+5] = -6;
// ySteps[23] = -6;
ySteps[i+6] = -6;
// ySteps[24] = -6;
ySteps[i+7] = -7;
// ySteps[25] = -7;
ySteps[i+8] = -8;
// ySteps[26] = -8;
ySteps[i+9] = -9;
// ySteps[27] = -9;
ySteps[i+10] = -9;
// ySteps[28] = -9;
ySteps[i+11] = -10;
// ySteps[29] = -10;
ySteps[i+12] = -10;
// ySteps[30] = -10;
ySteps[i+13] = -9;
// ySteps[31] = -9;
ySteps[i+14] = -8;
// ySteps[32] = -8;
ySteps[i+15] = -4;
// ySteps[33] = -4;
ySteps[i+16] = -3;
// ySteps[34] = -3;
ySteps[i+17] = -2;
// ySteps[35] = -2;
ySteps[i+18] = -1;
// ySteps[36] = -1;
ySteps[i+19] = 0;
// ySteps[37] = 0;
ySteps[i+20] = 0;
// ySteps[38] = 0;//jump forward to the start of next sequence
ySteps[i+21] = 0;
// ySteps[39] = 0;
int temp3 = i + 22;
for ( i = temp3; i < MAXARRAYINDEX; i++) {
//for (i = 40; i< MAXARRAYINDEX; i++) {
  ySteps[i] = 0;
}
ySteps[MAXARRAYINDEX] = 0;

}


void populateXSteps(){
  int i;
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
  for (i = 13; i < (13 + (MAXARRAYINDEX/10)); i++) {
    xSteps[i] = i;
  }  //for MAXARRAYINDEX, xSteps[20] will have just been given 20.
  //xSteps[13] = 20;//jump forwards to first heart beat. TODO: multiply this by fraction of real heart beat?

  xSteps[i] = i + 2;//because i was already iterated up one in the loop. peak of heartbeat
  //xSteps[14] = 23;//peak of heartbeat
xSteps[i+1] = i + 5;
//  xSteps[15] = 26;//lowest point of heartbeat
xSteps[i+2] = i + 8;
//  xSteps[16] = 29;//back to baseline


//xSteps[i+3] = i + 9;  //there will always be at least 3 ticks after peak heartbeat, before large hump afterwards. this is the first tick
//xSteps[i+4] = i + 10;  //this is the second tick. (These will be here regardless of heart rate)
//xSteps[i+5] = i + 11;  //this is the third one. now the normal heart rate (80) can be used in the next step:
int temp = i + 3;//TRYING THIS
int endOfPostPeakTicks = i + 9;//TRYING THIS
//int temp = i + 6;// the index of the NEXT element to be populated. (for heart rate 80, this will be 27
//int endOfPostPeakTicks = i + 12; // the x value for the last tick that was made after the peak , PLUS ONE.
for (i = temp; i < (temp + (MAXARRAYINDEX/10)); i++) {  //this way, by default, heart rate of 80 will always be exactly 8 ticks here
  xSteps[i] = endOfPostPeakTicks;
  endOfPostPeakTicks++;
}//for heart rate of 80, xSteps[27] will have just been given 40.
//  xSteps[17] = 40;//43;//jump forward to large lump after heartbeat
xSteps[i] = endOfPostPeakTicks;  //because both i and endOf will have just been iterated in the loop
//    xSteps[18] = 41;//large lump after heart beat
xSteps[i+1] = endOfPostPeakTicks + 1;
// xSteps[19] = 42;
xSteps[i+2] = endOfPostPeakTicks + 2;
// xSteps[20] = 43;
xSteps[i + 3] = endOfPostPeakTicks + 3;
// xSteps[21] = 44;
xSteps[i+4] = endOfPostPeakTicks + 4;
// xSteps[22] = 45;
xSteps[i+5] = endOfPostPeakTicks + 5;
// xSteps[23] = 46;
xSteps[i+6] = endOfPostPeakTicks + 5;//same as last
// xSteps[24] = 46;
xSteps[i+7] = endOfPostPeakTicks + 6;
// xSteps[25] = 47;
xSteps[i+8] = endOfPostPeakTicks + 7;
// xSteps[26] = 48;
xSteps[i+9] = endOfPostPeakTicks + 8;
// xSteps[27] = 49;
xSteps[i+10] = endOfPostPeakTicks + 8; // same as last
// xSteps[28] = 49;
xSteps[i+11] = endOfPostPeakTicks + 10;
// xSteps[29] = 51;
 //downward slope begins:
 int temp2 = i+ 12;
 int downwardSlope = endOfPostPeakTicks + 11;
 for (i = temp2; i < (temp2 + 9); i++) {
   xSteps[i] = downwardSlope;
   downwardSlope++;
 }
//downward slope begins:
/*
 xSteps[30] = 52;
 xSteps[31] = 53;
 xSteps[32] = 54;
 xSteps[33] = 55;
 xSteps[34] = 56;
 xSteps[35] = 57;
 xSteps[36] = 58;
 xSteps[37] = 59;
 xSteps[38] = 60;
 */

 
// int i;
int temp3 = i;  //because "i" will have already been iterated
for (i = temp3; i < MAXARRAYINDEX; i++) {
// for (i = 39; i<MAXARRAYINDEX; i++) {
//   xSteps[i] = 22 + i;
xSteps[i] = downwardSlope;
downwardSlope++;
 }
// xSteps[39] = 85;
xSteps[MAXARRAYINDEX] = downwardSlope;
//xSteps[MAXARRAYINDEX] = 22 + i;//101;
print(22 + i + "\n");

}


void AssignHeartData() {
  //TODO: given the numer of f words per movie, calculate these numbers: (including LocalHeartRate)
  //TODO: calculate InverseHeartRate
  MAXARRAYINDEX = inverseHeartRate;
  
  if ((MIN_ALLOWABLE_INVERSE <= inverseHeartRate) && (inverseHeartRate <= 39)) {
   NUMCYCLES = 9;
  } else if ((40 <= inverseHeartRate) && (inverseHeartRate <= 51)) {
   NUMCYCLES = 8;
  } else if ((52 <= inverseHeartRate) && (inverseHeartRate <= 61)) {
   NUMCYCLES = 7;
  } else if ((62 <= inverseHeartRate) && (inverseHeartRate <= 74)) {
   NUMCYCLES = 6;
  } else if ((75 <= inverseHeartRate) && (inverseHeartRate <= 94)) {
    NUMCYCLES = 5;
  } else if ((95 <= inverseHeartRate) && (inverseHeartRate <= 127)) {
    NUMCYCLES = 4;
  } else if ((128 <= inverseHeartRate) && (inverseHeartRate <= 194)) {
    NUMCYCLES = 3;
  } else if ((195 <= inverseHeartRate) && (inverseHeartRate <= 393)) {
    NUMCYCLES = 2;
  } else if ((394 <= inverseHeartRate) && (inverseHeartRate <= MAX_ALLOWABLE_INVERSE)) {
    NUMCYCLES = 1;
  }
  
}

}
