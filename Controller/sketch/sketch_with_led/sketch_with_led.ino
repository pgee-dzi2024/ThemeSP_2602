#include <SPI.h>
#include <MFRC522.h>

#define RST_PIN         9          
#define SS_PIN          10         
#define LED_PIN         8   // Пин за външен светодиод (по желание)

MFRC522 mfrc522(SS_PIN, RST_PIN);  

void setup() {
  Serial.begin(9600);   
  while (!Serial);      

  SPI.begin();          
  mfrc522.PCD_Init();   
  
  pinMode(LED_PIN, OUTPUT);
  
  // --- АВТОДИАГНОСТИКА НА ЧЕТЕЦА ---
  Serial.println(F("--- Стартиране на диагностика ---"));
  mfrc522.PCD_DumpVersionToSerial(); // Проверява версията на чипа
  Serial.println(F("---------------------------------"));
  
  Serial.println(F("Системата е готова. Допрете RFID карта..."));
}

void loop() {
  if ( ! mfrc522.PICC_IsNewCardPresent()) {
    return;
  }

  if ( ! mfrc522.PICC_ReadCardSerial()) {
    return;
  }

  // УСПЕШНО ЧЕТЕНЕ: Светваме диода
  digitalWrite(LED_PIN, HIGH);
  
  Serial.print("UID:");
  for (byte i = 0; i < mfrc522.uid.size; i++) {
    Serial.print(mfrc522.uid.uidByte[i] < 0x10 ? " 0" : " ");
    Serial.print(mfrc522.uid.uidByte[i], HEX);
  } 
  Serial.println(); 

  // Изчакваме половин секунда (диодът свети)
  delay(500); 
  digitalWrite(LED_PIN, LOW); // Гасим диода

  mfrc522.PICC_HaltA();
}