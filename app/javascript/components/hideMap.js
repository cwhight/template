const map = document.getElementById("map");

const hideMap = () => {
  if (map.style.display === "none") {
    map.style.display = "block";
  } else {
    map.style.display = "none";
  }
}

export { hideMap };
