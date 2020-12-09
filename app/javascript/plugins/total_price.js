const iniTotalPrice = () => {
  const startDateInput = document.getElementById('booking_start_date');
  const endDateInput = document.getElementById('booking_end_date');


  const priceNode = document.getElementById("live-price")

  const skillElement = document.getElementById("booking_profile_skill")

  if (startDateInput) {
    endDateInput.addEventListener("change", e => {

      // const skill = document.querySelector("data-profile-skill")
      // const rate = document.querySelector("data-rate")

      const profileSkillId = skillElement.value

      const rateNode = document.querySelector(`[data-profile-skill='ps-${profileSkillId}']`)


      console.log(rateNode)

      // grab the date strings and split them into an array
      const startDateValue = startDateInput.value.split("-")
      const endDateValue = e.target.value.split("-")

      // create date objects based on that array
      const startDateInteger = new Date(startDateValue[0], startDateValue[1], startDateValue[2]);
      const endDateInteger = new Date(endDateValue[0], endDateValue[1], endDateValue[2]);


      const price = ((endDateInteger - startDateInteger) / (1000 * 60 * 60 * 24)) * parseInt(rateNode.dataset.rate, 10)
      priceNode.innerText = `Total price: ${price}$`
    })
  }

  if (skillElement) {
    skillElement.addEventListener("change", (event) => {
      startDateInput.value = ""
      endDateInput.value = ""
      priceNode.innerText = "Total price: 0$"
    })
  
  }

}

export { iniTotalPrice }
