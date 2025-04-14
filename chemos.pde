class Chemotherapy {
  ArrayList<Chemo> chemos; 
  int initialChemoCount;
  
  Chemotherapy(int initialCount) {
    chemos = new ArrayList<Chemo>(); // Initialize the ArrayList
    initialChemoCount = initialCount;
    // Initialize with the initial number of Chemo objects
    for (int i = 0; i < initialChemoCount; i++) {
      // Add new Chemo object to the list
      // Assuming Chemo has a constructor that takes x and y coordinates
      chemos.add(new Chemo(999, 0));
    }
  }

  void run(Cancer cancers, ArrayList<Cancer> cancer) {
    for (Chemo chemo : chemos) {
      chemo.run(chemos, cancers, cancer);  // Passing the entire list of boids to each boid individually
    }
  }
  void addChemo(Chemo c) {
    chemos.add(c);
  }

  void replenishChemos() {
    if (chemos.size() == 1) { // Check if only one Chemo is left
      while (chemos.size() < initialChemoCount) {
        // Replenish the list of Chemo objects back to the initial count
        chemos.add(new Chemo(random(width), random(height)));
      }
    }
  }
  void removeHalfChemos() {
    int halfSize = chemos.size() / 2;
    for (int i = 0; i < halfSize; i++) {
      chemos.remove(chemos.size() - 1); // Remove from the end for efficiency
    }
  }
}
