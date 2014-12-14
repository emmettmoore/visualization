//This class will manage the instances of the heart beat class


class heart_mgr{
  int numberOfMovies = 0;
  heartbeat[] heartbeats;
  heartbeat TEMPORARY = new heartbeat();
 heart_mgr(int numMovies1) {
   numberOfMovies = numMovies1;
   heartbeats = new heartbeat[numMovies1];
 } 
 
 void update() {
    TEMPORARY.update();
 }
}
