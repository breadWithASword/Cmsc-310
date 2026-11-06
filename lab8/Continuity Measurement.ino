// Task 1: Continuity Measurement
int ledPin = 12;
int probe = 2;
void setup() {
  pinMode(probe, INPUT_PULLUP);
  pinMode(ledPin, OUTPUT); // LED Pin
}

void loop() {
  if (digitalRead(probe) == HIGH) {
    digitalWrite(ledPin, LOW);
  }
  else {
    digitalWrite(ledPin, HIGH);
  }
}
