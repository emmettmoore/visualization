class cmvSystem {
  cmvHeat heatmap;
  cmvBars categories;
  cmvTree ip_network;
  cmvFilter filter;
  String[] headers;
  String[][] data;
  cmvSystem(String[][] parsed_data, String [] parsed_headers) {
    data = parsed_data;
    headers = parsed_headers;
    heatmap = new cmvHeat(parsed_data);
    categories = new cmvBars(parsed_data);
    ip_network = new cmvTree(parsed_data);
    
  }
  /*
  void test_data(){
    for (int i=0; i< headers.length; i++) { print(headers[i] + ' ');}
    print('\n');
     for(int i = 0; i<data.length; i++){
        for (int j = 0; j<data[0].length; j++){
          print (data[i][j] + ' ');
        }
        print('\n');
     }
  } 
  */
}
