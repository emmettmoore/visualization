//it doesnt seem like instances_in_col is populating correctly cause it looks liek its just putting one element in for each one
// --> when highlighting is being performed, have protocol display the columns 
class Bucket{
 String category;
 int count;
 float posx;
 float posy;
 float w;
 float h;
 //hashmaps:
 //for each distinct IP: # of instances of IP
 //for each distinct time: # of instances of time
 //for each distinct source port: # of instances of it
 //another hashmap:
  //      key -- distinct time
 //      value --- arraylist of source ports. contains duplicates
}

//take in: raw_data. kind (e.g. TCP). col to go down (e.g. col containing TCP).
//returns: a hashmap with keys that are IP, time, sourceport

//   uses goes through raw_data, and for each that is TCP,
//      iterates the counter for that IP
//      iterates the counter for that time
//      iterates the counter for that source port
// ******************
 
 
 //creates a hashmap for each distinct item in a particular col
 // takes in: raw_data. column to use. indices of raw_data where matching item must be, e.g.
 //                if it is creating a hashmap for all IP address of TC, then the indices
 //                here will be the indices where TCP is located.
 //   goes down column_to_use and each time a distinct item is found in that column,
 //   creates a new key for that in the hashmap, with value of 0.
 //   key: the distinct item. Value: the number of instances of that item.
 // returns: hashmap 
//HashMap<String, Integer> instances_in_col(String[][] raw_data, int traverse_indx, int matchXindex, int matchYindex) {
HashMap<String, Integer> instances_in_col(String[][] raw_data, int traverse_indx, int match1stIndex, int match2ndIndex) {
  HashMap<String, Integer> instances = new HashMap<String, Integer>();
  Integer currVal = 0;  //to hold the value at a certain key
  for (int i = 0; i <raw_data.length; i++) {
  if ((raw_data[i][match2ndIndex]).equals((raw_data[match1stIndex][match2ndIndex]))) {
        if (instances.containsKey(raw_data[i][traverse_indx])) {
          currVal = instances.get(raw_data[i][traverse_indx]);
          currVal++;
        } else {
          currVal = 0;
        }
        instances.put(raw_data[i][traverse_indx], currVal);
      }
    }
    print(instances.size());
  return instances;
}



class cmvCategories{ //x y width height
  Integer num_protocol; //2
  Integer num_op; //3
  Integer num_syslog; //1
  float posx;
  float posy;
  float w;
  float h;
  Bucket[][] Bars;
  cmvCategories(String[][] raw_data) {
    num_protocol = get_num_buckets(raw_data, PROTOCOL);
    num_op = get_num_buckets(raw_data, OP);
    num_syslog = get_num_buckets(raw_data, SYSLOG);
    Bucket[] protocol = create_bar(num_protocol, raw_data, PROTOCOL);
    Bucket[] op = create_bar(num_op, raw_data, OP);
    Bucket[] syslog = create_bar(num_syslog, raw_data, SYSLOG);
    Bars = new Bucket[][] { protocol, op, syslog };
  }
  
  //Populate an array of buckets, AKA a bar. returns this bar.
 //   (to be used in constructor 3 times to create the 3 bars).
 // args: number of buckets to be in the bar. raw_data. the column
 //       number in raw_data to be turned into bar. 
 Bucket[] create_bar(int num_buckets, String[][] raw_data, int field){
   Bucket[] newBar = new Bucket[num_buckets];
   int newBar_currPosition = 0;
   HashMap<String, Integer> source_IP = null;
   Set<String> uniqTimes = new TreeSet<String>(); //to ensure only one bucket per unique instance
   for (int i = 0; i < raw_data.length; i++) {
     if (! uniqTimes.contains(raw_data[i][field])) {
       print("here: " + raw_data[i][field] + "....");
       source_IP = instances_in_col(raw_data, SRC_IP, i, field);
//       HashMap<String, Integer> source_IP = instances_in_col(raw_data, SRC_IP, raw_data[i][field], field); //create a new bucket for type: raw_data[i][field]
       //create a hashmap for each distinct IP
       //create a hashmap for each distinct time
       //create a hashmap for each distinct port
       newBar[newBar_currPosition] = new Bucket();//INCLUDE CONSTRUCTOR ITEMS HERE
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
  
  
  cmvFilter check_hover() {
  //check if hover is over something in Categories. if it is, return valuable info, otherwise return null.
  return null;
  }
  void update(cmvFilter curr_filter) {
    
  }
}
