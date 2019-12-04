const colls = document.querySelectorAll(".collapsible");



colls.forEach((coll) => {
  coll.addEventListener("click", (e) => {
    e.currentTarget.classList.toggle("active");
    var content = e.currentTarget.nextElementSibling;
    if (e.currentTarget.classList.contains("active")){
      content.style.height = 0;
    } else {
      content.style.height = content.scrollHeight + "px";
    }
  });
})

