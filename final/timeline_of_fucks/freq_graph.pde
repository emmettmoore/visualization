int BUFFER = 20;
float[] xCoordStarts;  //TAYLOR
float[] yCoordStarts;  //TAYLOR
float[] xCoordEnds;
float[] yCoordEnds;
float[] yCoordEndsOrig;
int populatePosition = 0;  //TAYLOR
boolean isFirstItem = true;

class freq_graph{
 String[] fontList;
 ArrayList<quote_data> fucks_on_screen;
 ArrayList<explosion> explosions;
 float [] timestamps;
 String [] quotes;
 float posx,posy,w,h;
 float duration = 20;
 boolean playing,intro, first_half_intro;
 float time_interval;
 int index;
 float curr_time;
 float movie_length;
 float momentum_factor; //comes into play when doing heatmap style stuff
 float intro_alpha, second_half_alpha;
 
 freq_graph(String [] quotes1, float [] timestamps1, float x,float y,float w1,float h1){
   fontList = PFont.list();
   for(int i = 0; i<fontList.length; i++){
     // print (fontList[i] + "\n");
   } 
     fucks_on_screen = new ArrayList<quote_data>();
     explosions = new ArrayList<explosion>();
     playing = false;
     index = 0;
     curr_time = 0;
     time_since_last_fuck = 0;
     intro_alpha = 255;
    quotes = quotes1;
    xCoordStarts = new float[quotes.length];    //TAYLOR >>
    yCoordStarts = new float[quotes.length];
    xCoordEnds = new float[quotes.length];
    yCoordEnds = new float[quotes.length];
    yCoordEndsOrig = new float[quotes.length];
    posx = x + BUFFER*2;
    posy = y;
    w = w1 - BUFFER*4;
    h = h1 - BUFFER;
    timestamps = timestamps1;
    //Rectangle rect = new Rectangle(posx,posy,w,h,"", color(250,0,0));
    movie_length = timestamps[timestamps.length-1];
    time_interval = (movie_length/60.0)/ duration;
    start_and_end();

    
 } 
  float time_since_last_fuck;
  float prev_height;
  int intro_counter;
  void update(){
    if(intro){
        intro_counter+=1;
        if(intro_counter > 100){
            draw_intro_screen();
        }
    }

    if (playing && index < timestamps.length){
       draw_counter();
       draw_fucks();
       draw_explosions();
       if (timestamps[index] < curr_time){
         float ratio = timestamps[index]/movie_length;
          float line_height = calc_momentum();
          stroke(color(250,250,250));
          Random rand = new Random();
          fucks_on_screen.add(new quote_data(quotes[index],fontList[rand.nextInt(fontList.length-30)]));
          float x = posx + w*ratio;
          explosions.add(new explosion(x,posy));
          fill(250);
          line(x ,posy, x, posy + line_height);//WHERE LINES OF BAR GRAPH ARE DRAWN
          
          
          if (isFirstItem == true) {//TAYLOR
            xCoordStarts[populatePosition] = x;
            yCoordStarts[populatePosition] = posy;
            xCoordEnds[populatePosition] = x;
            yCoordEnds[populatePosition] = posy + line_height;
            yCoordEndsOrig[populatePosition] = posy + line_height;
            isFirstItem = false;
          } else if (xCoordStarts[populatePosition] != x) {
            populatePosition++;
            xCoordStarts[populatePosition] = x;
            yCoordStarts[populatePosition] = posy;
            xCoordEnds[populatePosition] = x;
            yCoordEnds[populatePosition] = posy + line_height;
            yCoordEndsOrig[populatePosition] = posy + line_height;
          } else {//current line still growing
            yCoordEnds[populatePosition] = posy + line_height;
            yCoordEndsOrig[populatePosition] = posy + line_height;
          }
          
          
          index++;
          time_since_last_fuck = 0;
       }
       time_since_last_fuck += time_interval;
       curr_time+=time_interval;
    }
    else{
     if (index == timestamps.length) {
                lerpReady = true;  //TAYLOR
       }
       index = 0;
       curr_time = 0;
       playing = false; 

    }
  }
  void Play(){
     playing = true; 
  }
  void intro(){
    first_half_intro = true;
    intro = true;
  }
  void draw_intro_screen(){
      if(intro_alpha > 4 && first_half_intro){
          fill(250,250,250,intro_alpha);
          PFont font = createFont("monoscript", 25);
          String str = "every fuck in";

          textFont(font);
          float len = textWidth(str);
          text(str,width/2-len/2,(height*.5)/2.0);
          intro_alpha -=5;
          second_half_alpha = 250;
      }
      else{
         first_half_intro = false;
         if(second_half_alpha > 5){
            fill(250,250,250,second_half_alpha);

            PFont font = createFont("monoscript", 70);
            String str = "The Wolf of Wall Street";
            textFont(font);
            float len = textWidth(str);
            text(str,width/2.0-len/2.0,(height*.5)/2.0 + 70);
            second_half_alpha -=5;
         }
         else if(second_half_alpha < -200){
           second_half_alpha -=5;
         }
         else { 
            intro = false;
            first_half_intro = false;
            intro_alpha = 250;
            playing = true;
         }         
      }
  }
    
  void start_and_end(){
      fill(250,250,250); 
      PFont font = createFont("monoscript", 13);
      textFont(font);
      String str = "start";
      float len = textWidth(str);
      stroke(color(250,250,250));
      line(posx,height - 60, posx, height - 25);
      text(str,posx-len/2,height- 10);
      str = "end";
      len = textWidth(str);
      line(posx + w,height - 60, posx + w, height - 25);
      text(str,posx + w - len/2,height- 10);
      
  }
  void draw_counter(){
     String counter = Integer.toString(index);
      fill(250,250,250); 
      PFont font = createFont("monoscript", 25);
      textFont(font);
//      text(counter,10,.75*height- 10);
      //text(counter,10,.65*height- 10);
      text(counter, 10, .69*height-10);
  }
  float calc_momentum(){
      if(time_since_last_fuck>60){
         prev_height = 10;
      }
      /*
      else if(time_since_last_fuck >30){
        prev_height *= .95;
      }
      else if (time_since_last_fuck >20){
          prev_height *= .98;
      }*/
      else{
         prev_height *=1.06;
         if (prev_height > h){
            prev_height = h;
         } 
      }
      return prev_height;
  }
  void draw_fucks(){
      for (Iterator<quote_data> iterator = fucks_on_screen.iterator(); iterator.hasNext();) {
          quote_data q = iterator.next();
          if (q.alpha < 15) {
              // Remove the current element from the iterator and the list.
              iterator.remove();
          }
          else{ q.reduce_alpha(); }
      }
  }
  void draw_explosions(){
      for (Iterator<explosion> iterator = explosions.iterator(); iterator.hasNext();) {
          explosion q = iterator.next();
          
          if(q.r<50){
            q.update();
          }
          else{ iterator.remove(); }
      }
  }
}

class explosion{
   float x,y,r,alpha;
   explosion(float x1, float y1){
      x = x1; y = y1; 
      r = 5;
      alpha = 255;
      noStroke();
      fill(250,250,250,alpha);
      arc(x,y,r,r,PI, 2*PI);
      stroke(color(250,250,250));
   } 
   void update(){
       r+=10;
       alpha -= 60;
             noStroke();
      fill(250,250,250,alpha);
      arc(x,y,r,r,PI,2*PI);
      stroke(color(250,250,250));
   }
}


