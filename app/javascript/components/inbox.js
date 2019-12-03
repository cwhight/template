const openOldConv = document.querySelector("#old-conversations-btn")
const oldConv = document.querySelector("#old-conversations")

const openConv = () => {
  openOldConv.addEventListener("click", (e) => {
  oldConv.classList.toggle("d-none")
})
};

export {openConv}
