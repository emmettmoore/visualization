import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.TreeMap; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class squarifiedTreemaps extends PApplet {


TreeMap treemap;
String lines[];
public void setup(){
 lines = loadStrings("hierarchy.shf");
  int num_leaves = Integer.parseInt(lines[0]);
  print (num_leaves);
}

public void draw(){
  
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "squarifiedTreemaps" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
