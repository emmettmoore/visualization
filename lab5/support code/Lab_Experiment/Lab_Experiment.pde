//CURRENT PROGRESS:     - in bottom function right after where true mark values are found, 
//                        read the comments to find the next thing that we were instructed to
//                        complete in the source code

//TO DO :          - get the wedge outlines to display, get rid of gradual coloring of pies
//                - choose how to have participant IDs found
//                - have chartType chosen randomly
//  questions:
//                - should switch cases 3 4 and 5 be repeats of the above ones? they are now.


import controlP5.*;
import java.util.Random;

final int DECIDE_YOURSELF = -1; // This is a placeholder for variables you will replace.

/**
 * This is a global variable for the dataset in your visualization. 
 You'll be overwriting it each trial.
 */
Data d = null;

float[] pieValues;
PieGraph pie;
int PIEBUFFER = 5;    //number of pixels of blank space displayed between edges of pie graph and rectangle containing graph
boolean isDisplaying = false;  //If the pie for the current switch has already been created and displayed once
int chartType = -1;          //First display will be for switch 0; "draw()" begins by iterating chartType up
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

    /**
     ** Finish this: decide how to generate the dataset you are using (see DataGenerator)
     **/
    d = null;

    /**
     ** Finish this: how to generate participant IDs
     ** You can write a short alphanumeric ID generator (cool) or modify this for each participant (less cool).
     **/
    partipantID = DECIDE_YOURSELF;
}

void draw() {
    textSize(fontSize);
    int min;
    int max;
    int random1;
    int random2;
    /**
     ** add more: you may need to draw more stuff on your screen
     **/
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

        /**
         **  Finish this: decide the chart type. You can do this randomly.
         **/
 //       int chartType = DECIDE_YOURSELF;
 
 
//For going through switch cases in order: 0, 1, 2, 3, 4
 if ((!isDisplaying) && (!pagelast)) {
   chartType ++;
 }
   
        switch (chartType) {
            case -1: // This is a placeholder, you can remove it and use the other cases for the final version
                 stroke(0);
                 strokeWeight(1);
                 fill(255);
                 rectMode(CORNER);
                 /*
                  * all your charts must be inside this rectangle
                  */
                 rect(chartLeftX, chartLeftY, chartSize, chartSize);
                 break;
            case 0:          //Dots are contiguous
              if (isDisplaying) {
                pie.Update();
                drawMarks();       
                break;
              }
                d = new Data();        
                min = 1;
                max = 9;
                random1 = randomInt(min, max);
                random2 = (random1 + 1) % 9;
                markFlags(random1, random2);

                //(Copied and pasted from support code "case -1")>>
                 stroke(0);
                 strokeWeight(1);
                 fill(255);
                 rectMode(CORNER);
                 rect(chartLeftX, chartLeftY, chartSize, chartSize);
                 //^^<<(Copied and pasted from support code "case -1")
                 
                populateValuesArray();
                pie = new PieGraph(chartLeftX + chartSize/2, chartLeftY + chartSize/2, chartSize - PIEBUFFER, chartSize - PIEBUFFER, null, pieValues);
                pie.Update();
                isDisplaying = true;
                break;
            case 1://Dots are NOT contiguous
                if (isDisplaying) {
                   pie.Update();
                   drawMarks();       
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

                //(Copied and pasted from support code "case -1")>>
                 stroke(0);
                 strokeWeight(1);
                 fill(255);
                 rectMode(CORNER);
                 rect(chartLeftX, chartLeftY, chartSize, chartSize);
                 //^^<<(Copied and pasted from support code "case -1")

                populateValuesArray();
                pie = new PieGraph(chartLeftX + chartSize/2, chartLeftY + chartSize/2, chartSize - PIEBUFFER, chartSize - PIEBUFFER, null, pieValues);
                pie.Update();
                isDisplaying = true;
                break;

            case 2:      //wedges are in increasing size. dots are allowed to be contig
               if (isDisplaying) {
                   pie.Update();
                   drawMarks();       
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

                //(Copied and pasted from support code "case -1")>>
                 stroke(0);
                 strokeWeight(1);
                 fill(255);
                 rectMode(CORNER);
                 rect(chartLeftX, chartLeftY, chartSize, chartSize);
                 //^^<<(Copied and pasted from support code "case -1")
                d.sortData();
                populateValuesArray();
                pie = new PieGraph(chartLeftX + chartSize/2, chartLeftY + chartSize/2, chartSize - PIEBUFFER, chartSize - PIEBUFFER, null, pieValues);
                pie.Update();
                isDisplaying = true;

                break;
            case 3:  //THIS IS CURRENTLY A DUPLICATE OF CASE 1
                /**
                 ** finish this: 4th visualization
                 **/

              if (isDisplaying) {
                pie.Update();
                drawMarks();       
                break;
              }
                d = new Data();        
                min = 1;
                max = 9;
                random1 = randomInt(min, max);
                random2 = (random1 + 1) % 9;
                markFlags(random1, random2);

                //(Copied and pasted from support code "case -1")>>
                 stroke(0);
                 strokeWeight(1);
                 fill(255);
                 rectMode(CORNER);
                 rect(chartLeftX, chartLeftY, chartSize, chartSize);
                 //^^<<(Copied and pasted from support code "case -1")
                 
                populateValuesArray();
                pie = new PieGraph(chartLeftX + chartSize/2, chartLeftY + chartSize/2, chartSize - PIEBUFFER, chartSize - PIEBUFFER, null, pieValues);
                pie.Update();
                isDisplaying = true;
                break;




            case 4:    //THIS IS CURRENTLY A DUPLICATE OF CASE 2
                /**
                 ** finish this: 5th visualization
                 **/


               if (isDisplaying) {
                   pie.Update();
                   drawMarks();       
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

                //(Copied and pasted from support code "case -1")>>
                 stroke(0);
                 strokeWeight(1);
                 fill(255);
                 rectMode(CORNER);
                 rect(chartLeftX, chartLeftY, chartSize, chartSize);
                 //^^<<(Copied and pasted from support code "case -1")
                d.sortData();
                populateValuesArray();
                pie = new PieGraph(chartLeftX + chartSize/2, chartLeftY + chartSize/2, chartSize - PIEBUFFER, chartSize - PIEBUFFER, null, pieValues);
                pie.Update();
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
                     print("Value 1 is at index: " + i + ", and is the value of: " + value1 + "\n");
                  } else {
                    value2 = d.getValue(i);
                    print("Value 2 is at index: " + i + ", and is the value of: " + value2 + "\n");
                  }
                }
             }
             truePerc = (abs(value1 - value2)) / 100.0;
             print(truePerc + "\n");
                 
            //truePerc = DECIDE_YOURSELF; // hint: from your list of DataPoints, extract the two marked ones to calculate the "true" percentage (DONE)

            reportPerc = ans / 100.0; // this is the participant's response
            
            /**
             ** Finish this: decide how to compute the log error from Cleveland and McGill (see the handout for details)
             **/
            error = DECIDE_YOURSELF;

            saveJudgement();
            isDisplaying = false;      //TAYLOR
        }

        /**
         ** Finish this: decide the dataset (similar to how you did in setup())
         **/
        d = null;

        cp5.get(Textfield.class, "answer").clear();
        index++;

        if (index == vis.length - 1) {
            pagelast = true;
        }
    }
}

/**
 * This method is called when the participant clicked "CLOSE" button on the "Thanks" page.
 */
public void close() {
    /**
     ** Change this if you need to do some final processing
     **/
    saveExpData();
    exit();
}

/**
 * Calling this method will set everything to the intro page. Use this if you want to run multiple participants without closing Processing (cool!). Make sure you don't overwrite your data.
 */
public void reset(){
    /**
     ** Finish/Use/Change this method if you need 
     **/
    partipantID = DECIDE_YOURSELF;
    d = null;

    /**
     ** Don't worry about the code below
     **/
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
