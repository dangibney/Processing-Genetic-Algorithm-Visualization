class GA {
  int popSize;
  float mutationRate, crossoverRate;
  ArrayList<Chromo> generation;
  ArrayList<Chromo> nextGeneration;
  
  GA(int n, float m, float c) {
    popSize = n;
    mutationRate = m;
    crossoverRate = c;
    generation = new ArrayList<Chromo>();
    for(int i = 0; i < popSize; i++){
      generation.add(new Chromo((int)random(numberOfTags)));
    }
  }
  
  void selection() {
    nextGeneration = new ArrayList<Chromo>();
    for(int i = 0; i < generation.size(); i++) {
      Chromo member = generation.get(i);
      int x = member.x;
      int y = member.y;
      generation.get(i).setFitness(fitness(x, y));
    }
  }
  
  void display() {
    for(int i = 0; i < generation.size(); i++) {
      generation.get(i).display();
    }
  }
}