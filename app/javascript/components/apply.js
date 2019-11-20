const apply = document.querySelectorAll(".applyButton")
const applyForm = document.querySelectorAll("#applyForm")
const applyBackButton = document.querySelectorAll(".applyBackButton")

apply.forEach((btn) => {
  btn.addEventListener("click", (e) => {
    e.currentTarget.nextElementSibling.classList.toggle("hidden")
    e.currentTarget.classList.toggle("hidden")
    console.log(e)
  });
});

applyBackButton.forEach((btn) => {
   btn.addEventListener("click", (e) => {
    e.currentTarget.parentElement.classList.toggle("hidden")
    e.currentTarget.parentElement.previousElementSibling.classList.toggle("hidden")
  });
 });


export { apply };
