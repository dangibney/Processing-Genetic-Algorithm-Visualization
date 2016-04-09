class Cone{
  int centerX;
  int centerY;
  float coneHeight;
  float radius;
  Cone(int x, int y, float h, float r) {
    centerX =x;
    centerY = y;
    coneHeight = h;
    radius = r;
  }
  
  int getCenterX() { return centerX; }
  
  void setCenterX(int x){
    centerX = x;
  }
  
  int getCenterY() { return centerY; }
  
  void setCenterY(int y) {
    centerY = y;
  }
  float getHeight() { return coneHeight; }
  
  void setHeight(float h) {
      coneHeight = h;
  } 
  
  float getValue(int x, int y) {
    float dist = dist(x, y, centerX, centerY);
    float value = -1 * (coneHeight / radius ) * dist + coneHeight;
    if (value > 0) return value;
    else return 0;
  }
}