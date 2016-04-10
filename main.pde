int sizeOfPopulation = 100;
float mutationRate = 0.005;
float crossoverRate = 0.8;
float uniformCrossoverBitRate = 0.001;
float maxPeakHeight = 100.0;
float maxXValue = 500;
float maxYValue = 500;
Cone cone1;
Cone cone2;
GA ga;
// build dynamics where cones move how every you want
int dynamic = 0;
int step1 = 5;
int numberOfTags = 32;
int[] tagColor = new int[numberOfTags];

void setup() {
  //frameRate(1);
  size(500,500);
  // Cone(xPos, yPos, peakHeight, radius);
  if(dynamic == 0) {
    cone1 = new Cone(maxXValue/2, maxYValue/2, maxPeakHeight, maxXValue/6);
    cone2 = new Cone(maxXValue/2, maxYValue/2, maxPeakHeight, maxXValue/6);
  } else if (dynamic == 1) {
    cone1 = new Cone(maxXValue/2 + maxXValue/4, maxYValue/2 - maxYValue/10, maxPeakHeight - maxPeakHeight/10, maxXValue/3);
    cone2 = new Cone(maxXValue/2 - maxXValue/4, maxYValue/2 + maxYValue/10, maxPeakHeight, maxXValue/6);    
  }
  
  ga = new GA(sizeOfPopulation, mutationRate, crossoverRate);
  for(int i = 0; i < tagColor.length; i++) {
    tagColor[i] = color(random(255), random(255), random(255));
  }
}


void draw() {
  drawFitness();
  if (dynamic == 0) {
    cone1.setX((cone1.getX() - maxXValue*0.001));
    cone2.setX((cone2.getX() + maxXValue*0.001));
  } else if (dynamic == 1) {
    cone1.setX((cone1.getX() + maxXValue*0.0008) % maxXValue);
    cone1.setY((cone1.getY() + maxYValue*0.001) % maxYValue);
    cone2.setX((cone2.getX() + maxXValue*0.006) % maxXValue);
  }
  // add more dynamics as needed
  
  ga.display();
  //ga.computeFitness();
  // divide by subpopulation size for fitness sharing
  ga.computeFitnessSharing();
  //ga.printGeneration();
  ga.select();
  ga.mutate();
  ga.crossover();
}

void drawFitness() {
  loadPixels();
  for(int x = 0; x < width; x++) {
    for(int y = 0; y < height; y++) {
      int xMapped = (int)map(x, 0, width, 0, maxXValue);
      int yMapped = (int)map(y, 0, height, 0, maxYValue);
      int shade = (int)map(fitness(xMapped, yMapped), 0, maxPeakHeight, 255, 0);
      pixels[x + y*height] = color(shade);
    }
  }
  updatePixels();
}

float fitness(float x, float y) {
  return max(cone1.getValue(x, y), cone2.getValue(x, y), 0);
}