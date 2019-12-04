const openBtn = document.getElementById("open-apps")
const upcomingBtn = document.getElementById("upcoming")
const oldBtn = document.getElementById("old-jobs")
const openApps = document.getElementById("open-apps-msg")
const upcoming = document.getElementById("upcoming-msg")
const oldJobs = document.getElementById("old-jobs-msg")

const chatWindow = document.getElementById('chat-window-inbox')

const openMessages = () => {
  openBtn.addEventListener("click", (e) => {
    openApps.classList.remove("d-none");
    upcoming.classList.add("d-none");
    oldJobs.classList.add("d-none");
    chatWindow.innerHTML = "";
  })
  upcomingBtn.addEventListener("click", (e) => {
    openApps.classList.add("d-none");
    upcoming.classList.remove("d-none");
    oldJobs.classList.add("d-none");
    chatWindow.innerHTML = "";
  })
  oldBtn.addEventListener("click", (e) => {
    openApps.classList.add("d-none");
    upcoming.classList.add("d-none");
    oldJobs.classList.remove("d-none");
    chatWindow.innerHTML = "";
  })
}


export {openMessages}
