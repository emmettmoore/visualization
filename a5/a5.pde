//TO DO : 
//                - choose how to have participant IDs found




import controlP5.*;
import java.util.Random;

final int DECIDE_YOURSELF = -1; // This is a placeholder for variables you will replace.

/**
 * This is a global variable for the dataset in your visualization. 
 You'll be overwriting it each trial.
 */
Data d = null;
float[] pieValues;
int[] ORDER;       //To hold the three elements: 0, 1, 2 in a random order.
int POSITION;      //To hold the current index position within the ORDER array
int chartType;  //To hold the current chart type, which will be ORDER[POSITION]
PieGraph pie;
int PIEBUFFER = 5;    //number of pixels of blank space displayed between edges of pie graph and rectangle containing graph
boolean isDisplaying = false;  //If the pie for the current switch has already been created and displayed once
void setup() {

    totalWidth = displayWidth;
    totalHeight = displayHeight;
    chartLeftX = totalWidth / 2.0 - chartSize / 2.0;
    chartLeftY = totalHeight / 2.0 - chartSize / 2.0 - margin_top;

    size((int) totalWidth, (int) totalHeight);
    //if you have a Retina display, use the line below (looks better)
    //size((int) totalWidth, (int) totalHeight, "processing.core.PGraphicsRetina2D");

    background(255);
    frame.setTitle("Comp150-07 Visualization, Lab 5, Experiment");

    cp5 = new ControlP5(this);
    pfont = createFont("arial", fontSize, true); 
    textFont(pfont);
    page1 = true;


    d = null;   
    
//    ORDER = new int[3];       
ORDER = new int[5];            //A5
    populateOrderArray();     
    chartType = ORDER[0];     
    POSITION = -1;             

    partipantID = PARTID;
}

void draw() {
    textSize(fontSize);
    int min;
    int max;
    int random1;
    int random2;
    if (index < 0 && page1) {
        drawIntro();
        page1 = false;
    } else if (index >= 0 && index < vis.length) {
        if (index == 0 && page2) {
            clearIntro();
            drawTextField();
            drawInstruction();

            page2 = false;
        }

        if (!isDisplaying) {
          if (POSITION < ORDER.length-1) {
            POSITION = POSITION + 1;
            chartType = ORDER[POSITION];
          }
        }
        switch (chartType) {
            case -1: // This is a placeholder, you can remove it and use the other cases for the final version
                 stroke(0);
                 strokeWeight(1);
                 fill(255);
                 rectMode(CORNER);
               
                 rect(chartLeftX, chartLeftY, chartSize, chartSize);
                 break;
            case 0:          //Dots are contiguous
              if (isDisplaying) {
 
                break;
              }
                d = new Data();        
                min = 1;
                max = 9;
                random1 = randomInt(min, max);
                random2 = (random1 + 1) % 9;
                markFlags(random1, random2);
                stroke(0);
                populateValuesArray();
                pie = new PieGraph(chartLeftX + chartSize/2, chartLeftY + chartSize/2, chartSize - PIEBUFFER, chartSize - PIEBUFFER, null, pieValues, false);
                pie.Update();
                drawMarks();   
                isDisplaying = true;
                break;
            case 1://Dots are NOT contiguous
                if (isDisplaying) {   
                   break;
                 }
                d = new Data();        
                min = 1;
                max = 9;
                random1 = randomInt(min, max);
                random2 = randomInt(min, max);
                while ((random1 - 1 == random2) || (random1 + 1 == random2) || (random1 == random2)) {
                  random2 = randomInt(min, max);          //ensure that dots are not same, and are not contiguous
                }
                markFlags(random1, random2);
                stroke(0);
                populateValuesArray();
                pie = new PieGraph(chartLeftX + chartSize/2, chartLeftY + chartSize/2, chartSize - PIEBUFFER, chartSize - PIEBUFFER, null, pieValues, false);
                pie.Update();
                drawMarks();
                isDisplaying = true;
                break;
            case 2:      //wedges are in increasing size. dots are allowed to be contig
               if (isDisplaying) {
                   break;
                 }
                d = new Data();        
                min = 1;
                max = 9;
                random1 = randomInt(min, max);
                random2 = randomInt(min, max);
                while  (random1 == random2) {
                  random2 = randomInt(min, max);          //ensure that dots are not same
                }
                markFlags(random1, random2);
                stroke(0);
                d.sortData();
                populateValuesArray();
                pie = new PieGraph(chartLeftX + chartSize/2, chartLeftY + chartSize/2, chartSize - PIEBUFFER, chartSize - PIEBUFFER, null, pieValues, false);
                pie.Update();
                drawMarks();
                isDisplaying = true;
                break;
            case 3:  //THIS IS CURRENTLY A DUPLICATE OF CASE 1. but with candycane
                if (isDisplaying) {   
                   break;
                 }
                d = new Data();        
                min = 1;
                max = 9;
                random1 = randomInt(min, max);
                random2 = randomInt(min, max);
                while ((random1 - 1 == random2) || (random1 + 1 == random2) || (random1 == random2)) {
                  random2 = randomInt(min, max);          //ensure that dots are not same, and are not contiguous
                }
                markFlags(random1, random2);
                stroke(0);
                populateValuesArray();
                pie = new PieGraph(chartLeftX + chartSize/2, chartLeftY + chartSize/2, chartSize - PIEBUFFER, chartSize - PIEBUFFER, null, pieValues, true);
                pie.Update();
                drawMarks();
                isDisplaying = true;
                break;




            case 4:    //This is a duplicate of case 0, but with candycane
              if (isDisplaying) {
                 break;
               }
                d = new Data();        
                min = 1;
                max = 9;
                random1 = randomInt(min, max);
                random2 = (random1 + 1) % 9;
                markFlags(random1, random2);  
                stroke(0);
                populateValuesArray();
                pie = new PieGraph(chartLeftX + chartSize/2, chartLeftY + chartSize/2, chartSize - PIEBUFFER, chartSize - PIEBUFFER, null, pieValues, true);
                pie.Update();
                drawMarks();   
                isDisplaying = true;
                break;
        }
        drawWarning();
    } else if (index > vis.length - 1 && pagelast) {
        drawThanks();
        drawClose();
        pagelast = false;
    }
}

/**
 * This method is called when the participant clicked the "NEXT" button.
 */
public void next() {
    String str = cp5.get(Textfield.class, "answer").getText().trim();
    float num = parseFloat(str);
    /*
     * We check their percentage input for you.
     */
    if (!(num >= 0)) {
        warning = "Please input a number!";
        if (num < 0) {
            warning = "Please input a non-negative number!";
        }
    } else if (num > 100) {
        warning = "Please input a number between 0 - 100!";
    } else {
        if (index >= 0 && index < vis.length) {
            float ans = parseFloat(cp5.get(Textfield.class, "answer").getText());

            /**
             ** Finish this: decide how to compute the right answer (DONE)
             **/
             float value1 = -1;
             float value2 = -1;
             for (int i  = 0; i < NUM; i++) {
                if (d.isMarked(i)) {
                  if (value1 == -1) {
                     value1 = d.getValue(i);
                  } else {
                    value2 = d.getValue(i);
                  }
                }
             }
             if (value1 > value2) {
               truePerc = ((value2) / value1);
             } else{
               truePerc = ((value1) / value2);
             }
           reportPerc = ans;// this is the participant's response
truePerc = truePerc * 100;        //TAYLOR ADDED A5
 //           reportPerc = ans / 100.0; // this is the participant's response
          
            error = DECIDE_YOURSELF;
            error = (float)(log2(abs(reportPerc*100 - truePerc*100) + 1f/8f));
            saveJudgement();
            isDisplaying = false;      //TAYLOR
        }

        d = null;      //taylor says this should be fine as is

        cp5.get(Textfield.class, "answer").clear();
        index++;

        if (index == vis.length - 1) {
            pagelast = true;
        }
    }
}


public void close() {

    saveExpData();
    exit();
}

/**
 * Calling this method will set everything to the intro page. Use this if you want to run multiple participants without closing Processing (cool!). Make sure you don't overwrite your data.
 */
public void reset(){
  
    partipantID = PARTID;
    d = null;

    background(255);
    cp5.get("close").remove();
    page1 = true;
    page2 = false;
    pagelast = false;
    index = -1;
}

public int randomInt(int min, int max) {
    Random rand = new Random();
    int randomNum = rand.nextInt((max - min) + 1) + min;
    return randomNum;
}

public void markFlags(int index1, int index2) {
    d.setMark(index1, true);
    d.setMark(index2, true);
}  

public void populateValuesArray() {
  pieValues = new float[NUM];
  for (int i = 0; i < NUM; i++) {
    pieValues[i] = d.getValue(i);
  }
}

public void drawMarks() {
  float dotPosX;
  float dotPosY;
  for (int i  = 0; i < NUM; i++) {
    if (d.isMarked(i)) {
      dotPosX = pie.valueLabelPosX(i);
      dotPosY = pie.valueLabelPosY(i);
      
      ellipse(dotPosX, dotPosY, 15, 15);
    }
  }
}
  double log2(double x) {
    return ((Math.log(x)) / (Math.log(2f)));
  }

//TODO assign order[3] and order[4] to the candy cane ones
void populateOrderArray() {      //Populates the ORDER array
    ORDER[0] = randomInt(0, 2);
    ORDER[1] = randomInt(0, 2);
    while (ORDER[1] == ORDER[0]) {
      ORDER[1] = randomInt(0, 2);
    }
    ORDER[2] = randomInt(0, 2);
    while (ORDER[2] == ORDER[1] || ORDER[2] == ORDER[0]) {
      ORDER[2] = randomInt(0,2);
    }
    ORDER[3] = randomInt(3, 4);      //a5 here down-->
    ORDER[4] = randomInt(3, 4);
    while(ORDER[4] == ORDER[3]) {
      ORDER[4] = randomInt(3, 4);
    }
}
