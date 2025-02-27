	// Define pins for LEDs
	const int redLED = 16;
	const int yellowLED = 14;
	const int greenLED = 12;

	void setup() {
	  // Set each LED pin as an OUTPUT
	  pinMode(redLED, OUTPUT);
	  pinMode(yellowLED, OUTPUT);
	  pinMode(greenLED, OUTPUT);
	}

	void loop() {
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
