const profileImgLink = () => {
  const profileImages = document.querySelectorAll(".profile-img");

  profileImages.forEach(link => {
    link.addEventListener("click", e => {
      e.preventDefault();
      if (e.currentTarget.dataset.profileUrl) {
        window.location.href = e.currentTarget.dataset.profileUrl;
      }
    })
  })
}

export { profileImgLink }
