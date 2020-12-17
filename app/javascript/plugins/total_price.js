const iniTotalPrice = () => {
  const startDateInput = document.getElementById('booking_start_date');


  const priceNode = document.getElementById("live-price")

  const skillElement = document.getElementById("booking_profile_skill")

  if (startDateInput) {
    startDateInput.addEventListener("change", e => {
      if (e.target.value.match(/to/)) {
        const dates = e.target.value.split(' to ').map(date => date.split('-'));
        const startDate = new Date(dates[0][0], parseInt(dates[0][1], 10) - 1, dates[0][2]);
        const endDate = new Date(dates[1][0], parseInt(dates[1][1], 10) - 1, dates[1][2]);
        const numOfDays = (endDate - startDate) / (1000 * 60 * 60 * 24);
        const profileSkillId = skillElement.value
        const rateNode = document.querySelector(`[data-profile-skill='ps-${profileSkillId}']`);
        const rate = parseInt(rateNode.dataset.rate, 10);
        priceNode.innerText = `Total price: ${numOfDays * rate}€`
      }
    })
  }

  if (skillElement) {
    skillElement.addEventListener("change", (event) => {
      startDateInput.value = ""
      priceNode.innerText = "Total price: 0€"
    })
  }
}

export { iniTotalPrice }
