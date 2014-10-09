class Data {
    class DataPoint {
        private float value = -1;
        private boolean marked = false;

        DataPoint(float f, boolean m) {
            this.value = f;
            this.marked = m;
        }

        boolean isMarked() {
            return marked;
        }

        void setMark(boolean b) {
            this.marked = b;
        }

        float getValue() {
            return this.value;
        }
        
    }

    private DataPoint[] data = null;

    Data() {
        // NUM is a global variable in support.pde
        data = new DataPoint[NUM];
        int min = 20;
        int max = 90;
         
        for (int i = 0; i < NUM; i++) {
          Random rand = new Random();
          int randomNum = rand.nextInt((max - min) + 1) + min;
          data[i].value = randomNum;
        }
        /**
         ** finish this: how to generate a dataset and mark two of the datapoints
         ** 
         **/
    }
    
    void setMark(int index, boolean marked) {
       data[index].setMark(marked);
      
    }
    boolean isMarked(int index) {
      return data[index].isMarked();
    }
        /**
         ** finish this: the rest methods and variables you may want to use
         ** 
         **/
}
