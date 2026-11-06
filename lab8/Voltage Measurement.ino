// Task 2: DC Voltage Measurement
#include <LiquidCrystal_I2C.h>
#include <Wire.h>
LiquidCrystal_I2C lcd(0x27, 16, 2);

int voltage1 = A0;
int voltage2 = A1;

void setup() {
  pinMode(voltage1, INPUT);
  pinMode(voltage2, INPUT);
  lcd.init();
  lcd.backlight();
}

void loop() {
  int voltageMsmt = analogRead(voltage2) - analogRead(voltage1);
  float vCalc = (5.0/1023) * voltageMsmt;
  lcd.setCursor(0, 0);
  lcd.print("VOLTAGE: ");
  lcd.print(vCalc);
}
