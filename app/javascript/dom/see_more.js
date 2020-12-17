const seeMoreText = () => {
  const seeMoreBtn = document.getElementById('seeMoreBtn');
  const seeMoreP = document.getElementById('more');
  const dots = document.getElementById('dots');

  if (seeMoreP) {
    seeMoreBtn.addEventListener('click', () => {
      if (seeMoreBtn.innerText.includes('more')) {
        seeMoreBtn.innerText = "See less";
       } else {
        seeMoreBtn.innerText = "See more";
      }
      seeMoreP.classList.toggle("d-none")
      dots.classList.toggle("d-none")
    })
  }
}

export { seeMoreText }