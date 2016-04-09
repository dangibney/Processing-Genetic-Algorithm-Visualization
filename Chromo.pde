class Chromo {
  float xRange = width;
  float yRange = height;
  int x;
  int y;
  int tag;
  float angle;
  float fitness;
  
  Chromo(int t) {
    x = (int)random(xRange);
    y = (int)random(yRange);
    angle = random(2*PI);
    tag = t;
  }
  
  int getX() { return x; }
  
  int getY() { return y; }
  
  void setFitness(float f) {
    fitness = f;
  }
  
  void display() {
    pushMatrix();
    translate(x, y);
    rotate(angle);
    fill(tagColor[tag]);
    ellipse(0, 0, 15, 5);
    popMatrix();
  }
}