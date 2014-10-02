int numPoints = 4;
Point[] shape;

Point endP;

void setup() {
    size(400, 400);
    smooth();
    shape = new Point[numPoints];
    endP = new Point();

    makeRandomShape();

    frame.setResizable(true);
}

void draw() {
    background(255, 255, 255);
    stroke(0, 0, 0);

    drawShape();
    if (mousePressed == true) {
        stroke(255, 0, 0);
        line(mouseX, mouseY, endP.x, endP.y);

        fill(0, 0, 0);
        Point p1 = new Point();
        p1.x = mouseX;
        p1.y = mouseY;
        int count = 0;
        boolean isect;
        int i;
        for( i = 0; i<shape.length-1;i++){
             isect = isectTest(p1,endP,shape[i],shape[i+1]);
            if (isect == true) {
              count++;
            }
        }
        if (isectTest(p1,endP,shape[i],shape[0])) {
              count++;
        }
        print (count);
        if(count%2 == 0){
                  text("Outside", mouseX, mouseY);
        }
        else{
                text("Inside", mouseX, mouseY);
                return;   
        }
        

    }
}

void mousePressed() {
    endP.x = random(-1, 1) * 2 * width;
    endP.y = random(-1, 1) * 2 * height;
}

void drawShape() {
for (int i = 0; i < numPoints; i++) {

        int start = i;
        int end = (i + 1) % numPoints;

        line(shape[start].x, 
             shape[start].y,
             shape[end].x, 
             shape[end].y);
    }
}

boolean isectTest(Point p1, Point q1, Point p2, Point q2) {
float a1 = p1.y - q1.y;
float b1 = q1.x - p1.x;
float c1 = q1.x * p1.y - p1.x * q1.y;
float a2 = p2.y - q2.y;
float b2 = q2.x - p2.x;
float c2 = q2.x * p2.y - p2.x * q2.y;
float det = a1 * b2 - a2 * b1;
//if (det == 0) {
if (isBetween(det, -0.0000001, 0.0000001)) {
return false;
} else {
float isectx = (b2 * c1 - b1 * c2) / det;
float isecty = (a1 * c2 - a2 * c1) / det;
    ellipse(isectx, isecty,10,10);
    println ("isectx: " + isectx + " isecty: " + isecty);if ((isBetween(isecty, p1.y, q1.y) == true) &&
(isBetween(isecty, p2.y, q2.y) == true) &&
(isBetween(isectx, p1.x, q1.x) == true) &&
(isBetween(isectx, p2.x, q2.x) == true)) {
return true;
}
}
return false;
}

boolean isBetween(float val, float range1, float range2) {
    float largeNum = range1;
    float smallNum = range2;
    if (smallNum > largeNum) {
        largeNum = range2;
        smallNum = range1;
    }

    if ((val < largeNum) && (val > smallNum)) {
        return true;
    }
    return false;
}

void makeRandomShape() {
    float slice = 360.0 / (float) numPoints;
    for (int i = 0; i < numPoints; i++) {

        float radius = (float) random(5, 100);
        shape[i] = new Point();
        shape[i].x = radius * cos(radians(slice * i)) +width/2.0f;
        shape[i].y = radius * sin(radians(slice * i)) +height/2.0f;
    }
}
