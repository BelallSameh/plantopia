#include <ESP8266WiFi.h>
#include <DHT.h>
#include <FirebaseESP8266.h>

#define FIREBASE_HOST "plantopia-acced-default-rtdb.europe-west1.firebasedatabase.app"
#define FIREBASE_AUTH "rxu7DkDMCLXfg2w3KhV3YGAF23z7Yvi2IRIKdhiZ"
#define WIFI_SSID "WE_A20E6E"
#define WIFI_PASSWORD "jah05912"

#define DHTPIN D2
#define DHTTYPE DHT11
DHT dht(DHTPIN, DHTTYPE);

FirebaseData firebaseData;
FirebaseConfig firebaseConfig;
FirebaseAuth firebaseAuth;

void setup() {
  Serial.begin(9600);
  dht.begin();

  Serial.print("Connecting to ");
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print(WIFI_SSID);
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }

  Serial.println();
  Serial.print("Connected. IP Address: ");
  Serial.println(WiFi.localIP());

  // Firebase Configuration
  firebaseConfig.host = FIREBASE_HOST;
  firebaseConfig.signer.tokens.legacy_token = FIREBASE_AUTH;

  // Initialize Firebase
  Firebase.begin(&firebaseConfig, &firebaseAuth);
  Firebase.reconnectWiFi(true);
}

void loop() {
  static unsigned long previousMillis = 0;
  const long interval = 5000;

  if (millis() - previousMillis >= interval) {
    previousMillis = millis();

    float h = dht.readHumidity();
    float t = dht.readTemperature();   

    if (isnan(h) || isnan(t)) {
      Serial.println(F("Failed to read from DHT sensor!"));
      return;
    }

    Serial.print("Humidity: ");
    Serial.print(h);
    Serial.print("%  Temperature: ");
    Serial.print(t);
    Serial.println("°C");

    int soilMoisture = digitalRead(D3);
    int waterLevel = analogRead(A0);
    float waterLevelPercentage = (waterLevel / 1023.0) * 100.0;

    Serial.print("Soil Moisture: ");
    Serial.print(soilMoisture);
    Serial.println("%");

    Serial.print("Water Level: ");
    Serial.print(waterLevelPercentage);
    Serial.println("%");

    if (Firebase.setFloat(firebaseData, "/sensors/Humidity", h) &&
        Firebase.setFloat(firebaseData, "/sensors/Temperature", t) &&
        Firebase.setInt(firebaseData, "/sensors/SoilMoisture", soilMoisture) &&
        Firebase.setFloat(firebaseData, "/sensors/WaterLevel", waterLevelPercentage)) {
      Serial.println("Data sent to Firebase successfully");
    } else {
      Serial.print("Error sending data to Firebase: ");
      Serial.println(firebaseData.errorReason());
    }
  }
}
