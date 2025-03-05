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
