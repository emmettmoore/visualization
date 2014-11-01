int TIME_STAMP = 0;
class cmvHeat {
  ArrayList[][] data;
  

  
  cmvHeat(String[][] raw_data) {
    Integer num_time_ranges = get_time_ranges(raw_data);
  }
  
  int get_time_ranges(String[][] raw_data) {
    Set<String> uniqTimes = new TreeSet<String>();
    for (int i=0; i < raw_data.length; i++) {
      uniqTimes.add(raw_data[i][TIME_STAMP]);
    }
    return uniqTimes.size();
  }

}
/*
Integer[] numbers = {1, 1, 2, 1, 3, 4, 5};
Set<Integer> uniqKeys = new TreeSet<Integer>();
uniqKeys.addAll(Arrays.asList(numbers));
System.out.println("uniqKeys: " + uniqKeys);

    //data =  new ArrayList<ArrayList>(buttonInterface.animOrder);
  data = new ArrayList[10][10]; // get lengths!!!
  
/*  for (int i=0; i < ___; i++) {
   
  }*/
//  data[0][0] = new ArrayList(); // add another ArrayList object to [0,0]
  
  //data[0][0].add(); // add object to that ArrayList
