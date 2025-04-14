class Cancer {
  float x, y;
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifetime, r;
  float telomeres;
  float divisionRate;
  int cellcolor;
  Cancer(PVector c, int co, float divisionRate) {
    cellcolor =co;
    this.divisionRate = divisionRate;
    position = c.copy();
    velocity = PVector.random2D();
    //velocity.setMag(random(-1, 1));
    acceleration = new PVector (0, 0);
    r = 16;
    lifetime = 255;
    telomeres = random(10);
  }
 void mutate() {
    float mutateRate = 0.0001;

    if (random(1) < mutateRate) {
      telomeres += random(-20, 20);
    }
  }

  Cancer reproduce() {
    //add a new CellWalker to the grid
    Cancer c = new Cancer(position, cellcolor, divisionRate);
    c.telomeres = telomeres;
    mutate();
    return c;
  }

  boolean finished() {
    if (lifetime<0) {
      return true;
    } else {
      return false;
    }
  }
  void run() {
    step();
    display();
  }
  void decreaseDivisionRate() {
    divisionRate -= 0.001; // Adjust the decrement value as needed
    divisionRate = max(divisionRate, 0); // Ensure division rate doesn't go below zero
  }

  void display() {
    stroke(cellcolor, lifetime);
    fill(cellcolor, lifetime);
    ellipse(position.x, position.y, r, r);
  }
  void step() {

    velocity = new PVector(random(-2, 2), random(-2, 2));
    position.add(velocity);
    lifetime -= 0.5;

    position.x = constrain(position.x, 0, width-1);
    position.y = constrain(position.y, 0, height-1);
  }
}
