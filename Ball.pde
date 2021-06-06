class Ball {
  int x, y = 0;
  int[] v;
  public Ball(int x, int y, int xv, int yv) {
    this.x = x;
    this.y = y;
    this.v = new int[2];
    this.v[0] = xv;
    this.v[1] = yv;
  }
  void drawBall() {
    circle(this.x,this.y,10);
  }
  void checkWall() {
    if (this.x >= width-5 || this.x <= 5) {
      this.v[0] = -this.v[0];
    }
    if (this.y >= height-5 || this.y <= 5) {
      this.v[1] = -this.v[1];
    }
  }
  
  void checkCollision(int index) {
    for (int i=0;i<balls.size();i++) {
      if (i != index) {
        Ball b2 = balls.get(i);
        float d = dist(this.x, this.y, b2.x, b2.y);
        if (d <= 20) {
          int[] oldV = this.v;
          this.v = b2.v;
          b2.v = oldV;
        }
      }
    }
  }
}
