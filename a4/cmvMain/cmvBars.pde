// --> when highlighting is being performed, have protocol display the columns 
// TO DO: create a data structure that will map times ports so that I can handle messages from cmvHeat. (istance of cmvHeat if desperate)
//255, 255, 0
//highlighting could possibly be inaccurate?
class cmvCategories{ //x y width height
  Integer total_num_data;
  Integer num_protocol; //2
  Integer num_op; //3
  Integer num_syslog; //1
  float posx;
  float posy;
  float w;
  float h;
  Boolean highlighting;
  Bucket[][] Bars;
  cmvCategories(float posx1, float posy1, float w1, float h1, String[][] raw_data) {
    posx = posx1;
    posy = posy1;
    w = w1;
    h = h1;
    total_num_data = raw_data.length;
    highlighting = false;
    init_data(raw_data);
    populate_dimensions();
  }
  
  void init_data(String[][] raw_data) {
    num_protocol = get_num_buckets(raw_data, PROTOCOL);
    num_op = get_num_buckets(raw_data, OP);
    num_syslog = get_num_buckets(raw_data, SYSLOG);
    Bucket[] protocol = create_bar(num_protocol, raw_data, PROTOCOL);
    Bucket[] op = create_bar(num_op, raw_data, OP);
    Bucket[] syslog = create_bar(num_syslog, raw_data, SYSLOG);
    Bars = new Bucket[][] { protocol, op, syslog };
  }
  
  //calculate to find the sizes that buckets need to be
  //go through the Bars array and 
  void populate_dimensions() {
    int numBars = Bars.length;
    float barSpace = (((float)(w / 2)) - ((float)(w/5))) / numBars; 
    float currBarPosX = posx + barSpace;
    float currBarPosY = posy + (h * .1);
    float barHeightDefault = h * .9;
    float barWidth = (w/2) / numBars;
    color colorA = color(175, 100, 220);
    color colorB = color(255, 0, 0);
    color currColor = colorA;
    for (int i = 0; i < Bars.length; i ++ ) {
      for (int j = 0; j < Bars[i].length; j++) {
        Bars[i][j].w = barWidth;
        Bars[i][j].h = ((float)(Bars[i][j].count) / ((float)total_num_data)) * barHeightDefault;
        Bars[i][j].posx = currBarPosX;
        Bars[i][j].posy = currBarPosY;
        Bars[i][j].col = currColor;
        Bars[i][j].origCol = currColor;
        Bars[i][j].populateRect(); 
        currBarPosY = currBarPosY + Bars[i][j].h;
        if (currColor == colorA) { currColor = colorB; } else { currColor = colorA; }
      }
      currBarPosX = currBarPosX + barWidth + barSpace;
      currBarPosY = posy + (h * .1);
      currColor = colorA;

    }
  }
  
  
  //Populate an array of buckets, AKA a bar. returns this bar.
 //   (to be used in constructor 3 times to create the 3 bars).
 // args: number of buckets to be in the bar. raw_data. the column
 //       number in raw_data to be turned into bar. 
 Bucket[] create_bar(int num_buckets, String[][] raw_data, int field){
   Bucket[] newBar = new Bucket[num_buckets];
   int newBar_currPosition = 0;
   HashMap<String, Integer> source_IP = null;
   HashMap<String, ArrayList<String>> time_port = null; 
   Set<String> uniqTimes = new TreeSet<String>(); //to ensure only one bucket per unique instance
   for (int i = 0; i < raw_data.length; i++) {
     if (! uniqTimes.contains(raw_data[i][field])) {
       source_IP = instances_in_col(raw_data, SRC_IP, i, field);
       time_port = pop_time_port_map(raw_data, TIME_STAMP, i, field);
       //create a hashmap for each distinct IP
       //create a hashmap for each distinct time
       //create a hashmap for each distinct port
       int num_in_bucket = get_num_in_bucket(raw_data, field, raw_data[i][field]);
       newBar[newBar_currPosition] = new Bucket(raw_data[i][field], source_IP, time_port, num_in_bucket);//INCLUDE CONSTRUCTOR ITEMS HERE
       uniqTimes.add(raw_data[i][field]);
       newBar_currPosition++;
     }
   }
   return newBar;
 }

 
 
 
  int get_num_buckets(String[][] raw_data, int field) {
    Set<String> uniqTimes = new TreeSet<String>();
    for (int i=0; i < raw_data.length; i++) {
      uniqTimes.add(raw_data[i][field]);
    }
    return uniqTimes.size();
  }
  
  int get_num_in_bucket(String[][] raw_data, int field, String value) {
    int total = 0;
    for (int i = 0; i < raw_data.length; i++) {
      if ((raw_data[i][field]).equals(value)) {
        total++;
      }
    }
    return total;
  }
  
  cmvFilter check_hover() {
    cmvFilter new_filter = null;
  //check if hover is over something in Categories. if it is, return valuable info, otherwise return null.
      for (int i = 0; i < Bars.length; i++) {
        for (int j = 0; j < Bars[i].length; j++) {
          if (Bars[i][j].rect.within()) {
            Bars[i][j].col = color(255, 255, 0);
            Bars[i][j].populateRect();
            new_filter = new cmvFilter(CATEGORY, Bars[i][j].category.toLowerCase(), "", "", "");
          } else {
            Bars[i][j].col = Bars[i][j].origCol;
            Bars[i][j].populateRect();
         }
        }
      }
      return new_filter;
  }

  /*
    cmvFilter check_hover() {
    cmvFilter new_filter = null;
    for (int i=1; i<uniq_times.size() + 1; i++) {
      for (int j=0; j<uniq_ports.size(); j++) {
        if (grid[i][j].rct.within()) {
          new_filter = new cmvFilter(HEAT, "", "", uniq_times.get(i - 1), uniq_ports.get(j));
        }
      }
    }
    return new_filter;
  }
  */
  
  
  void update(cmvFilter curr_filter) {
    int highlight_total = 0;
    for (int a = 0; a < Bars.length; a++) {
      for (int b = 0; b < Bars[a].length; b++) {
        if (curr_filter == null) {
            highlighting = false;
            Bars[a][b].highlight_total = 0;
            Bars[a][b].Display();
            return;
        } else {
          if (curr_filter.magic_chart == HEAT) { 
            highlight_total = 0;
              if (Bars[a][b].time_port.containsKey(curr_filter.time_range)) {
                 ArrayList <String> copy = Bars[a][b].time_port.get(curr_filter.time_range);
                 for (int x = 0; x < copy.size(); x++ ){
  //                 print(copy.get(x) + "    " + curr_filter.port_range + "\n");
                   if ((copy.get(x)).equals(curr_filter.port_range)) {
  //                   print("here");
                     highlight_total++;
                   }
                 }
                 Bars[a][b].highlight_total = highlight_total;
                 highlighting = true;
                 Bars[a][b].Display();
              }
          } else if (curr_filter.magic_chart == NETWORK) {
            highlight_total = 0;
            if (Bars[a][b].ips.containsKey(curr_filter.source_ip)) {
              Bars[a][b].highlight_total = Bars[a][b].ips.get(curr_filter.source_ip);
              highlighting = true;
              Bars[a][b].Display();
            }
             //deal with it if its in network
          }
          // create a yellow rectangle of the correct size
        }
      }
    }
  }


  
   //creates a hashmap for each distinct item in a particular col
 // takes in: raw_data. column to use. indices of raw_data where matching item must be, e.g.
 //                if it is creating a hashmap for all IP address of TC, then the indices
 //                here will be the indices where TCP is located.
 //   goes down column_to_use and each time a distinct item is found in that column,
 //   creates a new key for that in the hashmap, with value of 0.
 //   key: the distinct item. Value: the number of instances of that item.
 // returns: hashmap 
HashMap<String, Integer> instances_in_col(String[][] raw_data, int traverse_indx, int match1stIndex, int match2ndIndex) {
  HashMap<String, Integer> instances = new HashMap<String, Integer>();
  Integer currVal = 0;  //to hold the value at a certain key
  for (int i = 0; i <raw_data.length; i++) {
  if ((raw_data[i][match2ndIndex]).equals((raw_data[match1stIndex][match2ndIndex]))) {
        if (instances.containsKey(raw_data[i][traverse_indx])) {
          currVal = instances.get(raw_data[i][traverse_indx]);
          currVal++;
        } else {
          currVal = 1;
        }
        instances.put(raw_data[i][traverse_indx], currVal);
      }
    }
  return instances;
}

//key: the distinct time. Value: the arraylist of ports for that time, which contains duplicates.
HashMap<String, ArrayList<String>> pop_time_port_map(String[][] raw_data, int traverse_indx, int match1stIndex, int match2ndIndex) {
  HashMap<String, ArrayList<String>> time_port = new HashMap<String, ArrayList<String>>();
  ArrayList<String> temp;
  for (int i = 0; i < raw_data.length; i++) {
    if ((raw_data[i][match2ndIndex]).equals((raw_data[match1stIndex][match2ndIndex]))) {
         temp = new ArrayList<String>();
         if (time_port.containsKey(raw_data[i][TIME_STAMP])) {
           temp = time_port.get(raw_data[i][TIME_STAMP]);
         } 
         temp.add(raw_data[i][SRC_PORT]);
         time_port.put(raw_data[i][TIME_STAMP], temp);
    }
  }
   return time_port;                   
  } 
}
