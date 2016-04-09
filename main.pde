int n = 100;
float m = 0.001;
float c = 0.6;
float maxPeakHeight = 100;
Cone cone1;
Cone cone2;
GA ga;
int dynamic = 0;
int step1 = 5;
int numberOfTags = 2;
int[] tagColor = new int[numberOfTags];

void setup() {
  size(500,500);
  cone1 = new Cone(150, 200, maxPeakHeight, 100);
  cone2 = new Cone(350, 200, maxPeakHeight, 100);
  ga = new GA(n, m, c);
  for(int i = 0; i < tagColor.length; i++) {
    tagColor[i] = color(random(255), random(255), random(255));
  }
}


void draw() {
  drawFitness();
  if (dynamic == 0) {
    cone1.setCenterX((cone1.getCenterX() + 1) % width);
    cone2.setCenterX((cone2.getCenterX() + 5) % width);
  }
  // add more dynamics as needed
  
  ga.display();
  
}

void drawFitness() {
  loadPixels();
  for(int x = 0; x < width; x++) {
    for(int y = 0; y < height; y++) {
      int shade = (int)map(fitness(x, y), 0, maxPeakHeight, 0, 255);
      pixels[x + y*height] = color(shade);
    }
  }
  updatePixels();
}

float fitness(int x, int y) {
  return max(cone1.getValue(x, y), cone2.getValue(x,y), 0);
}