import java.util.Random;

ArrayList<Ball> balls = new ArrayList<Ball>();

// GLOBAL PARAMS
int N = 50;

// button vars
String currentMode = "REC";
boolean recMode = true;
boolean triMode = false;
boolean circMode = false;
boolean rectOver = false;
boolean circleOver = false;
boolean triOver = false;
int rectX, rectY;      // Position of square button
int circleX, circleY;  // Position of circle button
int rectSize = 30;     // Diameter of rect
int circleSize = 30;   // Diameter of circle


void setup() {
  background(255);
  balls.clear();
  Random random = new Random();
  size(1000, 750);
  rectX = width/8;
  rectY = height/8;
  circleX = width/8 + width/16;
  circleY = height/8 + circleSize/2;
  
  for (int i=0;i<N;i++) {
    int randxv = 0;
    int randyv = 0;
    while (randxv == 0 || randyv == 0) {
      randxv = random.nextInt(5+5) - 5;
      randyv = random.nextInt(5+5) - 5;
    }
    Ball b = new Ball(width/2, height/2, randxv, randyv, 5, i);
    b.drawBall();
    balls.add(b);
  }
}

void drawTriangle() {
  triangle(width/2, 5, width/8, height-5, (width/8)*7, height-5);
}

void drawCircle() {
  circle(width/2, height/2, width/2);
}

void drawRectangle() {
  rect(width/4, height/4, width/2, height/2);
}

// button feature

void update(int x, int y) {
  if ( overCircle(circleX, circleY, circleSize) ) {
    circleOver = true;
    rectOver = false;
  } else if ( overRect(rectX, rectY, rectSize, rectSize) ) {
    rectOver = true;
    circleOver = false;
  } else {
    circleOver = rectOver = false;
  }
}

void resolveMode() {
  if (currentMode.equals("REC")) {
    recMode = false;
  } else if (currentMode.equals("CIRC")) {
    circMode = false;
  } else {
    triMode = false;
  }
}

void mousePressed() {
  if (circleOver) {
    circMode = true;
    resolveMode();
    currentMode = "CIRC";
  }
  if (rectOver) {
    recMode = true;
    resolveMode();
    currentMode = "REC";
  } 
  if (triOver) {
    triMode = true;
    resolveMode();
    currentMode = "TRI";
  }
  setup();
}

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}

boolean overTri() {
  // TODO
  return true;
}

void draw() {
  update(mouseX, mouseY);
  background(255);
  fill(0);
  rect(rectX, rectY, rectSize, rectSize);
  ellipse(circleX, circleY, circleSize, circleSize);
  switch (currentMode) {
    case "REC":
      drawRectangle();
      break;
    case "CIRC":
      drawCircle();
      break;
  }
  //drawTriangle();
  fill(255);
  for (int i=0;i<balls.size();i++) {
    Ball b = balls.get(i);
    b.drawBall();
    b.x += b.v[0];
    b.y += b.v[1];
    switch (currentMode) {
      case "REC":
        b.checkCollisionRectangle(width/4, height/4, (width/4)*3, (height/4)*3);
        break;
      case "CIRC":
        b.checkCollisionCircle();
        break;
    }
    //b.checkCollisionTriangle();
    if (b.hit) {
      b.checkCollisionBall(i);
    }
  }
}
