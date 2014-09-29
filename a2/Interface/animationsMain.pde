animInterface buttonInterface;
void setup(){
  size(600,600);
  frame.setResizable(true);
  background(250,250,250);
  buttonInterface = new animInterface(); 
}

void draw(){
  buttonInterface.update();
}

