const apply = document.querySelectorAll(".applyButton")
const applyForm = document.querySelectorAll("#applyForm")
const applyBackButton = document.querySelectorAll(".applyBackButton")

const openApply = () => {
  apply.forEach((btn) => {
  btn.addEventListener("click", (e) => {
    e.currentTarget.nextElementSibling.classList.toggle("hidden")
    e.currentTarget.classList.toggle("hidden")
    console.log(e)
  });
});
};

const closeApply = () => {
  applyBackButton.forEach((btn) => {
   btn.addEventListener("click", (e) => {
    e.currentTarget.parentElement.classList.toggle("hidden")
    e.currentTarget.parentElement.previousElementSibling.classList.toggle("hidden")
  });
 });
}

export { openApply, closeApply };
