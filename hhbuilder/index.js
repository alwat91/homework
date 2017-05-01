// Your code goes here
console.log("HI");

function submitForm(){
  var addButton = document.querySelector('form')
  console.log(addButton);
  addButton.addEventListener("submit", function(event) {
    console.log("clicked");
  })
}

window.onload = function(){
  console.log("loaded");
  submitForm();
}
