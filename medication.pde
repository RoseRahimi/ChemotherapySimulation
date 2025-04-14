class Chemo {
  float x, y;
  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxspeed;
  float maxforce;
  ArrayList<Cancer> count;
  int counter;
  Chemo(float x_, float y_) {
    x = x_;
    y = y_;
    location = new PVector(x, y);
    velocity = PVector.random2D();
    velocity.setMag(random(1, 4));
    acceleration = new PVector (0, 0);
    maxspeed = 2;
    maxforce = 1;
    count = new ArrayList<Cancer>();
  }
  void display() {
    x = location.x;
    y = location.y;
    fill(0);//blue
    ellipse(x, y, 12, 12);
  }
  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void update() {   // using pvectors to move
    velocity.add(acceleration);
    location.add(velocity);
    velocity.limit(maxspeed);
    acceleration.mult(0);
  }

  void flock(ArrayList<Chemo> Chemos, Cancer cancers, ArrayList<Cancer> cancer) {
    PVector sep = separate(Chemos);   // Separation
    PVector alignment = align(Chemos);      // Alignment
    PVector cohesion = cohesion(Chemos);   // Cohesion
    PVector seek = seek(cancer);
    // Arbitrarily weight these forces
    sep.mult(1);
    alignment.mult(0.5);
    cohesion.mult(0.6);
    seek.mult(0.5);
    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(alignment);
    applyForce(cohesion);
    applyForce(seek);
  }

  // Method to seek the nearest Cancer cell
  PVector seek(ArrayList<Cancer> cancers) {
    Cancer nearestCancer = findNearestCancer(cancers);
    if (nearestCancer == null) {
      return new PVector(0, 0);
    }
    // Calculate a vector pointing from the Chemo's position to the nearest cancer cell
    PVector desired = PVector.sub(nearestCancer.position, location);
    desired.setMag(maxspeed); // Set the magnitude to the Chemo's maximum speed
    // Calculate the steering force: desired velocity minus current velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce); // Limit the force to the Chemo's maximum steering force
    return steer;
  }
// Helper method to find the nearest Cancer cell
  Cancer findNearestCancer(ArrayList<Cancer> cancers) {
    Cancer nearest = null;
    float nearestDist = Float.MAX_VALUE;
    // Iterate through all cancer cells to find the nearest one
    for (Cancer cell : cancers) {
      float d = PVector.dist(this.location, cell.position);
      if (d < nearestDist) {
        nearestDist = d;
        nearest = cell;
      }
    }
    return nearest;
  }

  void interactWithCancerCells(ArrayList<Cancer> cancers) {
    for (Cancer cell : cancers) {
      float distance = PVector.dist(location, cell.position);

      if (distance < 15 && !count.contains(cell)) { // Set an appropriate distance for interaction
        count.add(cell);
        counter = count.size();
        cell.decreaseDivisionRate();
      }
    }
  }
  void run(ArrayList<Chemo> Chemos, Cancer cancers, ArrayList<Cancer> cancer) {
    update();
    bounds();
    flock(Chemos, cancers, cancer);
    display();
    interactWithCancerCells(cancer);
  }
  // Alignment
  //For every nearby boid in the system, calculate the average velocity
  PVector align (ArrayList<Chemo> Chemos) {
    float neighbordist = 10;
    PVector steer = new PVector();
    int total = 0;
    for (Chemo chemo : Chemos) {
      float d = PVector.dist(location, chemo.location);
      if ( (d < neighbordist)) {
        steer.add(chemo.velocity);
        total++;
      }
    }
    if (total > 0) {
      steer.div(total);
      steer.setMag(maxspeed);
      steer.sub(velocity);
      //PVector steer = PVector.sub(steer, velocity);
      steer.limit(maxforce);
      return steer;
    } else {
      return new PVector(0, 0);
    }
  }

  //// Cohesion
  //// For the average position (i.e. center) of all nearby boids, calculate steering vector towards that position
  PVector cohesion (ArrayList<Chemo> Chemos) {
    float neighbordist = 100;
    PVector steer = new PVector();
    int total = 0;
    for (Chemo chemo : Chemos) {
      float d = PVector.dist(location, chemo.location);
      if ((d < neighbordist)) {
        steer.add(chemo.location);
        total++;
      }
    }
    if (total > 0) {
      steer.div(total);
      steer.sub(location);
      steer.setMag(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
      return steer;
    } else {
      return new PVector(0, 0);
    }
  }
  //// Separation
  // // Method checks for nearby boids and steers away
  PVector separate (ArrayList<Chemo> Chemos) {
    float neighbordist = 100;
    PVector steer = new PVector(0, 0);
    int total = 0;
    for (Chemo chemo : Chemos) {
      float d = PVector.dist(location, chemo.location);
      if ( (d> 0)&&(d < neighbordist)) {
        PVector  diff = PVector.sub(location, chemo.location);
        diff.normalize();
        diff.div(d);
        steer.add(diff);
        total++;
      }
    }
    if (total > 0) {
      steer.div(total);
      // steer.sub(location);
      steer.setMag(maxspeed);
      PVector steering = PVector.sub(steer, velocity);
      steering.limit(maxforce);
      return steering;
    } else {
      return new PVector(0, 0);
    }
  }
  void bounds() {  // boundaries so that the bugs stay in the stay
    if (location.x > width) {
      location.x = width;
      velocity.x *= -1;
    } else if (location.x < 0) {
      velocity.x *= -1;
      location.x = 0;
    }
    if (location.y > height) {
      velocity.y *= -1;
      location.y = height;
    } else if (location.y < 0 ) {
      velocity.y *= -1;
      location.y = 0;
    }
  }
}
