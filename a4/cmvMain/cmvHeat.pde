class Cell {
  color cell_color;
  int count;
  boolean udp, tcp, info, teardown, built, deny;
  boolean[] source_ips;
  
  Cell(int num_source_ips) {
    cell_color = color(255);
    count = 0;
    udp = tcp = info = teardown = built = deny = false;
    source_ips = new boolean[num_source_ips];
    for (int i=0; i < num_source_ips; i++) {
      source_ips[i] = false;
    }
  }
}

class cmvHeat {
  Cell[][] data; 
  
  List<String> uniq_times;
  List<String> uniq_ports;
  List<String> uniq_src_ips;
  
  int highest_count; // used to keep track of relative count of
  cmvHeat(String[][] raw_data, List<String> uniq_src_ips1, List<String> uniq_times1, List<String> uniq_ports1) {
    uniq_times = new ArrayList<String>(uniq_times1);
    uniq_ports = new ArrayList<String>(uniq_ports1);
    uniq_src_ips = new ArrayList<String>(uniq_src_ips1);
    highest_count = 0;
    init_data();
    transform_and_load_data(raw_data);
    assign_cell_colors();
  }
  
  int get_num_buckets(Set<String> curr_set, String[][] raw_data, int field) {
    curr_set = new TreeSet<String>();
    for (int i=0; i < raw_data.length; i++) {
      curr_set.add(raw_data[i][field]);
    }
    
    return uniq_times.size();
  }
  void init_data() {
    data = new Cell[uniq_times.size()][uniq_ports.size()];
    for (int i=0; i<uniq_times.size(); i++) {
      for (int j=0; j<uniq_ports.size(); j++) {
        data[i][j] = new Cell(uniq_src_ips.size());
      }
    }
  }
    
  void transform_and_load_data(String[][] raw_data) {
    for (int i=0; i< raw_data.length; i++) {
      int time_range = uniq_times.indexOf(raw_data[i][TIME_STAMP]);
      int port_range = uniq_ports.indexOf(raw_data[i][SRC_PORT]);
      int src_ip_range = uniq_src_ips.indexOf(raw_data[i][SRC_IP]);
      data[time_range][port_range].count += 1;
      if (data[time_range][port_range].count > highest_count) {
        highest_count = data[time_range][port_range].count + 1;
        check_all_fields(data[time_range][port_range], raw_data[i], src_ip_range);
      }
    }
  }
  
  void check_all_fields(Cell curr_cell, String[] curr_element, int src_ip_range) {
    
    curr_cell.source_ips[src_ip_range] = true;
    
    if (curr_element[PROTOCOL] == "TCP") { curr_cell.tcp = true; }
    else if (curr_element[PROTOCOL] == "UPD") { curr_cell.udp = true; }
    
    if (curr_element[OP] == "Teardown") { curr_cell.teardown = true; }
    else if (curr_element[OP] == "Deny") { curr_cell.deny = true; }
    else if (curr_element[OP] == "Built") { curr_cell.built = true; }
    
    if (curr_element[OP] == "Info") { curr_cell.info = true; }
  }
  
  void assign_cell_colors() {
    //go through each cell and compare cell.count to highest_count to determine darkness
  }
  
  /****                                                                      ****
   **** PUBLIC METHODS FOR INTERACTION finding hover/displaying highlighting ****
   ****                                                                      ****/
   
  cmvFilter check_hover() {
    //check if hover is over something in heatmap. if it is, return valuable info, otherwise return null.
    return null;
  }
  void update(cmvFilter curr_filter) {
    
  }
}
