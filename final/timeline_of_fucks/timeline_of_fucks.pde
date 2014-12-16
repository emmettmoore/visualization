import java.util.*;
//import processing.opengl.*;

String fi = "wowFuckInstances.csv";
String rf = "recordedFucks.csv";
String MovieCompare0 = "The Big Lebowski";
String MovieCompare1 = "Abraham Lincoln: Vampire Hunter";
String MovieCompare2 = "Wolf of Wall Street";//this never gets used
float numSwearsIn0 = 291;
float numSwearsIn1 = 9;
float numSwearsIn2 = 569;
float numMinutesLong0 = 101;
float numMinutesLong1 = 195;
float numMinutesLong2 = 180;
Circle refresh;
Circle refresh1;
Circle refresh2;
PieLabel VisTitle;
PieLabel wordEvery;
PieLabel wordFuck;
PieLabel wordIn;
PieLabel wolfOf;
float lerpAmount; //= 0;
float lerpAmount2;// = 0;
float colorLerp;// = 0;
float redGradientLerp;// = 20;  //for changing red gradient to a solid red
float reverseRedGradientLerp;// = 250;  //for changing bright red gradient to solid red
Rectangle redRect;
color white;// = color(255, 255, 255);
color red;// = color(186, 0, 25);
color currColor;// = white;
boolean lerpReady;// = false;  //set to true after freq_graph finishes. Lerping to line will begin
boolean transitionReady;// = false;//set to true after lerping finishes. Transition to heart rates begin
boolean heartSimulationReady;// = false;
heartbeat startingHeart;
int currentRate;// = 400;
int s_h_alpha;// = 250;
int countRounds;// = 30;
int counterSecondMovie;// = 30;
PFont font1;// = createFont("monoscript", 70);
String str1;// = "Compare this to";
float stringHeight;// = 250;//((height*.5)/2.0 + 70);
boolean secondStringSaid;// = false;

String [] fuck_strings;
float [] fuck_timestamps;
freq_graph bot;
heart_mgr hearts;
void setup(){
//size(800,600);
size(900, 600);

//NEW
lerpAmount = 0;
lerpAmount2 = 0;
colorLerp = 0;
redGradientLerp = 20;  //for changing red gradient to a solid red
reverseRedGradientLerp = 250;  //for changing bright red gradient to solid red
white = color(255, 255, 255);
red = color(186, 0, 25);
currColor = white;
lerpReady = false;  //set to true after freq_graph finishes. Lerping to line will begin
transitionReady = false;//set to true after lerping finishes. Transition to heart rates begin
heartSimulationReady = false;
currentRate = 400;
s_h_alpha = 250;
countRounds = 30;
counterSecondMovie = 30;
font1 = createFont("monoscript", 70);
str1 = "Compare this to";
stringHeight = 250;//((height*.5)/2.0 + 70);
secondStringSaid = false;
//NEW^^^^
//from freq_graph:
populatePosition = 0;  //TAYLOR
isFirstItem = true;



textAlign(CENTER);
VisTitle = new PieLabel(width/2, 25, "FPM - Fucks Per Movie", 0, 0, color(77, 77, 77), createFont("monoscript", 30), 0, 5, 0);
wordEvery = new PieLabel(150, 150, "every", 0, 0, color(255, 255, 255), createFont("monscript", 25), 0, 7, 10);
wordFuck = new PieLabel(width/2, height/2 - 50, "FUCK", 0, 0, color(255, 255, 255), createFont("monoscript", 200), 0, 7, 10);
wordIn = new PieLabel(width/2 + 250, 150, "in", 0, 0, color(255, 255, 255), createFont("monoscript", 25), 0, 7, 10);
wolfOf = new PieLabel(width/2, height/2 - 50, "The Wolf of Wall Street", 0, 0, color(255, 255, 255), createFont("monoscript", 70), 0, 3, 10);
redRect = new Rectangle(0,.62*height, (float)width, (float)height, "", color(107, 0, 0));//used to be .6
refresh = new Circle(width - 15, height - 15, 5, color(77, 77, 77));
refresh1 = new Circle(width - 15, height - 15, 9, color(77, 77, 77, 200));
refresh2 = new Circle(width - 15, height - 15, 12, color(77, 77, 77, 150));
//startingHeart = new heartbeat(0, (int)(.9*height), numMinutesLong2, numSwearsIn2, 0, MovieCompare2);                          //TEMPORARY, DELETE THIS
            // startingHeart = new heartbeat(0, (int)(.9*height), MIN_ALLOWABLE_INVERSE + 10);                  //TEMPORARY, DELETE THIS
//size(800, 600, OPENGL);
 parse_data();
 setGradient(0,(int).6*height,(float)width,(float)height, color(250,0,0), color(20,0,0));
 //bot = new freq_graph(fuck_strings, fuck_timestamps, 0.0,.75*height, (float)width, .25*height); 
  bot = new freq_graph(fuck_strings, fuck_timestamps, 0.0,.69*height, (float)width, .25*height); //used to be .65
  hearts = new heart_mgr(3, numMinutesLong0, numSwearsIn0, MovieCompare0, numMinutesLong1, numSwearsIn1, MovieCompare1, numMinutesLong2, numSwearsIn2, MovieCompare2);
// hearts = new heart_mgr(3, 80, 200, 400);//56, 400);
 bot.intro();

  
}
void draw(){
  if ((lerpReady == false)&&(transitionReady == false) && (heartSimulationReady == false)) {
      setGradient(0,0,width,.69*height, color(250,250,250), color(30,30,30)); //used to be .65
  }
  bot.update();    
  if ((bot.first_half_intro == true) && (bot.intro_alpha > 4) && (bot.intro_counter > 100)) {
    wordEvery.printWord();
  }
    if ((wordEvery.isIncreasing == false) && (wordEvery.Opacity <= 5)) {
      wordFuck.printWord();
    }
    if ((wordFuck.isIncreasing == false) && (wordFuck.Opacity <= 5)) {
      wordIn.printWord();
    }
    if ((wordIn.isIncreasing == false) && (wordIn.Opacity <= 5)) {
      wolfOf.printWord();
    }
    //PUT THE "EVERY FUCK IN " HERE
  //} else if (bot.second_half_intro == true) {
    //PUT THE Wolf of wallstreet here
  //}
  if (bot.playing == true) {
//  if ((bot.intro == false) && (bot.first_half_intro == false)) {      //just added
      //VisTitle.printWord();
  }
  if (lerpReady == true) {
            textAlign(CENTER);
        VisTitle.printWord();
        textAlign(LEFT);

         setGradient(0,(int).6*height,(float)width,(float)height, color(reverseRedGradientLerp,0,0), color(redGradientLerp,0,0));

         if (redGradientLerp < 107) {
            redGradientLerp++;
         }
         if (reverseRedGradientLerp > 107) {
           reverseRedGradientLerp = reverseRedGradientLerp -2;
         }
          setGradient(0,0,width,.69*height, color(250,250,250), color(30,30,30)); //used to be .65  
          
        textAlign(CENTER);
        VisTitle.printWord();
        textAlign(LEFT);    
        lerpFreqGraph();
  }
  if (transitionReady == true) {
        textAlign(CENTER);
        VisTitle.printWord();
        textAlign(LEFT);

     redRect.Display();
     setGradient(0,0,width,.69*height, color(250,250,250), color(30,30,30));//used to be .65
     textAlign(CENTER);
     VisTitle.printWord();
     textAlign(LEFT);      
     StartHeartRate();
     hearts.update();
  }
  if (heartSimulationReady == true) {
    textAlign(CENTER);
    VisTitle.printWord();
    textAlign(LEFT);
     setGradient(0,0,width,.69*height, color(250,250,250), color(30,30,30)); //used to be .65            
     textAlign(CENTER);
     VisTitle.printWord();
     textAlign(LEFT); 
    hearts.update();  
  }

  
 /*
  setGradient(0,0,width,.65*height, color(250,250,250), color(30,30,30));    //TEMPORARY
  redRect.Display();            //TEMPORARY
  hearts.DisplaySecond = true;  //TEMPORARY
  hearts.DisplayFirst = true;  //TEMPORARY
  hearts.DisplayThird = true;  //TEMPORARY
  hearts.update();              //TEMPORARY
  startingHeart.update();
  */
}

void mouseClicked(){
  if (refresh2.within()){
    setup();
  }
  
}
void parse_data(){
  
  Table table = loadTable(fi);
  int index = 0;
  fuck_timestamps = new float[table.getRowCount()];
  for (TableRow row : table.rows()) {
      fuck_timestamps[index] = Float.parseFloat(row.getString(0));
      index++;
  }
  table = loadTable (rf);
  index = 0;
  fuck_strings = new String[table.getRowCount()];
  for (TableRow row : table.rows()) {
      fuck_strings[index] = row.getString(0);
      index++;
  }
}


void setGradient(int x, int y, float w, float h, color c1, color c2){
  // calculate differences between color components 
  float deltaR = red(c2)-red(c1);
  float deltaG = green(c2)-green(c1);
  float deltaB = blue(c2)-blue(c1);
    /*nested for loops set pixels
     in a basic table structure */
    for (int i=x; i<=(x+w); i++){
      // row
      for (int j = y; j<=(y+h); j++){
        color c = color(
        (red(c1)+(j-y)*(deltaR/h)),
        (green(c1)+(j-y)*(deltaG/h)),
        (blue(c1)+(j-y)*(deltaB/h)) 
          );
        set(i, j, c);
      }
    }  
  }
  
  void lerpFreqGraph() {
    
    for (int i = 0; i < xCoordStarts.length; i++) {
//      yCoordStarts[i] = lerp(.75*height, .9*height, lerpAmount);
      yCoordStarts[i] = lerp(.69*height, .9*height, lerpAmount);//used to be .65
      yCoordEnds[i] = lerp(yCoordEndsOrig[i], .9*height, lerpAmount);
      currColor = lerpColor(white, red, colorLerp);
      if (yCoordStarts[i] <= .9*height) {
        stroke(currColor);
        line(xCoordStarts[i], yCoordStarts[i], xCoordEnds[i], yCoordEnds[i]);
      } else {
        stroke(red);
        line(lerp(xCoordStarts[0], 0, lerpAmount2), .9*height, lerp(xCoordStarts[xCoordStarts.length-1], 800, lerpAmount2), .9*height);
        lerpAmount2+= .001;
      }
    }
    if (lerpAmount2 >= 1) {
      lerpReady = false;
      transitionReady = true;
    }
    lerpAmount+= .01;
    colorLerp+= .01;
  }
  
  
  void StartHeartRate() {
         // if (currentRate > (hearts.heartbeats[2].inverseHeartRate)) {
            //print("Inverse heart rate is: " + hearts.heartbeats[2].inverseHeartRate);
         if (currentRate > (MIN_ALLOWABLE_INVERSE + 10)) {
           //print("Inverse heart rate is: " + hearts.heartbeats[2].inverseHeartRate);
             //startingHeart = new heartbeat(0, (int)(.9*height), currentRate);
             startingHeart = new heartbeat(0, (int)(.9*height), numMinutesLong2, numSwearsIn2, currentRate, MovieCompare2);
         }
         startingHeart.update();
 
     if (!(currentRate > (-500))) {      
          if(s_h_alpha > 5){
            fill(250,250,250,s_h_alpha);

            textFont(font1);
            float len = textWidth(str1);
            text(str1,width/2.0-len/2.0,stringHeight);
            if (countRounds <= 0) { // just added
              s_h_alpha -=5;
            }                      //just added
            countRounds = countRounds - 1;
         }
         else if(s_h_alpha < -200){
           s_h_alpha -=5;
         }
   } else {
       currentRate = currentRate - 10;
   }
   if ((countRounds <= -49) && (secondStringSaid == false) && (s_h_alpha <= 5)) {
     if (stringHeight == 130) {//then its already been here because below this "if" statement, StringHeight is set to 130
         secondStringSaid = true;
         hearts.DisplayFirst = true;
     } else {
     s_h_alpha = 250;
     str1 = MovieCompare0;
     stringHeight = (130);
     font1 = createFont("monoscript", 40);
//     secondStringSaid = true;
     countRounds = 30;
     }
   } else if ((countRounds <=-49) && (secondStringSaid == true)&&(s_h_alpha <= 5)) {
     if (counterSecondMovie == 30) {
       if (stringHeight == 350){//260) { // then it has already been here
         hearts.DisplaySecond = true;
         refresh.Display();
         refresh1.Display();
         refresh2.Display();
       } else {
         s_h_alpha = 250;
         str1 = MovieCompare1;
         stringHeight = 350;//260;
         countRounds = 30;
         font1 = createFont("monoscript", 40);
       }
     } else {
       counterSecondMovie = counterSecondMovie -1;
     }
   }     
}
