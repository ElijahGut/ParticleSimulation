import java.util.Random;

ArrayList<Ball> balls = new ArrayList<Ball>();
// initialise number of balls
int N = 20;

void setup() {
  Random random = new Random();
  size(1000, 750);
  for (int i=0;i<N;i++) {
    int randxv = 0;
    int randyv = 0;
    while (randxv == 0 || randyv == 0) {
      randxv = random.nextInt(5+5) - 5;
      randyv = random.nextInt(5+5) - 5;
    }
    Ball b = new Ball(width/2, height/2, randxv, randyv, 5);
    b.drawBall();
    balls.add(b);
  }
}

void drawTriangle() {
  triangle(width/2, 5, width/8, height-5, (width/8)*7, height-5);
}

void draw() {
  background(255);
  fill(0);
  drawTriangle();
  fill(255);
  for (int i=0;i<balls.size();i++) {
    Ball b = balls.get(i);
    b.drawBall();
    b.x += b.v[0];
    b.y += b.v[1];
    b.checkCollisionTriangle();
    if (b.hit) {
      b.checkCollisionBall(i);
    }
    b.checkCollisionRec();
  }
}
