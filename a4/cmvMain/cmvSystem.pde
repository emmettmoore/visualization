class cmvSystem {
  cmvHeat heatmap;
  cmvCategories categories;
  cmvTree ip_network;
  cmvFilter filter;
  String[] headers;
  String[][] data;
  List<String> uniq_times;
  List<String> uniq_ports;
  List<String> uniq_src_ips;
  cmvSystem(String[][] parsed_data, String [] parsed_headers) {
    data = parsed_data;
    headers = parsed_headers;
    uniq_src_ips = populate_uniq_list(data, SRC_IP);
    uniq_times = populate_uniq_list(data, TIME_STAMP);
    uniq_ports = populate_uniq_list(data, SRC_PORT);
    heatmap = new cmvHeat(0, 0.75 * width, width, 0.25 * height, parsed_data, uniq_src_ips, uniq_times, uniq_ports);
    
    categories = new cmvCategories(0.75 * width, 0, 0.25 * width, 0.75 * height, parsed_data);
    ip_network = new cmvTree(parsed_data);
    
  }
  List<String> populate_uniq_list(String[][] raw_data, int field) {
    Set<String> curr_set = new TreeSet<String>();
    for (int i=0; i < raw_data.length; i++) {
      curr_set.add(raw_data[i][field]);
    }
    return new ArrayList<String>(curr_set);
  }
  
  cmvFilter check_hover() {
    cmvFilter new_filter = ip_network.check_hover();
    if (new_filter != null) {
      return new_filter;
    }
    new_filter = heatmap.check_hover();
    if (new_filter != null) {
      return new_filter;
    }
    return categories.check_hover();
  }
  void update() {
    filter = check_hover();
    heatmap.update(filter);
    categories.update(filter);
    ip_network.update(filter);
  }
}
