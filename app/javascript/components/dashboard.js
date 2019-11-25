const cards = document.querySelectorAll('.dashboard-card');
console.log(cards);
console.log('hello');

cards.forEach((card) => {
  card.addEventListener('click', (e) => {
    const profileCards = document.querySelectorAll('.profile-card')
    profileCards.forEach((card) => {
      card.classList.add('d-none')
      card.classList.remove('text-secondary')
  });
    document.getElementById(card.dataset.selector).classList.toggle('d-none')
    e.currentTarget.classList.add('text-secondary')
  });
});
