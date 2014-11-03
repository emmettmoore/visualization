class cmvFilter{
   int magic_chart; //CATEGORY, NETWORK, HEAT
   //CATEGORY
   String category; // "udp" "tcp" "built" "teardown" "deny" "info"
   //NETWORK
   String source_ip;
   //HEAT
   String port_range;
   String time_range;
   cmvFilter(int mc, String c, String s_ip, String p_r, String t_r) {
     magic_chart = mc;
     category = c;
     source_ip = s_ip;
     port_range = p_r;
     time_range = t_r;
  }  

}
