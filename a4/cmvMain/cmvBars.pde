class cmvCategories{ 
  Integer num_protocol;
  Integer num_op;
  Integer num_syslog;
  cmvCategories(String[][] raw_data) {
    num_protocol = get_num_buckets(raw_data, PROTOCOL);
    num_op = get_num_buckets(raw_data, OP);
    num_syslog = get_num_buckets(raw_data, SYSLOG);
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
