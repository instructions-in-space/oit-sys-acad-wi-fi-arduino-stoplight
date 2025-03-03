  #include <ESP8266WiFi.h>	
  #include <stdio.h>
  #include <stdlib.h>
  #include "wi-fi_config.h"
  #include <Ethernet.h>

  // Define pins for LEDs
	const int redLED = 16;
	const int yellowLED = 14;
	const int greenLED = 12;

	void setup() {
     // Setup serial port
    Serial.begin(115200);
    Serial.println();

    // Begin Wi-Fi 
    WiFi.begin(WIFI_SSID,WIFI_PASS);

	  // Set each LED pin as an OUTPUT
	  pinMode(redLED, OUTPUT);
	  pinMode(yellowLED, OUTPUT);
	  pinMode(greenLED, OUTPUT);
	}

    // Automatic Mode function
    int automatic_mode() {
      // This line is for debugging purposes (so I can see when the loop
      // restarts).
      Serial.println("----------------------------------------");

      // Notification that we are in "Automatic Mode"
      Serial.println("Automatic mode engaged");

      // Connected to WiFi monitor code
      //Serial.println();
      Serial.print("Connected to ");
      Serial.print(WIFI_SSID);
      Serial.print(", ");
      //Serial.println();
      Serial.print("IP address: ");
      Serial.println(WiFi.localIP());

      // Note:  the yellow light comes on first because that would be the
      //        safest in the situation that the green light were on and
      //        the system reset for some reason (i.e., it wouldn't go
      //        directly from green to red).  If the light were yellow
      //        and it reset, it would just be a very long yellow light,
      //        and if the light were red and it went to yellow and then to
      //        red again, drivers would be puzzled, but it wouldn't cause
      //        any accidents.

	    // Yellow light ON, Red and Green OFF (again, after green)
	    digitalWrite(redLED, LOW);
	    digitalWrite(yellowLED, HIGH);
	    digitalWrite(greenLED, LOW);
      Serial.print("Yellow light on");
      Serial.println();
	    delay(2000); // Yellow light stays on for 2 seconds

	    // Red light ON, Green and Yellow OFF
	    digitalWrite(redLED, HIGH);
	    digitalWrite(yellowLED, LOW);
	    digitalWrite(greenLED, LOW);
      Serial.print("Red light on");
      Serial.println();
	    delay(5000); // Red light stays on for 5 seconds    

      // Green light ON, Red and Yellow OFF
	    digitalWrite(redLED, LOW);
	    digitalWrite(yellowLED, LOW);
	    digitalWrite(greenLED, HIGH);
      Serial.print("Green light on");
      Serial.println();
	    delay(5000); // Green light stays on for 5 seconds

      // Obligatory "return" statement (required for a function)
        return 0;
    }

	void loop() {
    // When not connected to Wi-Fi, the system defaults to "Automatic Mode".
    while (WiFi.status() != WL_CONNECTED) {
      automatic_mode();
    }

    automatic_mode();

	}
