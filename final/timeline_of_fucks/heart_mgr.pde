//TO DO : calculate heart rate in this class not in the timeline_of_fucks class


//This class will manage the instances of the heart beat class

class heart_mgr{
   int numOfMovies = 0;
   heartbeat[] heartbeats;
   boolean DisplayFirst = false;
   boolean DisplaySecond = false;
   boolean DisplayThird = false;
   //int[] heartRates;
   float[] numMinutes;
   float[] numFWords;
//   heartbeat TEMPORARY = new heartbeat();
   //heart_mgr(int numMovies1, int heartRate1, int heartRate2, int heartRate3) {
     heart_mgr(int numMovies1, float mins1, float numF1, float mins2, float numF2, float mins3, float numF3){
   numOfMovies = numMovies1;
   heartbeats = new heartbeat[numMovies1];
   numMinutes = new float[numMovies1];
   numFWords = new float[numMovies1];
   //heartRates = new int[numMovies1];
   //heartRates[0] = heartRate1;
   numMinutes[0] = mins1;
   numFWords[0] = numF1;
   if (numMovies1 >= 2) {
     numMinutes[1] = mins2;
     numFWords[1] = numF2;
     //heartRates[1] = heartRate2;
   }
   if (numMovies1 > 2) {
     numMinutes[2] = mins3;
     numFWords[2] = numF3;
//     heartRates[2] = heartRate3;
   }
   populate_data();
 } 
 
 void update() {
   if (DisplayFirst == true) {
     heartbeats[0].update();
   }
   if (DisplaySecond == true) {
     heartbeats[1].update();
   }
   if (DisplayThird == true) {
     heartbeats[2].update();
   }
//   for (int i = 0; i < heartbeats.length; i++) {
//     heartbeats[i].update();
//   }
//    TEMPORARY.update();
 }
 
 void populate_data() {

   int Baseline  = 130;     //TODO: add modularity here so that other number of movies can be given and it will calc these position values
   for (int i = 0; i < numOfMovies; i++) {
//  for (int i = 0; i < numOfMovies -1; i++) {
     //heartbeats[i] = new heartbeat(0, Baseline, heartRates[i]);
     heartbeats[i] = new heartbeat(0, Baseline, numMinutes[i], numFWords[i], 0);
     Baseline = Baseline + 200;
   }
   //heartbeats[numOfMovies-1] = new heartbeat(0, (int)(.9*height), (MIN_ALLOWABLE_INVERSE + 10));//heartRates[i]);
     
 }
}
