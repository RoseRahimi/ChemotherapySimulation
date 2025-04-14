class cancers extends Cancer {
  ArrayList<Cancer> cancers; 
  int population;
  int maxpopulation;

  cancers(PVector c, int co, float divisionRate) {
    super(c, co, divisionRate);
    population = 10;
    cancers = new ArrayList<Cancer>(); // Initialize the ArrayList
    for (int i=0; i<population; i++) {
      int cellcolor = color(random(255), random(255), random(255));
      cancers.add(new Cancer(new PVector(random(width), random(height)), cellcolor, 0.01));
    }
  }

  boolean isDead() {
    return cancers.isEmpty();
  }
  void run() {
    // maxpopulation = cancers.size();
    for (int i = cancers.size() - 1; i >= 0; i--) {
      Cancer cell = cancers.get(i);
      cell.run();
      if (cell.divisionRate <=0) {
        cancers.remove(i);
      }
      if (cell.telomeres > 0 && random(1) < cell.divisionRate ) {
        Cancer newCell = cell.reproduce();
        cancers.add(newCell);
        cell.telomeres -= 1; // Decrease telomeres
      }
      if (cell.finished()) {
        cancers.remove(i);
      }
    }
  }

  void addCancer(Cancer c) {
    cancers.add(c);
  }
}
