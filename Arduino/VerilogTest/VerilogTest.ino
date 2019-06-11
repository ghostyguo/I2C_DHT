// source: https://github.com/AdriaanSwan/Verilog-I2C-Slave

#include <Wire.h>

byte value;
int address;

void setup()
{
  value = 0;
  address = 114;
  
  Wire.begin();
  Serial.begin(115200);
  Serial.println("Verilog I2C Test\n\n");

  delay(1000);
}

void loop()
{
/*
  Serial.print("Address\t");
  Serial.println(address);
  Serial.print("Value\t");
  Serial.println(value);

  Wire.beginTransmission(address);
  Wire.write(value);
  int error = Wire.endTransmission();
     
  Serial.print("Result\t");
  Serial.println(error);    
  */

  byte data[5];
  int i=0;
  Wire.requestFrom(address, 5);
  while(Wire.available()) 
  {
    data[i] = Wire.read();
    //Serial.print("Read\t");    
    //Serial.println(data[i]);
    i++;
  }
  Serial.print("Humidity:");
  Serial.print(data[0]*256+data[1]);
  Serial.print("    Temperature:");
  Serial.print(data[2]*256+data[3]);
  Serial.print("    Checksum:");
  Serial.println(data[4]);
   
  value++;
  delay(1000);
}
