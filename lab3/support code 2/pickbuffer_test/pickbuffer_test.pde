PGraphics pickbuffer = null;
int numCircles = 10;
MyCircle[] circles;

MyCircle[] circlesBuffer;

void setup() {
  smooth();
  size(600, 600);
  pickbuffer = createGraphics(width, height);
  
  circles = new MyCircle [numCircles];
  
  for (int i=0; i<numCircles; i++) {
    int radius = (int)random(10, 100);
    int posx = (int)random(radius, width-radius);
    int posy = (int)random(radius, height-radius);

    circles[i] = new MyCircle(i*10000, posx, posy, radius);
    
    int r = (int)random(0, 255);
    int g = (int)random(0, 255);
    int b = (int)random(0, 255);
    circles[i].setColor (r, g, b);    
    
        //draw backbuffer

  }
}

void draw () {
  background(255);

  for (int i=0; i<numCircles; i++) { 
    if (circles[i].getSelected() == true) {
      circles[i].renderSelected();
    }
    else {
      circles[i].render();
    }
  }
  
  if (keyPressed) {
    drawPickBuffer();
    image(pickbuffer, 0, 0);
  }
}

//renders the backbuffer

void drawPickBuffer() {
  pickbuffer.beginDraw();
  
  circlesBuffer = new MyCircle [numCircles];
  
for (int i =0; i < numCircles; i++) {
  int radius = circles[i].radius;
  int posx = circles[i].posx;
  int posy = circles[i].posy;
  circlesBuffer[i] = new MyCircle(i*10000, posx, posy, radius);
  
  int r = (int)random(0, 255);
  int g = (int)random(0, 255);
  int b = circles[i].id;    //requirement: 0 < id < 255
  circlesBuffer[i].setColor(r, g, b);
} 
  pickbuffer.endDraw();  
}

void mouseMoved () {
  drawPickBuffer();
  float m_x = mouseX;
  float m_y = mouseY;
  
  for (int i=0; i<numCircles; i++) { 

    //TODO: You will need to change the way that isect is called
    if (circlesBuffer[i].isect(m_x, m_y)) {
      circles[i].setSelected(true);
    } else{
      circles[i].setSelected(false);
    }
  }
}












