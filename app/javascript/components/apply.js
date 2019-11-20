const apply = document.querySelector(".applyButton")
const applyForm = document.querySelector("#applyForm")
const applyBackButton = document.querySelector(".applyBackButton")

apply.addEventListener("click", (e) => {
  applyForm.classList.toggle("hidden")
  apply.classList.toggle("hidden")
})

applyBackButton.addEventListener("click", (e) => {
  applyForm.classList.toggle("hidden")
  apply.classList.toggle("hidden")
})



export { apply };
