const profileLinks = () => {
  const reviewLinks = document.querySelectorAll(".review-link");

  reviewLinks.forEach(link => {
    link.addEventListener("click", e => {
      e.preventDefault();
      window.location.href = e.currentTarget.dataset.url;
    })
  })
}

export { profileLinks }