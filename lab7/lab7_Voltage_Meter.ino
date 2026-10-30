#include <LiquidCrystal_I2C.h>
#include <Wire.h>
LiquidCrystal_I2C lcd(0x27, 16, 2);

int voltageV = A0;

void setup() {
  pinMode(voltageV, INPUT);
  lcd.init();
  lcd.backlight();
}

void loop() {
  int voltageMsmt = analogRead(voltageV);
  float vCalc = (5.0/1023) * voltageMsmt;
  lcd.setCursor(0, 0);
  lcd.print("BATT ");
  lcd.print(vCalc);
}
