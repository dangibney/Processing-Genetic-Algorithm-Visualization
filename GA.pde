import java.util.Collections;

class GA {
  int popSize;
  int[] subpopSize;
  Chromo[][] partitionedPopulation;
  float mutationRate, crossoverRate;
  ArrayList<Chromo> population;
  
  GA(int n, float m, float c) {
    popSize = n;
    mutationRate = m;
    crossoverRate = c;
    population = new ArrayList<Chromo>();
    for(int i = 0; i < popSize; i++){
      population.add(new Chromo((int)random(numberOfTags)));
    }
  }
  
  // computes proportional fitness for each member
  void computeFitness() {
    float sum = 0;
    float fitnessTemp[] = new float[popSize];
    for(int i = 0; i < popSize; i++) {
      Chromo member = population.get(i);
      float x = member.getX();
      float y = member.getY();
      float fitness = fitness(x, y);
      fitnessTemp[i] = fitness;
      sum += fitness;
    }
    for(int i = 0; i < popSize; i++) {
      population.get(i).setFitness(fitnessTemp[i] / sum) ;
    }
  }
    // computes proportional fitness for each member
  void computeFitnessSharing() {
    partitionPopulation();
    float sum = 0;
    float fitnessTemp[] = new float[popSize];
    for(int i = 0; i < popSize; i++) {
      Chromo member = population.get(i);
      float x = member.getX();
      float y = member.getY();
      float fitness = fitness(x, y) / subpopSize[member.getTag()];
      fitnessTemp[i] = fitness;
      sum += fitness;
    }
    for(int i = 0; i < popSize; i++) {
      population.get(i).setFitness(fitnessTemp[i] / sum) ;
    }
  }
  
  // makes current population into selected
  void select() {
    ArrayList<Chromo> selected = new ArrayList<Chromo>();
    Collections.sort(population, Collections.reverseOrder());
    for(int i = 0; i < popSize; i++) {
      float randomNum = random(1);
      float sum = 0;
      int memberIdx = 0;
      while(sum < randomNum && memberIdx < popSize){
        sum += population.get(memberIdx).getFitness();
        memberIdx++;
      }
      selected.add(population.get(memberIdx-1));
    }
    population = selected;
  }
  
  void mutate() {
    ArrayList<Chromo> mutated = new ArrayList<Chromo>();
    for(int i = 0; i < popSize; i++) {
      // assumed 32 bit grey code representation used for mutation
      Chromo member = population.get(i);
      char[] chromo = member.toGreyCodeCharArray();
      // apply mutation (don't mutate the sign bit)
      for(int j = 0; j < chromo.length; j++) {
        float randomNumber = random(1);
        if(j % 32 != 0 && randomNumber < mutationRate) {
          if(chromo[j] == '1') chromo[j] = '0';
          else if(chromo[j] == '0') chromo[j] = '1';
        }
      }
      // convert back to values and set
      member.setValuesFromGreyCodeCharArray(chromo);
      mutated.add(new Chromo(member.getX(), member.getY(), member.getTag()));
    }
    population = mutated;
  }
  
  // applies uniform crossover between members of matching tags
  void crossover() {
    partitionPopulation();
    ArrayList<Chromo> crossedOver = new ArrayList<Chromo>();
    for(int tag = 0; tag < numberOfTags; tag++) {
      for(int j = 0; j < popSize; j += 2) {
        if(partitionedPopulation[tag][j] != null && partitionedPopulation[tag][j+1] != null) {
          // roll dice
          float randomNumber = random(1);
          if (randomNumber < crossoverRate) {
          // if over, apply crossover
            char[] chromo1 = partitionedPopulation[tag][j].toGreyCodeCharArray();
            char[] chromo2 = partitionedPopulation[tag][j+1].toGreyCodeCharArray();
            char[] childChromo1 = new char[chromo1.length];
            char[] childChromo2 = new char[chromo2.length];
            Chromo child1 = new Chromo(tag);
            Chromo child2 = new Chromo(tag);
            for(int k = 0; k < chromo1.length; k++) {
              float randomNumberForMask = random(1);
              if(randomNumberForMask < uniformCrossoverBitRate) {
                childChromo1[k] = chromo2[k];
                childChromo2[k] = chromo1[k];
              } else {
                childChromo1[k] = chromo1[k];
                childChromo2[k] = chromo2[k];                
              }
            }
            child1.setValuesFromGreyCodeCharArray(childChromo1);
            child2.setValuesFromGreyCodeCharArray(childChromo2);
            crossedOver.add(child1);
            crossedOver.add(child2);
          } else {
          // else copy parents directly
            crossedOver.add(
              new Chromo(partitionedPopulation[tag][j].getX(), 
                partitionedPopulation[tag][j].getY(),
                partitionedPopulation[tag][j].getTag()));
            crossedOver.add(
              new Chromo(partitionedPopulation[tag][j+1].getX(),
                partitionedPopulation[tag][j+1].getY(),
                partitionedPopulation[tag][j+1].getTag()));
          }
        } else if (partitionedPopulation[tag][j] != null && partitionedPopulation[tag][j+1] == null) {
          // copy single parent directly
          crossedOver.add(
              new Chromo(partitionedPopulation[tag][j].getX(), 
                partitionedPopulation[tag][j].getY(),
                partitionedPopulation[tag][j].getTag()));
        } else {
          break;
        }
      }
    }
    population = crossedOver;
  }
  
  // fills 2d array with subpopulations and compute subpopulation sizes
  void partitionPopulation() {
    partitionedPopulation = new Chromo[numberOfTags][popSize];
    subpopSize = new int[numberOfTags];
    for(int i = 0; i < popSize; i++) {
      int tag = population.get(i).getTag();
      partitionedPopulation[tag][subpopSize[tag]++] = population.get(i);
    }
  }
  
  void printPopulation() {
    for(int i = 0; i < popSize; i++) {
      println(population.get(i));
    }
  }
  
  void display() {
    for(int i = 0; i < population.size(); i++) {
      population.get(i).display();
    }
  }
}