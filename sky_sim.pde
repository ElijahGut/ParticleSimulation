import java.util.Random;

ArrayList<Ball> balls = new ArrayList<Ball>();

// GLOBAL PARAMS
int N = 20;

// button vars
String currentMode = "REC";
boolean recMode = true;
boolean triMode = false;
boolean circMode = false;
boolean rectOver = false;
boolean circleOver = false;
boolean triOver = false;
color highlight;
int rectX, rectY;      // Position of square button
int circleX, circleY;  // Position of circle button
int triX, triY;
int rectSize = 30;  
int circleSize = 30;
int triSize = 15;
int x1, y1, x2, y2, x3, y3;

void setup() {
  background(255);
  balls.clear();
  Random random = new Random();
  size(1000, 750);
  rectX = width/8;
  rectY = height/8;
  circleX = width/8 + width/16;
  circleY = height/8 + circleSize/2;
  triX = width/4-triSize;
  triY = height/8 + triSize;
  x1 = triX;
  y1 = triY-triSize;
  x2 = triX-triSize;
  y2 = triY+triSize;
  x3 = triX+triSize;
  y3 = triY+triSize;
  highlight = 100;
  
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
  triangle(width/2, (height/2)-height/4, (width/2)-width/4, (height/2)+height/4, (width/2)+width/4, (height/2)+height/4);
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
    triOver = false;
  } else if ( overRect(rectX, rectY, rectSize, rectSize) ) {
    rectOver = true;
    circleOver = false;
    triOver = false;
  } else if ( overTri(triX, triY) ) {
    triOver = true;
    circleOver = false;
    rectOver = false;
  } else {
    circleOver = rectOver = triOver = false;
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
    setup();
  }
  if (rectOver) {
    recMode = true;
    resolveMode();
    currentMode = "REC";
    setup();
  } 
  if (triOver) {
    triMode = true;
    resolveMode();
    currentMode = "TRI";
    setup();
  }
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

boolean overTri(int x, int y) {
  float A = Utils.calcArea(x1,y1,x2,y2,x3,y3);
  float A1 = Utils.calcArea(mouseX, mouseY, x2, y2, x3, y3);
  float A2 = Utils.calcArea(mouseX, mouseY, x1, y1, x3, y3);
  float A3 = Utils.calcArea(mouseX, mouseY, x1, y1, x2, y2);
  return (A1+A2+A3) == A;
}

void draw() {
  update(mouseX, mouseY);
  background(255);
  
  if (rectOver) {
    fill(highlight);
  } else {
    fill(0);
  }
  
  rect(rectX, rectY, rectSize, rectSize);
  
  if (circleOver) {
    fill(highlight);
  } else {
    fill(0);
  }
  
  ellipse(circleX, circleY, circleSize, circleSize);
  
  if (triOver) {
    fill(highlight);
  } else {
    fill(0);
  }
  
  triangle(x1,y1,x2,y2,x3,y3);
  
  fill(0);
  
  switch (currentMode) {
    case "REC":
      drawRectangle();
      break;
    case "CIRC":
      drawCircle();
      break;
    case "TRI":
      drawTriangle();
  }
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
      case "TRI":
        b.checkCollisionTriangle();
        break;
    }
    if (b.hit) {
      b.checkCollisionBall(i);
    }
  }
}
