class cmvSystem {
  cmvHeat heatmap;
  cmvBars categorical_bars;
  cmvTree tree;
  cmvFilter filter;
  String[] headers;
  String[][] data;
  cmvSystem(String[][] parsed_data, String [] parsed_headers) {
    data = parsed_data;
    headers = parsed_headers;
    
  }

  void test_data(){
    for (int i=0; i< headers.length; i++) { print(headers[i] + ' ');}
    print('\n');
    /* for(int i = 0; i<data.length; i++){
        for (int j = 0; j<data[0].length; j++){
          print (data[i][j] + ' ');
        }
        print('\n');
     }*/
  } 

}
