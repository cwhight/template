const colls = document.querySelectorAll(".collapsible");
const filter = document.querySelector("#filter-dropdown");
const filterForm = document.querySelector("#filter-form");

if (filter) {

  filter.addEventListener("click", (e) => {
      e.currentTarget.classList.toggle("active");
      if (e.currentTarget.classList.contains("active")){
        filterForm.style.height = 0;
      } else {
        filterForm.style.height = filterForm.scrollHeight + "px";
      }
    });
}

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

