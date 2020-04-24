const scrollNav = () => {
  window.onscroll = () => {
    const nav = document.querySelector('#homepage-navbar');
    const img = document.querySelector('#white-t');
    const bimg = document.querySelector('#blue-t');
    if(window.scrollY <= 537) {
      nav.classList.remove('navbar-standard')
      img.classList.remove('d-none')
      bimg.classList.add('d-none')
    } else {
      bimg.classList.remove('d-none')
      img.classList.add('d-none')
      nav.classList.add('navbar-standard')
    }
  };
}

export { scrollNav }
