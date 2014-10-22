import java.sql.ResultSet;
import java.util.Arrays;      //TAYLOR
//TO DO : incorporate sliders into sql query
//can i sort by the y values in the result? how.


String table_name = "forestfire";
//String keysX[] = null;
float keysX[] = null;
float valuesY[] = null;

/**
 * @author: Fumeng Yang
 * @since: 2014
 * we handle the events from the interface for you
 */

void controlEvent(ControlEvent theEvent) {
    if (interfaceReady) {
        if (theEvent.isFrom("checkboxMon") ||
            theEvent.isFrom("checkboxDay")) {
            submitQuery();
        }
        if (theEvent.isFrom("Temp") ||
            theEvent.isFrom("Humidity") ||
            theEvent.isFrom("Wind")) {
            queryReady = true;
        }

        if (theEvent.isFrom("Close")) {
            closeAll();
        }
    }
}

/**
 * generate and submit a query when mouse is released.
 * don't worry about this method
 */
void mouseReleased() {
    if (queryReady == true) {
        submitQuery();
        queryReady = false;
    }
}

void submitQuery() {
    /**
     ** Finish this
     **/
     
//mine:

int numMonths = checkboxMon.getItems().size();
int numDays = checkboxDay.getItems().size();
int maxMonthIndex = 0;
int maxDayIndex = 0;
String currMonth; 
String currDay;
String allMonthsString = "";    //Giant string of months with commas and single quotes between each month
String allDaysString = "";      //Giant string of days with commans and single quotes between them
for (int i = 0; i < numMonths; i++) {
  if (checkboxMon.getState(i) == true) {
    maxMonthIndex = i;
  }
}
for (int i = 0; i < numDays; i++) {
  if (checkboxDay.getState(i) == true) {
    maxDayIndex = i;
  }
}
int numMonthsAdded = 0;
for (int i = 0; i < numMonths; i++) {
  if (checkboxMon.getState(i) == true) {
    currMonth = checkboxMon.getItem(i).getName();
    if (i == maxMonthIndex) {    //when its the last month:
      allMonthsString += "'" + currMonth + "'";
    } else {                      //when its NOT the last month:
      allMonthsString += "'" + currMonth + "', ";
    }
  }
}
for (int i = 0; i < numDays; i++) {
  if (checkboxDay.getState(i) == true) {
    currDay = checkboxDay.getItem(i).getName();
    if (i == maxDayIndex) {    //when its the last day:
      allDaysString += "'" + currDay + "'";
    } else {                      //when its NOT the last day:
      allDaysString += "'" + currDay + "', ";
    }
  }
}

//float currTempMin = rangeTempValue[0];
float currTempMin = rangeTemp.getLowValue();
float currTempMax = rangeTemp.getHighValue();
float currHumMin = rangeHumidity.getLowValue();
float currHumMax = rangeHumidity.getHighValue();
float currWindMin = rangeWind.getLowValue();
float currWindMax = rangeWind.getHighValue();

String sql = "SELECT id, X, Y, month, day, temp, humidity, wind FROM forestfire WHERE (month IN (" + allMonthsString + ")) AND ( day IN (" + allDaysString + ")) ";

//mine^^
    /** abstract information from the interface and generate a SQL
     ** use int checkboxMon.getItems().size() to get the number of items in checkboxMon
     ** use boolean checkboxMon.getState(index) to check if an item is checked
     ** use String checkboxMon.getState(index).getName() to get the name of an item
     **
     ** checkboxDay (Mon-Sun) is similar with checkboxMon
     **/
    println("the " + checkboxMon.getItem(0).getName() + " is " + checkboxMon.getState(0));


    /** use getHighValue() to get the upper value of the current selected interval
     ** use getLowValue() to get the lower value
     **
     ** rangeHumidity and rangeWind are similar with rangeTemp
     **/
//    float maxTemp = rangeTemp.getHighValue();
//    float minTemp = rangeTemp.getLowValue();

    /** Finish this
     **
     ** finish the sql
     ** do read information from the ResultSet
     **/
//    String sql = null;
    ResultSet rs = null;

    try {
        // submit the sql query and get a ResultSet from the database
       rs  = (ResultSet) DBHandler.exeQuery(sql);
//      ArrayList<String> tempX = new ArrayList<String>();
      ArrayList<Float> tempX = new ArrayList<Float>();
      ArrayList<Float> tempY = new ArrayList<Float>();

      while (rs.next()) {      //add the X and Ys into temporary arrays
      //   tempX.add(rs.getString("X"));
         tempX.add(rs.getFloat("X"));

         tempY.add(rs.getFloat("Y"));
      }
      print("Size tempx: " + tempX.size() + ", Size tempy: " + tempY.size());
//      keysX = new String[tempX.size()];    //use the temp arrays to make size of label arrays
      keysX = new float[tempX.size()];    //use the temp arrays to make size of label arrays

      valuesY = new float[tempY.size()];

     for (int i  = 0; i < tempY.size(); i++) {    //use tempy to populate the valuesy array
       valuesY[i] = (tempY.get(i));
       print(tempY.get(i) + " ");
       print(valuesY[i] + "\n");
     }
    for (int i  = 0; i < tempX.size(); i++) {      //use tempx to populated the keysx array
       keysX[i] = (tempX.get(i));
       print(tempX.get(i) + " ");
       print(keysX[i] + "\n");
     }

    } catch (Exception e) {
        // should be a java.lang.NullPointerException here when rs is empty
        e.printStackTrace();
    } finally {
        closeThisResultSet(rs);
    }
}

void closeThisResultSet(ResultSet rs) {
    if(rs == null){
        return;
    }
    try {
        rs.close();
    } catch (Exception ex) {
        ex.printStackTrace();
    }
}

void closeAll() {
    DBHandler.closeConnection();
    frame.dispose();
    exit();
}
