class Ball {
  int x, y, r = 0;
  int[] v;
  boolean hit = false;
  public Ball(int x, int y, int xv, int yv, int r) {
    this.x = x;
    this.y = y;
    this.v = new int[2];
    this.v[0] = xv;
    this.v[1] = yv;
    this.r = r;
  }
  void drawBall() {
    ellipse(this.x,this.y,this.r*2, this.r*2);
  }
  void checkCollisionRec() {
    if (this.x >= width-10 || this.x <= 10) {
      this.v[0] = -this.v[0];
    }
    if (this.y >= height-10 || this.y <= 10) {
      this.v[1] = -this.v[1];
    }
  }
  
  float calcArea(int x1, int y1, int x2, int y2, int x3, int y3) {
    return abs((x1*(y2-y3) + x2*(y3-y1)+ x3*(y1-y2))/2.0);
  }
  
  boolean isTriInterior() {
    float A = calcArea(width/2, 5, width/8, height-5, (width/8)*7, height-5);
    float A1 = calcArea(this.x, this.y, width/2, 5, width/8, height-5);
    float A2 = calcArea(this.x, this.y, width/2, 5, (width/8)*7, height-5);
    float A3 = calcArea(this.x, this.y, width/8, height-5, (width/8)*7, height-5);
    return (A1+A2+A3) == A;
  }
  
  void checkCollisionTriangle() {
    boolean tri = isTriInterior();
    if (!tri) {
      this.hit = true;
      this.v[0] = -this.v[0];
      this.v[1] = -this.v[1];
    }
  }
  
  void checkCollisionBall(int index) {
    for (int i=0;i<balls.size();i++) {
      if (i != index) {
        Ball b2 = balls.get(i);
        float d = dist(this.x, this.y, b2.x, b2.y);
        if (d <= 4*this.r) {
          int[] oldV = this.v;
          this.v = b2.v;
          b2.v = oldV;
        }
      }
    }
  }
}
