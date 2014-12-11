int BUFFER = 20;

class freq_graph{
 float [] timestamps;
 float posx,posy,w,h;
 float duration = ;
 boolean playing;
 float time_interval;
 int index;
 float curr_time;
 float momentum_factor; //comes into play when doing heatmap style stuff
 
 freq_graph(float [] timestamps1, float x,float y,float w1,float h1){
     playing = false;
     index = 0;
     curr_time = 0;
    posx = x;
    posy = y;
    w = w1;
    h = h1;
    timestamps = timestamps1;
    Rectangle rect = new Rectangle(posx,posy,w,h,"", color(250,0,0));
    print (timestamps[timestamps.length-1]);
    time_interval = (timestamps[timestamps.length-1]/60)/ duration;
    print(time_interval);
 } 
  void update(){
    if (playing && index < timestamps.length){
       print(timestamps[index] + "\n");
       if (timestamps[index] < curr_time){
          index++;
          print("fuck");
       } 
       curr_time+=time_interval;
    }
  }
  void Play(){
     playing = true; 
  }
}

