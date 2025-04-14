cancers c;
Chemotherapy m;
PVector medication;
int timer;
int endTime; // Initialize with -1 to indicate that the end time is not yet set
int lastRemovalTime; // Stores the time when the last removal happened
void setup() {
  size(1000, 1000);
  endTime = -1;
  background(255);
  lastRemovalTime = 0;
  int cellcolor = color(random(255), random(255), random(255));
  m = new Chemotherapy (500);
  medication = new PVector(999, 0);
  c = new cancers(new PVector(random(width), random(height)), cellcolor, 0.001);
  timer = millis();
}
void removeHalfChemosEveryMinute(Chemotherapy m) {
  int currentTime = millis();
  if (currentTime - lastRemovalTime >= 15000) {
    m.removeHalfChemos();
    lastRemovalTime = currentTime; // Update the last removal time
  }
}
void displayTotalContactedCells() {
  int totalContacted = 0;
  for (Chemo chemo : m.chemos) {
    totalContacted += chemo.counter; // Assuming 'counter' is the field in Chemo
  }
  fill(0); // Text color
  textSize(16);
  text("Total cancer cells contacted by chemos: " + totalContacted, 20, 20);
}
void draw() {
  background(255);
  c.run();
  m.run(c, c.cancers);
  fill(20, 30, 255);
  ellipse(medication.x, medication.y, 40, 40);
  // Clear the area for the counter display
  fill(255); // Use the background color
  noStroke();
  rect(10, 10, 200, 30); // Adjust the size and position as needed
  // Display the updated counter
  displayTotalContactedCells();
  // Call the method to remove half of the Chemos every minute
  removeHalfChemosEveryMinute(m);
  // Check and replenish Chemo objects if needed
  m.replenishChemos();
  // Check if all cancer cells are gone
  if (c.cancers.isEmpty() && endTime == -1) {
    endTime = millis(); // Capture the time when the last cancer cell is gone
  }

  if (endTime > -1) {
    // Calculate and display the time taken
    int elapsedTime = endTime - timer;
    int seconds = (elapsedTime / 1000) % 60;
    int minutes = elapsedTime / 60000;
    text("All cancer cells are gone. Time taken: " + nf(minutes, 2) + ":" + nf(seconds, 2), 50, 150);
  } else {
    // Displaying the ongoing timer
    int elapsedTime = millis() - timer;
    int seconds = (elapsedTime / 1000) % 60;
    int minutes = elapsedTime / 60000;
    text("Time: " + nf(minutes, 2) + ":" + nf(seconds, 2), 50, 100);
  }
}



//random(width), random(height)
void keyPressed() {
  if (key == 'a') {
    save("thissketch.jpg");
    // exit();
  }
}
