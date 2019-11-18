const initUpdateNavbarOnScroll = () => {
  const navbar = document.querySelector('.navbar-lewagon');
  const text = document.getElementById("nav-text");
  if (navbar) {
    window.addEventListener('scroll', () => {
      if (window.scrollY >= window.innerHeight - 120) {
        navbar.classList.add('navbar-lewagon-white');
        text.classList.remove('nav-text');
      } else {
        text.classList.add('nav-text');
        navbar.classList.remove('navbar-lewagon-white');
      }
    });
  }
}

export { initUpdateNavbarOnScroll };
