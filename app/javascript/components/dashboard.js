const sidebar = document.querySelector("#sidebar")
const sidebarCollapsers = document.querySelectorAll("#sidebarCollapse")

const collapse = () => {
  if (sidebarCollapsers) {
    sidebarCollapsers.forEach((c) => {
      c.addEventListener('click', (e) => {
      sidebar.classList.toggle('inactive')

      });
    });
  }

}

export { collapse }
