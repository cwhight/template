var coll = document.getElementsByClassName("collapsible");
var i;

for (i = 0; i < coll.length; i++) {
  coll[i].addEventListener("click", function() {
    this.classList.toggle("active");
    var content = this.nextElementSibling;
    if (this.classList.contains("active")){
      content.style.height = 0;
    } else {
      content.style.height = content.scrollHeight + "px";
    }
  });
};
