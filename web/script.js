
//const { Console } = require("console");
//const fs = require("fs");
//const myLogger = new Console({
//  stdout: fs.createWriteStream("normalStdout.txt"),
//  stderr: fs.createWriteStream("errStdErr.txt"),
//});
//  myLogger.log("Hello, this is a test.");
//  myLogger.error("This is a test error.");

// Amounts of time for each light to be on in Automatic mode.
//let redtime = 0;
//let yellowtime = 0;
//let greentime = 0;

var redtime;
var yellowtime;
var greentime;
let divider = "_"

function updateVariable(inputId, varName) {
  const value = parseInt(document.getElementById(inputId).value, 10);
  if (!isNaN(value)) {
    window[varName] = value;
  } else {
    document.getElementById(inputId).value = '';  // Clears invalid input
  }
  fetch(`/timechange${divider}${redtime}${divider}${yellowtime}${divider}${greentime}${divider}`, {
  method: 'POST',
  })
  //alert(redtime);
  //document.write(redtime);
  //console.log(`redtime: ${redtime}, yellowtime: ${yellowtime}, greentime ${greentime}`);
}



// Automatic and Manual settings post their individual code words
// (to be picked up by the "monitor.sh" script).
document.getElementById("automaticSettingToggleButton").addEventListener("change", function() {
  if (this.checked) {
    fetch('/automaticon', {
    method: 'POST',
    })
  } else {
    fetch('/automaticoff', {
    method: 'POST',
    })
  }
});
document.getElementById("redLightToggleButton").addEventListener("change", function() {
  if (this.checked) {
    fetch('/redon', {
    method: 'POST',
    })
  } else {
    fetch('/redoff', {
    method: 'POST',
    })
  }
});
document.getElementById("yellowLightToggleButton").addEventListener("change", function() {
  if (this.checked) {
    fetch('/yellowon', {
    method: 'POST',
    })
  } else {
    fetch('/yellowoff', {
    method: 'POST',
    })
  }
});
document.getElementById("greenLightToggleButton").addEventListener("change", function() {
  if (this.checked) {
    fetch('/greenon', {
    method: 'POST',
    })
  } else {
    fetch('/greenoff', {
    method: 'POST',
    })
  }
});

function toggleSwitches(activeId) {
  // The purpose of this section is to make the Automatic setting and the
  // Manual settings (collectively) mutually exclusive:
  // • If you activate an individual light, it will turn the Automatic setting off.
  // • If any of the Manual settings is on and you activate the Automatic setting, 
  // 	it will turn the individual switch(es) off.

  // Set variables
  let automatic_toggle = document.getElementById('automaticSettingToggleButton');
  let red_toggle = document.getElementById('redLightToggleButton');
  let yellow_toggle = document.getElementById('yellowLightToggleButton');
  let green_toggle = document.getElementById('greenLightToggleButton');

  // If Automatic is turned on and any of the individual lights is activated,
  // this will switch the Automatic setting off.
  if (activeId === 'redLightToggleButton' && red_toggle.checked) {
    automatic_toggle.checked = false;
  }
  if (activeId === 'yellowLightToggleButton' && yellow_toggle.checked) {
    automatic_toggle.checked = false;
  }
  if (activeId === 'greenLightToggleButton' && green_toggle.checked) {
    automatic_toggle.checked = false;
  }

  // If any of the Manual light settings are on and the Automatic setting
  // is activated, any individual light switch that is on will turn off.
  if (activeId === 'automaticSettingToggleButton' && automatic_toggle.checked) {
    red_toggle.checked = false;
    yellow_toggle.checked = false;
    green_toggle.checked = false;
  }

}


