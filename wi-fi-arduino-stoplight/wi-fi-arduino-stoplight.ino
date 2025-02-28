  #include <ESP8266WiFi.h>	
  #include <stdio.h>
  #include <stdlib.h>
  #include "wi-fi_config.h"

  // Define pins for LEDs
	const int redLED = 16;
	const int yellowLED = 14;
	const int greenLED = 12;

	void setup() {
 
     // Setup serial port
    Serial.begin(115200);
    Serial.println();

    // Begin Wi-Fi (this works)
    WiFi.begin(WIFI_SSID,WIFI_PASS);

	  // Set each LED pin as an OUTPUT
	  pinMode(redLED, OUTPUT);
	  pinMode(yellowLED, OUTPUT);
	  pinMode(greenLED, OUTPUT);
	}

	void loop() {
    //Serial.println("Hello Mars!");
    //delay(1000);

    // Connecting to WiFi...
    //Serial.print("Connecting to ");
    //Serial.print(WIFI_SSID);
    // Loop continuously while WiFi is not connected
    while (WiFi.status() != WL_CONNECTED)
    {
      delay(100);
      Serial.print(".");
    }

    // Connected to WiFi
    //Serial.println();
    Serial.print("Connected to ");
    Serial.print(WIFI_SSID);
    Serial.print(", ");
    //Serial.println();
    Serial.print("IP address: ");
    Serial.println(WiFi.localIP());

	  // Green light ON, Red and Yellow OFF
	  digitalWrite(redLED, LOW);
	  digitalWrite(yellowLED, LOW);
	  digitalWrite(greenLED, HIGH);
	  delay(5000); // Green light stays on for 5 seconds
	  
	  // Yellow light ON, Red and Green OFF (again, after green)
	  digitalWrite(redLED, LOW);
	  digitalWrite(yellowLED, HIGH);
	  digitalWrite(greenLED, LOW);
	  delay(2000); // Yellow light stays on for 2 seconds

	  // Red light ON, Green and Yellow OFF
	  digitalWrite(redLED, HIGH);
	  digitalWrite(yellowLED, LOW);
	  digitalWrite(greenLED, LOW);
	  delay(5000); // Red light stays on for 5 seconds    
	}
