class Chromo implements Comparable {
  float xRange = maxXValue;
  float yRange = maxYValue;
  float x;
  float y;
  int tag;
  float angle;
  float fitness;
  
  Chromo(float x, float y, int t) {
    this.x = x;
    this.y = y;
    angle = random(2*PI);
    tag = t;
  }
  
  Chromo(int t) {
    x = random(xRange);
    y = random(yRange);
    angle = random(2*PI);
    tag = t;
  }
  
  float getX() { return x; }
  
  float getY() { return y; }
  
  float getFitness() { return fitness; }
  
  int getTag() { return tag; }
  
  void setX(float x) {
    this.x = x;
  }
  
  void setY(float y) {
    this.y = y;
  }
  
  void setFitness(float f) {
    fitness = f;
  }
  
  int compareTo(Object o){
    Chromo c = (Chromo)o;
    if(fitness == c.getFitness()) return 0;
    if(fitness > c.getFitness()) return 1;
    else return -1;
  }
  
  void display() {
    pushMatrix();
    int mappedX = (int)map(x, 0, xRange, 0, width);
    int mappedY = (int)map(y, 0, yRange, 0, height);
    translate(mappedX, mappedY);
    rotate(angle);
    fill(tagColor[tag]);
    ellipse(0, 0, 15, 5);
    popMatrix();
  }
  
  char[] toGreyCodeCharArray() {
    String xStr = GreyCode.valueToCode((int)map(x, 0, maxXValue, 0, MAX_INT));
    String yStr = GreyCode.valueToCode((int)map(y, 0, maxYValue, 0, MAX_INT));
    char[] chromo = (xStr + yStr).toCharArray();
    return chromo;
  }
  
  void setValuesFromGreyCodeCharArray(char[] code) {
    String chromoStr = new String(code);
    String newX = chromoStr.substring(0, 32);
    String newY = chromoStr.substring(32, 64);
    x = map(GreyCode.codeToValue(newX), 0, MAX_INT, 0, maxXValue);
    y = map(GreyCode.codeToValue(newY), 0, MAX_INT, 0, maxYValue);
  }
  
  String toString() {
    return "x: " + x + ", " + "y: " + y + ", fitness: " + fitness;
  }
}