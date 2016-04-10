class Cone{
  float x;
  float y;
  float coneHeight;
  float radius;
  Cone(float x, float y, float h, float r) {
    this.x =x;
    this.y = y;
    coneHeight = h;
    radius = r;
  }
  
  float getX() { return x; }
  
  float getY() { return y; }
  
  float getHeight() { return coneHeight; }
  
  void setX(float x){
    this.x = x;
  }
  
  void setY(float y) {
    this.y = y;
  }

  void setHeight(float h) {
      coneHeight = h;
  } 
  
  float getValue(float xPos, float yPos) {
    float dist = dist(xPos, yPos, x, y);
    float value = -1 * (coneHeight / radius ) * dist + coneHeight;
    if (value > 0) return value;
    else return 0;
  }
}