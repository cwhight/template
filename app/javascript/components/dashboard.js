const selectors = document.querySelectorAll('.dashboard-selector');
const profilecards = document.querySelectorAll('.dashboard-card')

selectors.forEach((selector) => {
  selector.addEventListener('click', (e) => {
    profilecards.forEach((card) => {
      card.classList.add('d-none')
      card.classList.remove('text-secondary')
      selectors.forEach((selector) => {
        selector.classList.remove('active')
      });
      e.currentTarget.classList.add('active')
    });
    document.getElementById(selector.dataset.selector).classList.toggle('d-none')
    document.getElementById(selector.dataset.selector).classList.add('text-secondary')
  });
});

const sidebar = document.querySelector("#sidebar")
const sidebarCollapse = document.getElementById("sidebarCollapse")

sidebarCollapse.addEventListener('click', (e) => {
  sidebar.classList.toggle('active')

});


