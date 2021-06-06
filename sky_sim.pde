import java.util.Random;

ArrayList<Ball> balls = new ArrayList<Ball>();

void setup() {
  Random random = new Random();
  size(800, 500);
  background(0);
  for (int i=0;i<=height;i+=100) {
    for (int j=0;j<=width;j+=100) {
      if (j > 0 && j < width && i > 0 && i < height) {
        int randxv = 0;
        int randyv = 0;
        while (randxv == 0 || randyv == 0) {
          randxv = random.nextInt(5+5) - 5;
          randyv = random.nextInt(5+5) - 5;
        }
        Ball b = new Ball(j, i, randxv, randyv);
        b.drawBall();
        balls.add(b);
      }
    }
  }
}

void draw() {
  background(0);
  for (int i=0;i<balls.size();i++) {
    Ball b = balls.get(i);
    b.drawBall();
    b.x += b.v[0];
    b.y += b.v[1];
    b.checkCollision(i);
    b.checkWall();
  }
}
